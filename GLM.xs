#include "src/glm.hpp"

#define isnan isnan

#ifdef __cplusplus
extern "C" {
#endif
#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"
#ifdef __cplusplus
}
#endif

typedef glm::mat4 GLM__Mat4;
typedef glm::vec4 GLM__Vec4;

MODULE = GLM		PACKAGE = GLM::Mat4

GLM::Mat4 *
GLM::Mat4::new(...)
CODE:
    if (items = 1)
        RETVAL = new glm::mat4();
    else if (items = 2)
    {
        if (sv_derived_from(ST(1), "GLM::Mat4"))
            RETVAL = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(1))));
        else
            croak("not type GLM::Mat4");
    }
    else
        croak("too many arguments");
OUTPUT:
    RETVAL

void
GLM::Mat4::DESTROY()

MODULE = GLM		PACKAGE = GLM::Vec4

GLM::Vec4 *
GLM::Vec4::new(...)
CODE:
    if (items == 1)
        RETVAL = new glm::vec4();
    else if (items == 2)
    {
        if (sv_derived_from(ST(1), "GLM::Vec4"))
            RETVAL = INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(1))));
        else
            RETVAL = new glm::vec4((float)SvNV(ST(1)));
        /*
        else
            croak("not type GLM::Vec4");
        */
    }
    else if (items == 5)
        RETVAL = new glm::vec4((float)SvNV(ST(1)), (float)SvNV(ST(2)), (float)SvNV(ST(3)), (float)SvNV(ST(4)));
    else
        croak("too many arguments");
OUTPUT:
    RETVAL

float
GLM::Vec4::x(...)
CODE:
    if (items == 2)
        THIS->x = (float)SvNV(ST(1));
    RETVAL = THIS->x;
OUTPUT:
    RETVAL

float
GLM::Vec4::y(...)
CODE:
    if (items == 2)
        THIS->y = (float)SvNV(ST(1));
    RETVAL = THIS->y;
OUTPUT:
    RETVAL

float
GLM::Vec4::z(...)
CODE:
    if (items == 2)
        THIS->z = (float)SvNV(ST(1));
    RETVAL = THIS->z;
OUTPUT:
    RETVAL

float
GLM::Vec4::w(...)
CODE:
    if (items == 2)
        THIS->w = (float)SvNV(ST(1));
    RETVAL = THIS->w;
OUTPUT:
    RETVAL

void
GLM::Vec4::DESTROY()


INCLUDE: const-xs.inc

