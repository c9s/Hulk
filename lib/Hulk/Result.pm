package Hulk::Result;
use warnings;
use strict;
use Any::Moose;
use JSON::XS;

has success => ( is => 'rw' );
has error   => ( is => 'rw' );
has message => ( is => 'rw' , isa => 'Str' , default => sub { "..." } );
has data    => ( is => 'rw' , isa => 'HashRef' , default => sub { +{  } } );
has do_object  => ( is => 'rw' );

sub to_string {
	my $self = shift;

    my $did = $self->do_object ? $self->do_object->name : undef;
    if( $self->success ) {
        return encode_json( { 
			success => 1,
			did     => $did,
			data    => $self->data,
            message => $self->message,
        });
    }
    elsif ( $self->error ) {
        return encode_json( { 
			error   => 1,
			did     => $did,
			data    => $self->data,
            message => $self->message,
        });
    }

    # XXX:!??
    return encode_json( { 
        did     => $self->do_object->name,
        data    => $self->data,
        message => $self->message,
    });
}

1;
