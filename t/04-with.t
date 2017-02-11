use Moonshine::Test qw/:all/;

package Test::Base;

use Moonshine::Magic;
use parent 'UNIVERSAL::Object';

sub true {
    return 1;
}

sub false {
    return 0;
}

1;

package Test::High;

use Moonshine::Magic;
use parent 'UNIVERSAL::Object';

sub plus {
    return 1;
}

sub minus {
    return 0;
}

1;

package Test::One;

use Moonshine::Magic;

use parent 'UNIVERSAL::Object';

with 'Test::Base';
with 'Test::High';

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
    test => 'true',
    instance => $instance,
    func => 'plus',
);

moon_test_one(
    test => 'false',
    instance => $instance,
    func => 'minus',
);

sunrise(4);
