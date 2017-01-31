use Moonshine::Test qw/:all/;

package Test::Base;

use Moonshine::Magic;

extends 'UNIVERSAL::Object';

has (
    true  => sub { return 1 },
    false => sub { return 0 },
    test  => sub { return ['hello']},
);

1;

package Test::One;

use Moonshine::Magic;

extends 'Test::Base';

has (
    test => sub { return ['goodbye'] },
);

package main;

my $instance = Test::One->new();

moon_test_one(
    test => 'true',
    instance => $instance,
    func => 'true',
);

moon_test_one(
    test => 'false',
    instance => $instance,
    func => 'false',
);

moon_test_one(
    test => 'ref_index_scalar',
    index => 0,
    instance => $instance,
    func => 'test',
    expected => 'goodbye',
);

sunrise(3);
