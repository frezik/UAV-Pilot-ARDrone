#!/usr/bin/perl
use v5.14;
use warnings;
use AnyEvent;
use UAV::Pilot::ARDrone::Driver::Mock;
use UAV::Pilot::ARDrone::Video::Mock;
use UAV::Pilot::Events;
use UAV::Pilot::SDL::Events;
use UAV::Pilot::SDL::Video;
use UAV::Pilot::SDL::Window;
use UAV::Pilot::Video::H264Decoder;


{
    my $cv = AnyEvent->condvar;
    my $events = UAV::Pilot::Events->new({
        condvar => $cv,
    });

    my $driver = UAV::Pilot::ARDrone::Driver::Mock->new({
        host => 'localhost',
    });
    $driver->connect;

    my $window = UAV::Pilot::SDL::Window->new;

    my $vid_display = UAV::Pilot::SDL::Video->new;
    my @displays = ($vid_display);
    my @h264_handlers = (UAV::Pilot::Video::H264Decoder->new({
        displays => \@displays,
    }));
    $vid_display->add_to_window( $window );

    my $video = UAV::Pilot::ARDrone::Video::Mock->new({
        fh       => \*STDIN,
        handlers => \@h264_handlers,
        condvar  => $cv,
        driver   => $driver,
    });

    my $sdl_events = UAV::Pilot::SDL::Events->new;

    $events->register( $_ ) for $sdl_events, $window;
    $_->init_event_loop for $video, $events;
    $cv->recv;
}
