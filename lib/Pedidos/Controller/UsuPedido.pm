package Pedidos::Controller::UsuPedido;
use Moose;
use namespace::autoclean;
use JSON;
use Try::Tiny;
use Data::Printer;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');


=encoding utf-8

=head1 NAME

Pedidos::Controller::Root - Root Controller for Pedidos

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS


=head2 index

The root page (/)

=cut

sub main :Path('pedidos') :Args(0) {
    my ( $self, $c ) = @_;
    my @pedidos;
    my @itens;

    #p($c->user);
    #p($c->user->name);
    #p($c->user->memberof);

    #if (!$c->user) {
    #    $c->res->redirect ($c->uri_for ('login'));
    #}
    #@pedidos = $c->model("DB::Pedido")->search ({
    #    status => 1,
    #});
    @pedidos = $c->model("DB::Pedido")->all;
    @itens   = $c->model("DB::Item")->all;
    
    $c->stash->{pedidos}      = \@pedidos;
    $c->stash->{itens}        = \@itens;
    $c->stash->{current_view} = 'TT';
    $c->stash->{template}     = 'pedidos/index.tt2';
    $c->stash->{css}          = '../static/css/pedidos.css';
}

=head2 login

The root page (/)

=cut

sub login :Path('pedidos/login') :Args(0) {
    my ( $self, $c ) = @_;
    my $auth;

    #if ($c->user) {
    #    $c->res->redirect ($c->uri_for (''));
    #} else {
        $c->stash->{current_view} = 'TT';
        $c->stash->{template}     = 'login.tt2';
        $c->stash->{action}       = $c->uri_for (qw (pedidos login));
        return unless ($c->req->param ('login') && $c->req->param ('senha'));
        
        $auth = $c->authenticate ({
            id       => $c->req->param ('login'),
            password => $c->req->param ('senha'),
        }, 'ldap') or die ($!);
        if ($auth) {
            $c->persist_user;
            $c->res->redirect ($c->uri_for ('pedidos'));
        } else {
            $c->flash->{message} = "Usuário e/ou senha inválidos.";
            $c->res->redirect ($c->uri_for ('login'));
        }
    #}
}

=head2 logout

The root page (/)

=cut

sub logout :Path('pedidos/logout') :Args(0) {
    my ( $self, $c ) = @_;
    
    undef ($c->session);
    undef ($c->flash);
    $c->logout;
    $c->res->redirect ('pedidos');
}

=head2 add_item_pedido

=cut

sub add_item_pedido :Path('pedidos/add_item_pedido') :Args(0) {
    my ( $self, $c ) = @_;
    my @itens_pedido;
    my $msg;
    my $response = '';
    
    try {
        @itens_pedido = $c->session->{'itens_pedido'};
        push (@itens_pedido, {item => $c->req->param ('item'), descr => $c->model('DB::Item')->find($c->req->param('item')), quant => $c->req->param ('quant')});
        $c->session->{'itens_pedido'} = \@itens_pedido;


        foreach (@itens_pedido) {
            $response .= "<tr>";
            $response .= "  <td>" . $_->{'item'} . "</td>";
            $response .= "  <td>" . $_->{'descr'} . "</td>";
            $response .= "  <td>" . $_->{'quant'} . "</td>";
            $response .= "</tr>";
        }
        $c->res->content_type ('application/html');
        $c->res->body ($response);
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);
    };
} 

=head2 enviar_pedido

=cut

sub enviar_pedido :Path('pedidos/enviar_pedido') :Args(0) {
    my ( $self, $c ) = @_;
    my @itens_pedido;
    my $pedido;
    my $msg;

    try {
        $c->model('DB')->txn_do (sub {
            $pedido = $c->model("DB::Pedido")->new ({
                solicitante   => $c->req->param('solicitante'),
                comarca_setor => $c->req->param('comarcaSetorField'),
                obs           => $c->req->param('obsField'),
                fila          => 1,
                status        => 1,
            });
            $pedido->insert;
            @itens_pedido = $c->session->{'itens_pedido'};
            foreach (@itens_pedido) {
                $c->model("DB::PedidoItem")->create ({
                    pedido => $pedido->id,
                    item   => $_->{'item'},
                    quant  => $_->{'quant'}
                });
            }
            $c->res->content_type ('application/text');
            $c->res->body ($pedido->id);
        });
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);
    };
}

=head2 default

Standard 404 error page

=cut

sub details :Path('pedidos/details') :Args(1) {
    my ( $self, $c, $pedido ) = @_;
    my $pedido;
    my $msg;

    try {
        $pedido = $c->model('DB::Pedido')->find ($pedido);
        $c->res->content_type ('application/text');
        $c->res->body (json_encode($pedido));
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);
    }
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->res->status (404);
    $c->res->response ('Not found');
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
