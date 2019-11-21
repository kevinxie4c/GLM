#!/usr/bin/env perl
# generate methods in GLM.xs using GLM.tp.xs
use strict;
use warnings;

open my $fin, '<GLM.tp.xs';
open my $fout, '>GLM.xs';
while (<$fin>) {
    print $fout $_;
    if (/### auto generated methods for <(.*)>/) {
        my $type = $1;
        my $true_type = lc $type;
        print $fout <<"CODE";
$type *
${type}::add(...)
PREINIT:
    $true_type *other_v;
    float other_s;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    if (sv_derived_from(ST(1), "${type}Ptr"))
    {
        other_v = ($true_type *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new $true_type(*THIS + *other_v);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new $true_type(*THIS + other_s);
    }
OUTPUT:
    RETVAL

$type *
${type}::minus(...)
PREINIT:
    $true_type *other_v;
    float other_s;
    int swap;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    swap = 0;
    if (items == 3)
        swap = SvTRUE(ST(2));
    if (sv_derived_from(ST(1), "${type}Ptr"))
    {
        other_v = ($true_type *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new $true_type(!swap ? *THIS - *other_v : *other_v - *THIS);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new $true_type(!swap ? *THIS - other_s : other_s - *THIS);
    }
OUTPUT:
    RETVAL

$type *
${type}::mul(...)
PREINIT:
    $true_type *other_v;
    float other_s;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    if (sv_derived_from(ST(1), "${type}Ptr"))
    {
        other_v = ($true_type *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new $true_type(*THIS * *other_v);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new $true_type(*THIS * other_s);
    }
OUTPUT:
    RETVAL

$type *
${type}::div(...)
PREINIT:
    $true_type *other_v;
    float other_s;
    int swap;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    swap = 0;
    if (items == 3)
        swap = SvTRUE(ST(2));
    if (sv_derived_from(ST(1), "${type}Ptr"))
    {
        other_v = ($true_type *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new $true_type(!swap ? *THIS / *other_v : *other_v / *THIS);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new $true_type(!swap ? *THIS / other_s : other_s / *THIS);
    }
OUTPUT:
    RETVAL
### auto generation end
CODE
    }
}
