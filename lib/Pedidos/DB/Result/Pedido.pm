use utf8;
package Pedidos::DB::Result::Pedido;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Pedidos::DB::Result::Pedido

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

=head1 TABLE: C<pedido>

=cut

__PACKAGE__->table("pedido");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'pedido_id_seq'

=head2 solicitante

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 comarca_setor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 obs

  data_type: 'text'
  is_nullable: 0

=head2 fila

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 status

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 data_pedido

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "pedido_id_seq",
  },
  "solicitante",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "comarca_setor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "obs",
  { data_type => "text", is_nullable => 0 },
  "fila",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "status",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "data_pedido",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 comarca_setor

Type: belongs_to

Related object: L<Pedidos::DB::Result::ComarcaSetor>

=cut

__PACKAGE__->belongs_to(
  "comarca_setor",
  "Pedidos::DB::Result::ComarcaSetor",
  { id => "comarca_setor" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 fila

Type: belongs_to

Related object: L<Pedidos::DB::Result::Fila>

=cut

__PACKAGE__->belongs_to(
  "fila",
  "Pedidos::DB::Result::Fila",
  { id => "fila" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 patrimonio_item_pedidoes

Type: has_many

Related object: L<Pedidos::DB::Result::PatrimonioItemPedido>

=cut

__PACKAGE__->has_many(
  "patrimonio_item_pedidoes",
  "Pedidos::DB::Result::PatrimonioItemPedido",
  { "foreign.pedido" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pedido_items

Type: has_many

Related object: L<Pedidos::DB::Result::PedidoItem>

=cut

__PACKAGE__->has_many(
  "pedido_items",
  "Pedidos::DB::Result::PedidoItem",
  { "foreign.pedido" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 status

Type: belongs_to

Related object: L<Pedidos::DB::Result::Status>

=cut

__PACKAGE__->belongs_to(
  "status",
  "Pedidos::DB::Result::Status",
  { id => "status" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-01 00:40:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nkdU8dVzS5Gd5qL9BGoIxQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
