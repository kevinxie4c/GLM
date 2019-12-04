#include "src/glm.hpp"
#include "src/gtc/matrix_transform.hpp"

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
typedef glm::vec3 GLM__Vec3;

MODULE = GLM		PACKAGE = GLM::Mat4

GLM::Mat4 *
GLM::Mat4::new(...)
CODE:
    if (items == 1)
        RETVAL = new glm::mat4();
    else if (items == 2)
    {
        if (sv_derived_from(ST(1), "GLM::Mat4Ptr"))
            RETVAL = new glm::mat4(*INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(1)))));
        else
            croak("not type GLM::Mat4");
    }
    else
        croak("too many arguments");
OUTPUT:
    RETVAL

MODULE = GLM		PACKAGE = GLM::Mat4Ptr

float 
GLM::Mat4::ele(int i, int j, ...)
CODE:
    if (items < 3 || items > 4)
        croak("expect 2 or 3 arguments but receiving %d", items);
    else if (items == 4)
        (*THIS)[i][j] = (float)SvNV(ST(3));
    RETVAL = (*THIS)[i][j];
OUTPUT:
    RETVAL

GLM::Vec4 * 
GLM::Mat4::vec(int i, ...)
CODE:
    if (items < 2 || items > 3)
        croak("expect 1 or 2 arguments but receiving %d", items);
    else if (items == 3)
    {
        if (sv_derived_from(ST(2), "GLM::Vec4Ptr"))
            (*THIS)[i] = *(INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(2)))));
        else
            croak_xs_usage(cv, "THIS, i, [vec]");
    }
    glm::vec4 v = (*THIS)[i];
    RETVAL = new glm::vec4(v);
OUTPUT:
    RETVAL

SV *
GLM::Mat4::mul(SV *other, ...)
PREINIT:
    glm::mat4 *other_m;
    glm::vec4 *other_v;
    //float other_s;
    glm::mat4 *ret_m;
    glm::vec4 *ret_v;
    //float ret_s;
CODE:
    if (sv_derived_from(other, "GLM::Mat4Ptr"))
    {
        other_m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(other)));
        ret_m = new glm::mat4(*THIS * *other_m);
        RETVAL = newSV(0);
        sv_setref_pv(RETVAL, "GLM::Mat4Ptr", (void*)ret_m);
    }
    else if (sv_derived_from(other, "GLM::Vec4Ptr"))
    {
        other_v = INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(other)));
        ret_v = new glm::vec4(*THIS * *other_v);
        RETVAL = newSV(0);
        sv_setref_pv(RETVAL, "GLM::Vec4Ptr", (void*)ret_v);
    }
    else
    {
        croak("other is neither a GLM::Mat4Ptr nor a GLM::Vec4Ptr");
    }
OUTPUT:
    RETVAL

void * 
GLM::Mat4::pointer()
CODE:
    RETVAL = &(*THIS)[0][0];
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
        if (sv_derived_from(ST(1), "GLM::Vec4Ptr"))
            RETVAL = new glm::vec4(*INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(1)))));
        else
            RETVAL = new glm::vec4((float)SvNV(ST(1)));
        /*
        else
            croak("not type GLM::Vec4Ptr");
        */
    }
    else if (items == 5)
        RETVAL = new glm::vec4((float)SvNV(ST(1)), (float)SvNV(ST(2)), (float)SvNV(ST(3)), (float)SvNV(ST(4)));
    else
        croak("too many arguments");
OUTPUT:
    RETVAL

MODULE = GLM		PACKAGE = GLM::Vec4Ptr

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

void * 
GLM::Vec4::pointer()
CODE:
    RETVAL = &(*THIS)[0];
OUTPUT:
    RETVAL

### auto generated vec methods for <GLM::Vec4>

void
GLM::Vec4::DESTROY()

MODULE = GLM		PACKAGE = GLM::Vec3

GLM::Vec3 *
GLM::Vec3::new(...)
CODE:
    if (items == 1)
        RETVAL = new glm::vec3();
    else if (items == 2)
    {
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            RETVAL = new glm::vec3(*INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(1)))));
        else
            RETVAL = new glm::vec3((float)SvNV(ST(1)));
        /*
        else
            croak("not type GLM::Vec3Ptr");
        */
    }
    else if (items == 4)
        RETVAL = new glm::vec3((float)SvNV(ST(1)), (float)SvNV(ST(2)), (float)SvNV(ST(3)));
    else
        croak("too many arguments");
OUTPUT:
    RETVAL

MODULE = GLM		PACKAGE = GLM::Vec3Ptr

float
GLM::Vec3::x(...)
CODE:
    if (items == 2)
        THIS->x = (float)SvNV(ST(1));
    RETVAL = THIS->x;
OUTPUT:
    RETVAL

float
GLM::Vec3::y(...)
CODE:
    if (items == 2)
        THIS->y = (float)SvNV(ST(1));
    RETVAL = THIS->y;
OUTPUT:
    RETVAL

float
GLM::Vec3::z(...)
CODE:
    if (items == 2)
        THIS->z = (float)SvNV(ST(1));
    RETVAL = THIS->z;
OUTPUT:
    RETVAL

void * 
GLM::Vec3::pointer()
CODE:
    RETVAL = &(*THIS)[0];
OUTPUT:
    RETVAL

### auto generated vec methods for <GLM::Vec3>

GLM::Vec3 *
GLM::Vec3::cross(GLM::Vec3 *other, ...)
CODE:
    RETVAL = new glm::vec3(glm::cross(*THIS, *other));
OUTPUT:
    RETVAL

void
GLM::Vec3::DESTROY()

MODULE = GLM		PACKAGE = GLM::Functions

GLM::Mat4 *
lookAt(GLM::Vec3 *eye, GLM::Vec3 *center, GLM::Vec3 *up)
CODE:
    RETVAL = new glm::mat4(glm::lookAt(*eye, *center, *up));
OUTPUT:
    RETVAL

GLM::Mat4 *
perspective(float fovy, float aspect, float n, float f)
CODE:
    RETVAL = new glm::mat4(glm::perspective(fovy, aspect, n, f));
OUTPUT:
    RETVAL

GLM::Mat4 *
frustum(float left, float right, float bottom, float top, float n, float f)
CODE:
    RETVAL = new glm::mat4(glm::frustum(left, right, bottom, top, n, f));
OUTPUT:
    RETVAL


INCLUDE: const-xs.inc

