use utf8;
package Pedidos::DB::Result::PedidoItem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Pedidos::DB::Result::PedidoItem

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

=head1 TABLE: C<pedido_item>

=cut

__PACKAGE__->table("pedido_item");

=head1 ACCESSORS

=head2 pedido

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 item

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 quant

  data_type: 'double precision'
  is_nullable: 0

=head2 quant_atend

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "pedido",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "item",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "quant",
  { data_type => "double precision", is_nullable => 0 },
  "quant_atend",
  { data_type => "double precision", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</pedido>

=item * L</item>

=back

=cut

__PACKAGE__->set_primary_key("pedido", "item");

=head1 RELATIONS

=head2 item

Type: belongs_to

Related object: L<Pedidos::DB::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "Pedidos::DB::Result::Item",
  { codigo => "item" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 pedido

Type: belongs_to

Related object: L<Pedidos::DB::Result::Pedido>

=cut

__PACKAGE__->belongs_to(
  "pedido",
  "Pedidos::DB::Result::Pedido",
  { id => "pedido" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-05 14:55:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Qil+GQcJ1Y1+xcr3OdloVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
