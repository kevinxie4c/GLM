# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl GLM.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('GLM') }; 

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

use Math::Trig;

my $identity = GLM::Mat4->new(1.0);
my $v = GLM::Vec3->new(1.0, 0.0, 0.0);
my $R = GLM::Functions::rotate(pi, $v);
my $R_ = GLM::Mat4->new(
    1.0,  0.0,  0.0, 0.0,
    0.0, -1.0,  0.0, 0.0,
    0.0,  0.0, -1.0, 0.0,
    0.0,  0.0,  0.0, 1.0
);

my $is_equal = 1;
my $diff = $R - $R_;
for my $i(0 .. 3) {
    for my $j(0 .. 3) {
	$is_equal = 0 if abs($diff->ele($i, $j) > 1e-6)
    }
}
ok($is_equal, "rotate(angle, v)");
