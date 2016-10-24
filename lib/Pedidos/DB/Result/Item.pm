use utf8;
package Pedidos::DB::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Pedidos::DB::Result::Item

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<item>

=cut

__PACKAGE__->table("item");

=head1 ACCESSORS

=head2 codigo

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 resumo

  data_type: 'varchar'
  is_nullable: 0
  size: 500

=head2 descricao

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=head2 quant

  data_type: 'double precision'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "codigo",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "resumo",
  { data_type => "varchar", is_nullable => 0, size => 500 },
  "descricao",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
  "quant",
  { data_type => "double precision", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</codigo>

=back

=cut

__PACKAGE__->set_primary_key("codigo");

=head1 RELATIONS

=head2 patrimonio_item_pedidoes

Type: has_many

Related object: L<Pedidos::DB::Result::PatrimonioItemPedido>

=cut

__PACKAGE__->has_many(
  "patrimonio_item_pedidoes",
  "Pedidos::DB::Result::PatrimonioItemPedido",
  { "foreign.item" => "self.codigo" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pedido_items

Type: has_many

Related object: L<Pedidos::DB::Result::PedidoItem>

=cut

__PACKAGE__->has_many(
  "pedido_items",
  "Pedidos::DB::Result::PedidoItem",
  { "foreign.item" => "self.codigo" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-01 00:40:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Yhdra6AFi7n39jtShx+9iw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
