#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Hulk' ) || print "Bail out!
";
}

diag( "Testing Hulk $Hulk::VERSION, Perl $], $^X" );
