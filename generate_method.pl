#!/usr/bin/env perl
# generate methods in GLM.xs using GLM.tp.xs
use strict;
use warnings;

open my $fin, '<GLM.tp.xs';
open my $fout, '>GLM.xs';
while (<$fin>) {
    print $fout $_;
    if (/### auto generated vec methods for <(.*)>/) {
        my $type = $1;
        my $true_type = lc $type;
        print $fout <<"AUTOCODE";
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

$type *
${type}::normalized()
CODE:
    RETVAL = new $true_type(glm::normalize(*THIS));
OUTPUT:
    RETVAL

$type *
${type}::normalize()
CODE:
    *THIS = glm::normalize(*THIS);
    RETVAL = new $true_type(*THIS);
OUTPUT:
    RETVAL

float
${type}::length()
CODE:
    RETVAL = glm::length(*THIS);
OUTPUT:
    RETVAL

float
${type}::dot($type *other, ...)
CODE:
    RETVAL = glm::dot(*THIS, *other);
OUTPUT:
    RETVAL

$type *
${type}::distance($type *other, ...)
CODE:
    RETVAL = new $true_type(glm::distance(*THIS, *other));
OUTPUT:
    RETVAL
### auto generation end
AUTOCODE
    }
}
