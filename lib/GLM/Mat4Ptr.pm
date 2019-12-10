package GLM::Mat4Ptr;

use strict;
use warnings;
use overload
#    '+' => \&add,
#    '-' => \&minus,
    '*' => \&mul,
#    '/' => \&div,
    '""' => \&to_string,
    ;

sub to_string {
    my $this = shift;
    '[' . $this->vec(0)->to_string . ' ' . $this->vec(1)->to_string . ' ' . $this->vec(2)->to_string . ' ' . $this->vec(3)->to_string . ']';
}

1;
