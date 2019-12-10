# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl GLM.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 23;
BEGIN { use_ok('GLM') }; 

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $v = new GLM::Vec3(1, 2, 3);
ok($v->x == 1 && $v->y == 2 && $v->z == 3, "GLM::Vec3::new");
my $v1 = new GLM::Vec3(3);
ok($v1->x == 3 && $v1->y == 3 && $v1->z == 3, "GLM::Vec3::new");
my $v2 = new GLM::Vec3($v);
ok($v2->x == 1 && $v2->y == 2 && $v2->z == 3, "GLM::Vec3::new");
my $w = new GLM::Vec4(1, 2, 3, 4);
ok($w->x == 1 && $w->y == 2 && $w->z == 3 && $w->w == 4,, "GLM::Vec4::new");
my $w1 = new GLM::Vec4(4);
ok($w1->x == 4 && $w1->y == 4 && $w1->z == 4 && $w1->w == 4, "GLM::Vec4::new");
my $w2 = new GLM::Vec4($w);
ok($w2->x == 1 && $w2->y == 2 && $w2->z == 3 && $w2->w == 4, "GLM::Vec4::new");

ok($v->to_string eq '[1 2 3]', "GLM::Vec3::to_string");
ok($w->to_string eq '[1 2 3 4]', "GLM::Vec4::to_string");

ok(($v + $v1)->to_string eq '[4 5 6]', "GLM::Vec3::add");
ok(($v + 1)->to_string eq '[2 3 4]', "GLM::Vec3::add");
ok(($v1 - $v)->to_string eq '[2 1 0]', "GLM::Vec3::sub");
ok(($v - 1)->to_string eq '[0 1 2]', "GLM::Vec3::sub");
ok((3 - $v)->to_string eq '[2 1 0]', "GLM::Vec3::sub");
ok((2 * $v)->to_string eq '[2 4 6]', "GLM::Vec3::mul");
ok(($v1 / 3)->to_string eq '[1 1 1]', "GLM::Vec3::div");

my $m = GLM::Mat4->new(
    1, 0, 0, 0,
    0, 2, 0, 0,
    0, 0, 3, 0,
    0, 0, 0, 4,
);
ok(($m * $w)->to_string eq '[1 4 9 16]', "GLM::Mat4::mul");
ok(($m * $m)->to_string eq '[[1 0 0 0] [0 4 0 0] [0 0 9 0] [0 0 0 16]]', "GLM::Mat4::mul");

ok("$v" eq '[1 2 3]', "GLM::Vec3 stringify operator");
ok("$w" eq '[1 2 3 4]', "GLM::Vec4 stringify operator");
ok("$m" eq '[[1 0 0 0] [0 2 0 0] [0 0 3 0] [0 0 0 4]]', "GLM::Mat4 stringify operator");

ok($v->dot($v1) == 18, "GLM::Vec3::dot");
my $e1 = GLM::Vec3->new(1, 0, 0);
my $e2 = GLM::Vec3->new(0, 1, 0);
ok($e1->cross($e2)->to_string eq '[0 0 1]', "GLM::Vec3::cross");
