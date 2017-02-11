use Moonshine::Test qw/:all/;

use t::roles::NLX;

use lib 't/extends';
use Fairy;

package Test::Bro;

use parent 'UNIVERSAL::Object';

our %HAS;
BEGIN {
    %HAS = (
        bro_rank => sub { return 3; },
    );
}

sub true {
    return 1;
}

sub false {
    return 0;
}

sub bro_rank {
    return $_[0]->{bro_rank}
}

1;

package Test::MiamiSpace;

use parent 'UNIVERSAL::Object';

our %HAS;
BEGIN {
    %HAS = (
        miami => sub {
            return {
                space => {
                    rank => 9,
                }
            };
        }
    );
}

sub plus {
    return 1;
}

sub minus {
    return 0;
}

sub miamispace_rank {
    return $_[0]->{miami}->{space}->{rank};
}

1;

package Test::One;

use Moonshine::Magic;

use parent 'UNIVERSAL::Object';

with 'Test::Bro';
with 'Test::MiamiSpace';
with 't::roles::NLX';

# I only want func - destroy
with 'Fairy';

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

moon_test_one(
    test => 'scalar',
    instance => $instance,
    func => 'nlx_rank',
    expected => 1,
);

moon_test_one(
    test => 'scalar',
    instance => $instance,
    func => 'bro_rank',
    expected => 3,
);

moon_test_one(
    test => 'scalar',
    instance => $instance,
    func => 'miamispace_rank',
    expected => 9,
);

moon_test(
    name => 'three levels',
    instance => $instance,
    instructions => [
        {
            test => 'scalar',
            func => 'destroy',
            expected => 'We made it.',
        },
    ],
);

sunrise(9);
