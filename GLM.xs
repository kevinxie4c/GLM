#include "glm-0.9.9.8/glm/glm.hpp"
#include "glm-0.9.9.8/glm/gtx/transform.hpp"

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
            RETVAL = new glm::mat4((float)SvNV(ST(1)));
    }
    else if (items == 5)
    {
        if (sv_derived_from(ST(1), "GLM::Vec4Ptr") && sv_derived_from(ST(2), "GLM::Vec4Ptr") && sv_derived_from(ST(3), "GLM::Vec4Ptr") && sv_derived_from(ST(4), "GLM::Vec4Ptr"))
            RETVAL = new glm::mat4(*INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(1)))), *INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(2)))), *INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(3)))), *INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(4)))));
        else
            croak("invalid arguments");
    }
    else if (items == 17)
        RETVAL = new glm::mat4((float)SvNV(ST(1)), (float)SvNV(ST(2)), (float)SvNV(ST(3)), (float)SvNV(ST(4)), (float)SvNV(ST(5)), (float)SvNV(ST(6)), (float)SvNV(ST(7)), (float)SvNV(ST(8)), (float)SvNV(ST(9)), (float)SvNV(ST(10)), (float)SvNV(ST(11)), (float)SvNV(ST(12)), (float)SvNV(ST(13)), (float)SvNV(ST(14)), (float)SvNV(ST(15)), (float)SvNV(ST(16)));
    else
        croak("invalid arguments");
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
            (*THIS)[i] = *INT2PTR(glm::vec4 *, SvIV((SV*)SvRV(ST(2))));
        else
            croak_xs_usage(cv, "THIS, i, [vec]");
    }
    glm::vec4 v = (*THIS)[i];
    RETVAL = new glm::vec4(v);
OUTPUT:
    RETVAL

SV *
GLM::Mat4::add(SV *other, ...)
PREINIT:
    glm::mat4 *other_m;
    //glm::vec4 *other_v;
    //float other_s;
    glm::mat4 *ret_m;
    //glm::vec4 *ret_v;
    //float ret_s;
CODE:
    if (sv_derived_from(other, "GLM::Mat4Ptr"))
    {
        other_m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(other)));
        ret_m = new glm::mat4(*THIS + *other_m);
        RETVAL = newSV(0);
        sv_setref_pv(RETVAL, "GLM::Mat4Ptr", (void*)ret_m);
    }
    else
    {
        croak("other is neither a GLM::Mat4Ptr nor a GLM::Vec4Ptr");
    }
OUTPUT:
    RETVAL

SV *
GLM::Mat4::minus(SV *other, ...)
PREINIT:
    glm::mat4 *other_m;
    //glm::vec4 *other_v;
    //float other_s;
    glm::mat4 *ret_m;
    //glm::vec4 *ret_v;
    //float ret_s;
