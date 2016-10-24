package Pedidos::Controller::Atendimento;
use Moose;
use namespace::autoclean;

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

sub index :Path('atendimento/') :Args(0) {
    my ( $self, $c ) = @_;
    my @pedidos;
    #TODO: Vai mostrar os pedidos dependendo da fila 
    
    #@pedidos = $c->model ('DB::Pedido')->search ({
    #});

    $c->stash->{'pedidos'}      = \@pedidos;
    $c->stash->{'current_view'} = 'TT';
    $c->stash->{'template'}     = 'atendimento/index.tt2';
    $c->stash->{'css'}          = '../static/css/atendimento.css';
}

=head2 login

The root page (/)

=cut

sub login :Path('atendimento/login') :Args(0) {
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
            $c->res->redirect ($c->uri_for ('atendimento'));
        } else {
            $c->flash->{message} = "Usuário e/ou senha inválidos.";
            $c->res->redirect ($c->uri_for ('login'));
        }
    #}
}

=head2 logout

The root page (/)

=cut

sub logout :Path('atendimento/logout') :Args(0) {
    my ( $self, $c ) = @_;
    
    undef ($c->session);
    undef ($c->flash);
    $c->logout;
    $c->res->redirect ('atendimento');
}

=head2 get_itens_pedido

The root page (/)

=cut

sub get_itens_pedido :Path('atendimento/get_itens_pedido') :Args(1) {
    my ( $self, $c, $pedido ) = @_;
    my @itens;
    my $msg;

    try {
        @itens = $c->model('DB::PedidoItem')->search({
            pedido => $pedido,
        });
        $c->res->content_type ('application/json');
        $c->res->body (encode_json (@itens));
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);      
    };
}


=head2 index

The root page (/)

=cut

sub add_item :Path('atendimento/add_item') :Args(0) {
    my ( $self, $c ) = @_;
    my $item;
    my $msg;

    try {
        $item = $c->model('DB::Item')->update_or_create ({
            codigo    => $c->req->param('codigo'),
            resumo    => $c->req->param('resumo'),
            descricao => $c->req->param('descricao'),
            quant     => $c->req->param('quantidade'),
        });
        $c->res->content_type ('application/text');
        $c->res->body ($item->codigo);
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);
    };
}

=head2 index

The root page (/)

=cut

sub get_item_name :Path('atendimento/get_item_name') :Args(1) {
    my ( $self, $c, $codigo ) = @_;
    my $item;
    my $msg;

    try {
        $item = $c->model('DB::Item')->find ($codigo);
        $c->res->content_type ('application/json');
        $c->res->body (encode_json ($item));
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);
    };
}


=head2 index

The root page (/)

=cut

sub atender_pedido :Path('atendimento/atender') :Args(1) {
    my ( $self, $c, $pedido ) = @_;
    my %item_count;
    my $pit;
    my $msg;

    try {
        $c->model('DB')->txn_do ( sub {
            foreach (my $i = 0; $i < $c->req->param ('itemPatFieldCount'); $i++) {
                $item_count{$c->req->param ('itemAtendPedido')} = 0 if (!$item_count{$c->req->param ('itemAtendPedido')});
                $c->model('DB::PatrimonioItemPedido')->create ({
                    pedido     => $pedido,
                    codigo     => $c->req->param ('itemAtendPedido' . $i),
                    patrimonio => $c->req->param ('itemPatAtendPedido' . $i),
                });
                $item_count{$c->req->param ('itemAtendPedido')}++;
            }
            while (my ($key, $value) = each (%item_count)) {
                $c->model('DB::PedidoItem')->search ({
                    pedido => $pedido,
                    codigo => $key,
                })->update ({
                    quant_atend => $value
                });
            }
        });
        $c->res->content_type ('application/text');
        $c->res->body ($pedido);
    } catch {
        $msg = $_;
        $c->res->status (500);
        $c->res->body ($msg);
    };
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->res->status (404);
    $c->res->body ('Not found');
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
