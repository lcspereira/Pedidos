use strict;
use warnings;

use Pedidos;

my $app = Pedidos->apply_default_middlewares(Pedidos->psgi_app);
$app;

