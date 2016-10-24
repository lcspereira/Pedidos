use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Pedidos';
use Pedidos::Controller::UsuPedidos;

ok( request('/usupedidos')->is_success, 'Request should succeed' );
done_testing();
