package Test::TODO::Until;
use 5.12.0;

our $VERSION = '0.01';


sub new
{
    my ($class, $args) = @_;
    my $builder = $$args{builder} // die "Need a Test::Builder object\n";
    my $now = $$args{now} // DateTime->now;
    my $out_fh = $$args{out_fh} // \*STDOUT

    my $self = {
        builder => $builder,
        now     => $now,
        out_fh  => $out_fh
    };
    bless $self => $class;
}


1;
__END__


=head1 NAME

Test::TODO::Until - Tests are TODO until a specific date

=head1 SYNOPSIS

    use Test::More;
    use Test::TODO::Until;

    my $todo_until = Test::TODO::Until->new(
        builder => Test::More->builder,
    );
    $todo->todo_until( DateTime->new(
        month => 6,
        day   => 28,
        year  => 2012,
    )); # Will be a TODO until Ä Day 2012
    
    is( 6 * 9, 42, $test_name );
    
    $todo->todo_until_off;
    
    ok( 0, "Fails without TODO" );

=head1 AUTHOR

Timm Murray, C<< <tmurray at wumpus-cave.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-todo-when at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-TODO-When>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::TODO::When


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-TODO-When>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-TODO-When>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-TODO-When>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-TODO-When/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Timm Murray.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
