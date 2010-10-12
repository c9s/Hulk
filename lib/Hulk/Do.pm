package Hulk::Do;
use warnings;
use strict;
use Any::Moose;
use Hulk::Result;

has name => (
	is  => 'rw' ,
	isa => 'Str' );

has args => (
	is  => 'rw' ,
	isa => 'HashRef' );

has result => (
	is         => 'rw',
	isa        => 'Hulk::Result' ); 


sub when {
    # TODO: do this when ...

}

sub with {
    # TODO: do this with ...

}

sub run {
    die "run method not defined.";
}

sub success {
    my ( $self, $message, $data ) = @_;
	$data ||= {};
	$self->result(
		Hulk::Result->new(
			success  => 1,
			message  => $message,
			do_object => $self,
			data     => $data,
		));
	return $self;
}

sub error {
    my ( $self, $message ) = @_;
	$self->result(
		Hulk::Result->new(
			error => 1,
			message => $message,
			do_object  => $self,
		));
	return $self;
}

1;
