package UAV::Pilot::ARDrone;
use v5.14;
use warnings;
use Moose;
use namespace::autoclean;

our $VERSION = 0.1;


no Moose;
__PACKAGE__->meta->make_immutable;
1;
__END__


=head1 NAME

  UAV::Pilot::ARDrone

=head1 SYNOPSIS

    my $driver = UAV::Pilot::ARDrone::Driver->new( ... );
    $driver->connect;
    my $dev = UAV::Pilot::ARDrone::Control->new({
        driver => $driver,
    });
    
    $dev->takeoff;
    $dev->pitch( 0.5 );
    $dev->wave;
    $dev->flip_left;
    $dev->land;

=head1 DESCRIPTION

Driver/Control modules for running the Parrot AR.Drone under C<UAV::Pilot>.

=cut
