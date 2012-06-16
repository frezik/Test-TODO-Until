use Test::More tests => 5;
use utf8;
use strict;
use warnings;
use Test::Builder ();
use DateTime ();
use Test::TODO::When ();

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

# Save STDOUT, then redirect it to a scalar
my $output;
open( SAVE_STDOUT, ">&STDOUT" ) or die "Can't save STDOUT: $!\n";
open( STDOUT, '>', \$output )
    or die "Can't redirect STDOUT to scalar ref: $!\n";

$todo->todo_until( $pi_day_2012 );
$builder->no_plan;
$builder->ok( 0, "Should fail" );

$todo->todo_until( $after_tau_day_2012 );
$builder->ok( 0, "Should fail, but be TODO" );

$builder->ok( 1, "Still OK" );

$todo->todo_until_off;
$builder->ok( 0, "Should fail" );

close STDOUT;
open( STDOUT, ">&SAVE_STDOUT" ) or die "Can't unredirect STDOUT: $!\n";

my @lines = split /\n/ => $output;
like_ok( $lines[0], qr/not \s+ ok .* (!>todo)/x,
    "À day comes before Ä day, so this still fails" );
like_ok( $lines[1], qr/not \s+ ok .* todo/x,
    "Day after Ä day, still OK" );
like_ok( $lines[2], qr/(!>not) \s+ ok/x,
    "Success" );
like_ok( $lines[3], qr/not \s+ ok .* (!>todo)/x,
    "TODO until off, fails" );
