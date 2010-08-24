#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Web::Action::Dispatcher' ) || print "Bail out!
";
}

diag( "Testing Web::Action::Dispatcher $Web::Action::Dispatcher::VERSION, Perl $], $^X" );
