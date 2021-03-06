package Pedidos::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

=head1 NAME

Pedidos::View::TT - Catalyst View

=head1 DESCRIPTION

Catalyst View.

=cut

__PACKAGE__->config({
    INCLUDE_PATH => [
        Pedidos->path_to( 'root', 'src' ),
        Pedidos->path_to( 'root', 'lib' )
    ],
    WRAPPER      => 'site/wrapper',
    ERROR        => 'error.tt2',
    TIMER        => 0,
    ENCODING     => 'utf-8',
    render_die   => 1,
});


=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
