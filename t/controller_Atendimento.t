use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Pedidos';
use Pedidos::Controller::Atendimento;

ok( request('/atendimento')->is_success, 'Request should succeed' );
done_testing();
