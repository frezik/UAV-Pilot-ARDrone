use v5.14;
use warnings;
use Module::Build;


my $build = Module::Build->new(
    module_name       => 'UAV::Pilot::ARDrone',
    dist_abstract     => 'UAV::Pilot driver for the Parrot AR.Drone',
    dist_author       => q{Timm Murray <tmurray@wumpus-cave.net>},
    dist_version_from => 'lib/UAV/Pilot/ARDrone.pm',
    license           => 'bsd',
    requires          => {
        perl                      => '>= 5.14.0',
        'namespace::autoclean'    => 0,
        'AnyEvent'                => 0,
        'AnyEvent::ReadLine::Gnu' => 0,
        'IO::Socket::Multicast'   => 0,
        'Math::Trig'              => 0,
        'Moose'                   => 0,
        'MooseX::Event'           => 0,
        'String::CRC32'           => 0,
        'Test::More'              => 0,
        'UAV::Pilot'              => '>= 0.9',
    },
    recommends => {
        'UAV::Pilot::SDL'           => 0,
        'UAV::Pilot::Video::Ffmpeg' => 0,
    },
    share_dir => 'share',

    meta_merge => {
        resources => {
            repository => 'https://github.com/frezik/UAV-Pilot-ARDrone',
        },
    },
);

$build->create_build_script;
