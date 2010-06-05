package MusicBrainz::Server::Controller::User::Collections;
use Moose;

BEGIN { extends 'MusicBrainz::Server::Controller' };

sub view : Chained('/user/base') PathPart('collections')
{
    my ($self, $c) = @_;

    my $user = $c->stash->{user};

    $c->detach('/error_404')
        if (!defined $user);

    my $collections = $self->_load_paged($c, sub {
        $c->model('Collection')->find_by_editor($user->id, shift, shift);
    });

    $c->stash(
        user => $user,
        collections => $collections,
        template => 'user/collections.tt',
    );
}

1;

=head1 COPYRIGHT

Copyright (C) 2010 MetaBrainz Foundation

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
