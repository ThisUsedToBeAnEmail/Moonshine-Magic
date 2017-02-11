package Moonshine::Magic::Role;
use Carp qw/croak/;
use MOP::Class;
use MOP::Role;

sub apply_roles {
  	my ($me, $superclass, @roles) = @_;

  	croak "No roles supplied!" unless @roles;
	my $class = MOP::Class->new($superclass);
	for my $r (@roles) {
		my $role = MOP::Role->new($r);
		for my $meth ( $role->all_methods ) {
			next if $meth->name eq '__ANON__';
			$class->add_method($meth->name, $meth->body);
		}
		$class->does_role($role);
	}
	return $class;
}



1;
