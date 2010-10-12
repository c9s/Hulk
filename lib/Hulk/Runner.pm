package Hulk::Runner;
use warnings;
use strict;
use Hulk::Result;
use Any::Moose;
use Try::Tiny;

# base class name 
has base =>  ( is => 'rw', default => sub { 'Hulk::Do' });

has debug => ( is => 'rw', default => sub { 0 } );

has do_require => ( is => 'rw' );

has do_object => ( is => 'rw' );

sub get_do_class {
	my ($self,$name) = @_;
    return $self->base . '::' . $name;
}

sub report_error {
    my ( $self, $message ) = @_;
	return Hulk::Result->new(
		error => 1,
		message => $message,
	);
}

sub can_run {
    my ( $self, $name ) = @_;
    my $class = $self->get_do_class($name);
    eval qq{require $class;};
    if ($@) {
        warn "$class doesn't exist.";
        return;
    }
    return 1;
}

sub start {
	my ($self,$name,$args) = @_;
	return $self->report_error( "Hulk:: Argument is not defined." ) unless $args;

	return $self->report_error( "Hulk:: What to 'do' ?" ) unless $name;

	my $class = $self->get_do_class($name);

	my $error;
	try {
		# eval qq{require $class;};
		if( $@ ) {
			die "Hulk:: Error on $class: $!";
		}
        my $do_object = $class->new( name => $name, args => $args );
		$do_object->run();
		$self->do_object( $do_object );
	} 
	catch {
        $error = $self->report_error( $self->debug ? $_ : 'Error' );
	};
	return $error if $error;

	my $do_result = $self->do_object->result;
    return $do_result if ($do_result);
    return $self->report_error("Hulk:: Unknown error");
}

1;
