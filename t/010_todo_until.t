use Test::More tests => 5;
use utf8;
use strict;
use warnings;
use Test::Builder ();
use DateTime ();
use Test::TODO::Until ();


my $tau_day_2012 = DateTime->new(
    month => 6,
    day   => 28,
    year  => 2012,
);
my $pi_day_2012 = DateTime->new(
    month => 3,
    day   => 14,
    year  => 2012,
);
my $after_tau_day_2012 = DateTime->new(
    month => 6,
    day   => 29,
    year  => 2012,
);

# Make sure to get a new Test::Builder object, not the singleton version
# from new()
#
my $builder = Test::Builder->create;


my $todo = Test::TODO::Until->new({
    builder => $builder,
    now     => $tau_day_2012,
});
isa_ok( $todo => 'Test::TODO::Until' );


$todo->todo_until( $pi_day_2012 );

my $output = '';
my $trash  = '';
$builder->no_plan;
$builder->output( \$output );
$builder->failure_output( \$trash );
$builder->todo_output( \$trash );

$builder->ok( 0, "INVISIBLE Should fail" );

$todo->todo_until( $after_tau_day_2012 );
$builder->ok( 0, "INVISIBLE Should fail, but be TODO" );

$builder->ok( 1, "INVISIBLE Still OK" );

$todo->todo_until_off;
$builder->ok( 0, "INVISIBLE Should fail" );

my @lines = split /\n/ => $output;
like( $lines[0], qr/not \s+ ok .* (?!TODO)/x,
    "Pi day comes before Tau day, so this still fails" );
like( $lines[1], qr/not \s+ ok .* TODO/x,
    "Day after Tau day, still OK" );
like( $lines[2], qr/(?!not\s+) ok/x,
    "Success" );
like( $lines[3], qr/not \s+ ok .* (?!TODO)/x,
    "TODO until off, fails" );
