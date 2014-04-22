# Copyright (c) 2014  Timm Murray
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, 
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright 
#       notice, this list of conditions and the following disclaimer in the 
#       documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
package UAV::Pilot::ARDrone::Video::Fileno;
use v5.14;
use warnings;
use Moose;
use namespace::autoclean;
use Fcntl;

extends 'UAV::Pilot::ARDrone::Video';


sub BUILDARGS
{
    my ($class, $args) = @_;
    my $io = $class->_build_io( $args );

    $$args{'_io'} = $io;
    delete $$args{'host'};
    delete $$args{'port'};
    return $args;
}

sub fileno
{
    my ($self, $do_clear_close_on_exec) = @_;
    $do_clear_close_on_exec //= 1;

    my $in = $self->_io;
    if( $do_clear_close_on_exec ) {
        # Clear the close-on-exec flag
        my $flags = fcntl( $in, F_GETFD, 0 )
            or die "fcntl F_GETFD: $!";
        fcntl( $in, F_SETFD, $flags & ~FD_CLOEXEC )
            or die "fcntl F_SETFD: $!";
    }

    return fileno $in;
}

sub init_event_loop
{
    # Do nothing, successfully
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
__END__

