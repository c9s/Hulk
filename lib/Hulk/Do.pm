package Hulk::Do;
use warnings;
use strict;
use Any::Moose;
use Hulk::Result;


=head1 NAME

Hulk::Do - Hulk Action Base Class.

=head1 DESCRIPTION




=head1 SYNOPSIS

To write your own action:

    package Hulk::Do::StopService;
    use warnings;
    use strict;
    use Any::Moose;
    extends qw(Hulk::Do);

    sub run {
        my $self = shift;
        my $args = $self->args;

        my $id = $args->{id};

        return $self->error( "Serivce id required." ) unless $id;


        # ... do something

        ...

        # ... do other stuff
        my $ret = $self->also_do( 'StopOtherService' , { arg1 => ... , arg2 => ... } );

        return $self->success( "Service stopped." );
    }

    1;

Declarative way:

    use Hulk::Declare;

    mount 'StopService' => '/action/path' => run {

    };




=cut

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
			success   => 1,
			message   => $message,
			do_object => $self,
			data      => $data ));
	return $self;
}

sub also_do {
    my ( $self, $action, $args ) = @_;
    my $hulk = Hulk::Runner->new( debug => 1 );
    if ( $hulk->can_run($action) ) {
        return $hulk->start( $action, $args );
    }
    die 'Action not found.';
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