CODE:
    if (sv_derived_from(other, "GLM::Mat4Ptr"))
    {
        other_m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(other)));
        ret_m = new glm::mat4(*THIS - *other_m);
        RETVAL = newSV(0);
        sv_setref_pv(RETVAL, "GLM::Mat4Ptr", (void*)ret_m);
    }
    else
    {
        croak("other is neither a GLM::Mat4Ptr nor a GLM::Vec4Ptr");
    }
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
    else if (items == 3)
    {
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            RETVAL = new glm::vec4(*INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(1)))), (float)SvNV(ST(2)));
        else
            croak("GLM::Vec4::new(v, f) -- v is not a GLM::Vec3 instance");
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
GLM::Vec4 *
GLM::Vec4::add(...)
PREINIT:
    glm::vec4 *other_v;
    float other_s;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    if (sv_derived_from(ST(1), "GLM::Vec4Ptr"))
    {
        other_v = (glm::vec4 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec4(*THIS + *other_v);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec4(*THIS + other_s);
    }
OUTPUT:
    RETVAL

GLM::Vec4 *
GLM::Vec4::minus(...)
PREINIT:
    glm::vec4 *other_v;
    float other_s;
    int swap;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    swap = 0;
    if (items == 3)
        swap = SvTRUE(ST(2));
    if (sv_derived_from(ST(1), "GLM::Vec4Ptr"))
    {
        other_v = (glm::vec4 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec4(!swap ? *THIS - *other_v : *other_v - *THIS);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec4(!swap ? *THIS - other_s : other_s - *THIS);
    }
OUTPUT:
    RETVAL

GLM::Vec4 *
GLM::Vec4::mul(...)
PREINIT:
    glm::vec4 *other_v;
    float other_s;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    if (sv_derived_from(ST(1), "GLM::Vec4Ptr"))
    {
        other_v = (glm::vec4 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec4(*THIS * *other_v);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec4(*THIS * other_s);
    }
OUTPUT:
    RETVAL

GLM::Vec4 *
GLM::Vec4::div(...)
PREINIT:
    glm::vec4 *other_v;
    float other_s;
    int swap;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    swap = 0;
    if (items == 3)
        swap = SvTRUE(ST(2));
    if (sv_derived_from(ST(1), "GLM::Vec4Ptr"))
    {
        other_v = (glm::vec4 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec4(!swap ? *THIS / *other_v : *other_v / *THIS);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec4(!swap ? *THIS / other_s : other_s / *THIS);
    }
OUTPUT:
    RETVAL

GLM::Vec4 *
GLM::Vec4::normalized()
CODE:
    RETVAL = new glm::vec4(glm::normalize(*THIS));
OUTPUT:
    RETVAL

GLM::Vec4 *
GLM::Vec4::normalize()
CODE:
    *THIS = glm::normalize(*THIS);
    RETVAL = new glm::vec4(*THIS);
OUTPUT:
    RETVAL

float
GLM::Vec4::length()
CODE:
    RETVAL = glm::length(*THIS);
OUTPUT:
    RETVAL

float
GLM::Vec4::dot(GLM::Vec4 *other, ...)
CODE:
    RETVAL = glm::dot(*THIS, *other);
OUTPUT:
    RETVAL

GLM::Vec4 *
GLM::Vec4::distance(GLM::Vec4 *other, ...)
CODE:
    RETVAL = new glm::vec4(glm::distance(*THIS, *other));
OUTPUT:
    RETVAL
### auto generation end

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
GLM::Vec3::add(...)
PREINIT:
    glm::vec3 *other_v;
    float other_s;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
    {
        other_v = (glm::vec3 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec3(*THIS + *other_v);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec3(*THIS + other_s);
    }
OUTPUT:
    RETVAL

GLM::Vec3 *
GLM::Vec3::minus(...)
PREINIT:
    glm::vec3 *other_v;
    float other_s;
    int swap;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    swap = 0;
    if (items == 3)
        swap = SvTRUE(ST(2));
    if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
    {
        other_v = (glm::vec3 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec3(!swap ? *THIS - *other_v : *other_v - *THIS);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec3(!swap ? *THIS - other_s : other_s - *THIS);
    }
OUTPUT:
    RETVAL

GLM::Vec3 *
GLM::Vec3::mul(...)
PREINIT:
    glm::vec3 *other_v;
    float other_s;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
    {
        other_v = (glm::vec3 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec3(*THIS * *other_v);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec3(*THIS * other_s);
    }
OUTPUT:
    RETVAL

GLM::Vec3 *
GLM::Vec3::div(...)
PREINIT:
    glm::vec3 *other_v;
    float other_s;
    int swap;
CODE:
    if (items < 2 || items > 3)
        croak_xs_usage(cv, "THIS, other, ...");
    swap = 0;
    if (items == 3)
        swap = SvTRUE(ST(2));
    if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
    {
        other_v = (glm::vec3 *)SvIV((SV*)SvRV(ST(1)));
        RETVAL = new glm::vec3(!swap ? *THIS / *other_v : *other_v / *THIS);
    }
    else
    {
        other_s = (float)SvNV(ST(1));
        RETVAL = new glm::vec3(!swap ? *THIS / other_s : other_s / *THIS);
    }
OUTPUT:
    RETVAL

GLM::Vec3 *
GLM::Vec3::normalized()
CODE:
    RETVAL = new glm::vec3(glm::normalize(*THIS));
OUTPUT:
    RETVAL

GLM::Vec3 *
GLM::Vec3::normalize()
CODE:
    *THIS = glm::normalize(*THIS);
    RETVAL = new glm::vec3(*THIS);
OUTPUT:
    RETVAL

float
GLM::Vec3::length()
CODE:
    RETVAL = glm::length(*THIS);
OUTPUT:
    RETVAL

float
GLM::Vec3::dot(GLM::Vec3 *other, ...)
CODE:
    RETVAL = glm::dot(*THIS, *other);
OUTPUT:
    RETVAL

GLM::Vec3 *
GLM::Vec3::distance(GLM::Vec3 *other, ...)
CODE:
    RETVAL = new glm::vec3(glm::distance(*THIS, *other));
OUTPUT:
    RETVAL
### auto generation end

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

GLM::Mat4 *
ortho(float left, float right, float bottom, float top, float n, float f)
CODE:
    RETVAL = new glm::mat4(glm::ortho(left, right, bottom, top, n, f));
OUTPUT:
    RETVAL

GLM::Mat4 *
rotate(...)
PREINIT:
    glm::mat4 *m;
    glm::vec3 *v;
CODE:
    if (items == 2)
    {
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            v = INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(1))));
        else
            croak("GLM::Functions::rotate(angle, v) -- v is not a GLM::Vec3 instance");
        RETVAL = new glm::mat4(glm::rotate((float)SvNV(ST(0)), *v));
    }
    else if (items == 3)
    {
        if (sv_derived_from(ST(0), "GLM::Mat4Ptr"))
            m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(0))));
        else
            croak("GLM::Functions::rotate(m, angle, v) -- m is not a GLM::Mat4 instance");
        if (sv_derived_from(ST(2), "GLM::Vec3Ptr"))
            v = INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(2))));
        else
            croak("GLM::Functions::rotate(m, angle, v) -- v is not a GLM::Vec3 instance");
        RETVAL = new glm::mat4(glm::rotate(*m, (float)SvNV(ST(1)), *v));
    }
    //else if (items == 4)
    //    RETVAL = new glm::mat4(glm::rotate((float)SvNV(ST(0)), (float)SvNV(ST(1)), (float)SvNV(ST(2)), (float)SvNV(ST(3))));
    //else if (items == 5)
    //{
    //    if (sv_derived_from(ST(0), "GLM::Mat4Ptr"))
    //        m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(0))));
    //    else
    //        croak("GLM::Functions::rotate(m, angle, x, y, z) -- m is not a GLM::Mat4 instance");
    //    RETVAL = new glm::mat4(glm::rotate(*m, (float)SvNV(ST(1)), (float)SvNV(ST(2)), (float)SvNV(ST(3)), (float)SvNV(ST(4))));
    //}
    else
        croak("GLM::Functions::rotate -- invalid number of arguments");
