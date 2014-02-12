use Test::More tests => 8;
use v5.14;

use_ok( 'UAV::Pilot::ARDrone' );
use_ok( 'UAV::Pilot::ARDrone::Driver' );
use_ok( 'UAV::Pilot::ARDrone::Driver::Mock' );
use_ok( 'UAV::Pilot::ARDrone::Control' );
use_ok( 'UAV::Pilot::ARDrone::Control::Event' );
use_ok( 'UAV::Pilot::ARDrone::NavPacket' );
use_ok( 'UAV::Pilot::ARDrone::Video' );
use_ok( 'UAV::Pilot::ARDrone::Video::Mock' );
