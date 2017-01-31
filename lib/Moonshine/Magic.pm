package Moonshine::Magic;

use 5.006;
use strict;
use warnings;

use UNIVERSAL::Object;
use BEGIN::Lift;
use Moonshine::Element;

=head1 NAME

Moonshine::Magic - d[ o_0 ]b - has, extends, lazy_components

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';


=head1 SYNOPSIS

    use Moonshine::Magic;

=head1 Imports

=head2 extends

    extends 'Moonshine::Component';
    # BEGIN { @ISA = ('Moonshine::Component') } 

=head2 has

    has ( 
        'modify_spec' => sub { { switch => 0, switch_base => 0 } },  
    );

    # BEGIN { @HAS = ( 'modify_spec' => sub { { switch => 0, switch_base => 0 } } }    
    # $self->modify_spec

=head2 lazy_components

    lazy_components (qw/p span h1/);
    # $self->span() - <span></span>

=cut

sub import {
    my $caller = caller;

    BEGIN::Lift::install(
        ($caller, 'extends') => sub {
            no strict 'refs';
            @{"${caller}::ISA"} = @_;
        }
    );

    BEGIN::Lift::install(
        ($caller, 'has') => sub {
            my %args = @_;
            no strict 'refs';
            no warnings 'once';
            %{"${caller}::HAS"} = %args;
            for my $arg (keys %args) {
                *{"${caller}::${arg}"} = sub { return $args{$arg}->(); };
            }
        }
    );

    BEGIN::Lift::install(
        ($caller, 'lazy_components') => sub {
	        my @lazy_components = @_;
            no strict 'refs';
            no warnings 'once';
            for my $component (@lazy_components) {
		        *{"${caller}::${component}"} = sub {
			        my $self = shift;
                   
                    my ($base_args, $build_args) = ();
                    if ($self->can('validate_build')) {
                        ( $base_args, $build_args ) = $self->validate_build({
                            params => $_[0] // {},
                            spec => {
                                tag  => { default => $component },
                                data => 0,
                                ( $_[1] ? %{ $_[1] } : () )
                            }
                        });
                    } else {
                        $base_args = { tag => $component, %{ $_[0] } }; 
                    }

                    return Moonshine::Element->new($base_args);
                }
	        }
        }
    );
}

=head1 AUTHOR

Robert Acock, C<< <thisusedtobeanemail at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-moonshine-magic at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Moonshine-Magic>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Moonshine::Magic

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Moonshine-Magic>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Moonshine-Magic>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Moonshine-Magic>

=item * Search CPAN

L<http://search.cpan.org/dist/Moonshine-Magic/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2017 Robert Acock.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Moonshine::Magic