OUTPUT:
    RETVAL

GLM::Mat4 *
scale(...)
PREINIT:
    glm::mat4 *m;
    glm::vec3 *v;
CODE:
    if (items == 1)
    {
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            v = INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(0))));
        else
            croak("GLM::Functions::scale(v) -- v is not a GLM::Vec3 instance");
        RETVAL = new glm::mat4(glm::scale(*v));
    }
    else if (items == 2)
    {
        if (sv_derived_from(ST(0), "GLM::Mat4Ptr"))
            m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(0))));
        else
            croak("GLM::Functions::scale(m, v) -- m is not a GLM::Mat4 instance");
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            v = INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(1))));
        else
            croak("GLM::Functions::scale(m, v) -- v is not a GLM::Vec3 instance");
        RETVAL = new glm::mat4(glm::scale(*m, *v));
    }
OUTPUT:
    RETVAL

GLM::Mat4 *
translate(...)
PREINIT:
    glm::mat4 *m;
    glm::vec3 *v;
CODE:
    if (items == 1)
    {
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            v = INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(0))));
        else
            croak("GLM::Functions::translate(v) -- v is not a GLM::Vec3 instance");
        RETVAL = new glm::mat4(glm::translate(*v));
    }
    else if (items == 2)
    {
        if (sv_derived_from(ST(0), "GLM::Mat4Ptr"))
            m = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(0))));
        else
            croak("GLM::Functions::translate(m, v) -- m is not a GLM::Mat4 instance");
        if (sv_derived_from(ST(1), "GLM::Vec3Ptr"))
            v = INT2PTR(glm::vec3 *, SvIV((SV*)SvRV(ST(1))));
        else
            croak("GLM::Functions::translate(m, v) -- v is not a GLM::Vec3 instance");
        RETVAL = new glm::mat4(glm::translate(*m, *v));
    }
OUTPUT:
    RETVAL

INCLUDE: const-xs.inc

