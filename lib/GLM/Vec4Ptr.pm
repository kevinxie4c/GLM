package GLM::Vec4Ptr;

use strict;
use warnings;
use overload
    '+' => \&add,
    '-' => \&minus,
    '*' => \&mul,
    '/' => \&div,
    ;

sub to_string {
    my $this = shift;
    '[' . $this->x . ' ' . $this->y . ' ' . $this->z . ' ' . $this->w . ']';
}

1;
