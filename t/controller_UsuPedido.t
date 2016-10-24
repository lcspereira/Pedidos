use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Pedidos';
use Pedidos::Controller::UsuPedido;

ok( request('/usupedido')->is_success, 'Request should succeed' );
done_testing();
