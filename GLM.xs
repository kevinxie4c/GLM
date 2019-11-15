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
    {
	RETVAL = new glm::mat4();
    }
    else if (items = 2)
    {
	if (sv_derived_from(ST(1), "$Package"))
	{
	    RETVAL = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(1))));
	}
	else
	    croak("not type $Package");
    }
    else
	croak("too many arguments");
OUTPUT:
    RETVAL

void
GLM::Mat4::DESTROY()

MODULE = GLM		PACKAGE = GLM::Vec4

GLM::Vec4 *
GLM::Vec4::new()
CODE:
    RETVAL = new glm::vec4();
OUTPUT:
    RETVAL

float
GLM::Vec4::x()
CODE:
    RETVAL = THIS->x;
OUTPUT:
    RETVAL

void
GLM::Vec4::DESTROY()


INCLUDE: const-xs.inc


