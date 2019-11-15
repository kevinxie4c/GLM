/*
 * This file was generated automatically by ExtUtils::ParseXS version 3.39 from the
 * contents of GLM.xs. Do not edit this file, edit GLM.xs instead.
 *
 *    ANY CHANGES MADE HERE WILL BE LOST!
 *
 */

#line 1 "GLM.xs"
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

#line 33 "GLM.c"
#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#ifndef dVAR
#  define dVAR		dNOOP
#endif


/* This stuff is not part of the API! You have been warned. */
#ifndef PERL_VERSION_DECIMAL
#  define PERL_VERSION_DECIMAL(r,v,s) (r*1000000 + v*1000 + s)
#endif
#ifndef PERL_DECIMAL_VERSION
#  define PERL_DECIMAL_VERSION \
	  PERL_VERSION_DECIMAL(PERL_REVISION,PERL_VERSION,PERL_SUBVERSION)
#endif
#ifndef PERL_VERSION_GE
#  define PERL_VERSION_GE(r,v,s) \
	  (PERL_DECIMAL_VERSION >= PERL_VERSION_DECIMAL(r,v,s))
#endif
#ifndef PERL_VERSION_LE
#  define PERL_VERSION_LE(r,v,s) \
	  (PERL_DECIMAL_VERSION <= PERL_VERSION_DECIMAL(r,v,s))
#endif

/* XS_INTERNAL is the explicit static-linkage variant of the default
 * XS macro.
 *
 * XS_EXTERNAL is the same as XS_INTERNAL except it does not include
 * "STATIC", ie. it exports XSUB symbols. You probably don't want that
 * for anything but the BOOT XSUB.
 *
 * See XSUB.h in core!
 */


/* TODO: This might be compatible further back than 5.10.0. */
#if PERL_VERSION_GE(5, 10, 0) && PERL_VERSION_LE(5, 15, 1)
#  undef XS_EXTERNAL
#  undef XS_INTERNAL
#  if defined(__CYGWIN__) && defined(USE_DYNAMIC_LOADING)
#    define XS_EXTERNAL(name) __declspec(dllexport) XSPROTO(name)
#    define XS_INTERNAL(name) STATIC XSPROTO(name)
#  endif
#  if defined(__SYMBIAN32__)
#    define XS_EXTERNAL(name) EXPORT_C XSPROTO(name)
#    define XS_INTERNAL(name) EXPORT_C STATIC XSPROTO(name)
#  endif
#  ifndef XS_EXTERNAL
#    if defined(HASATTRIBUTE_UNUSED) && !defined(__cplusplus)
#      define XS_EXTERNAL(name) void name(pTHX_ CV* cv __attribute__unused__)
#      define XS_INTERNAL(name) STATIC void name(pTHX_ CV* cv __attribute__unused__)
#    else
#      ifdef __cplusplus
#        define XS_EXTERNAL(name) extern "C" XSPROTO(name)
#        define XS_INTERNAL(name) static XSPROTO(name)
#      else
#        define XS_EXTERNAL(name) XSPROTO(name)
#        define XS_INTERNAL(name) STATIC XSPROTO(name)
#      endif
#    endif
#  endif
#endif

/* perl >= 5.10.0 && perl <= 5.15.1 */


/* The XS_EXTERNAL macro is used for functions that must not be static
 * like the boot XSUB of a module. If perl didn't have an XS_EXTERNAL
 * macro defined, the best we can do is assume XS is the same.
 * Dito for XS_INTERNAL.
 */
#ifndef XS_EXTERNAL
#  define XS_EXTERNAL(name) XS(name)
#endif
#ifndef XS_INTERNAL
#  define XS_INTERNAL(name) XS(name)
#endif

/* Now, finally, after all this mess, we want an ExtUtils::ParseXS
 * internal macro that we're free to redefine for varying linkage due
 * to the EXPORT_XSUB_SYMBOLS XS keyword. This is internal, use
 * XS_EXTERNAL(name) or XS_INTERNAL(name) in your code if you need to!
 */

#undef XS_EUPXS
#if defined(PERL_EUPXS_ALWAYS_EXPORT)
#  define XS_EUPXS(name) XS_EXTERNAL(name)
#else
   /* default to internal */
#  define XS_EUPXS(name) XS_INTERNAL(name)
#endif

#ifndef PERL_ARGS_ASSERT_CROAK_XS_USAGE
#define PERL_ARGS_ASSERT_CROAK_XS_USAGE assert(cv); assert(params)

/* prototype to pass -Wmissing-prototypes */
STATIC void
S_croak_xs_usage(const CV *const cv, const char *const params);

STATIC void
S_croak_xs_usage(const CV *const cv, const char *const params)
{
    const GV *const gv = CvGV(cv);

    PERL_ARGS_ASSERT_CROAK_XS_USAGE;

    if (gv) {
        const char *const gvname = GvNAME(gv);
        const HV *const stash = GvSTASH(gv);
        const char *const hvname = stash ? HvNAME(stash) : NULL;

        if (hvname)
	    Perl_croak_nocontext("Usage: %s::%s(%s)", hvname, gvname, params);
        else
	    Perl_croak_nocontext("Usage: %s(%s)", gvname, params);
    } else {
        /* Pants. I don't think that it should be possible to get here. */
	Perl_croak_nocontext("Usage: CODE(0x%" UVxf ")(%s)", PTR2UV(cv), params);
    }
}
#undef  PERL_ARGS_ASSERT_CROAK_XS_USAGE

#define croak_xs_usage        S_croak_xs_usage

#endif

/* NOTE: the prototype of newXSproto() is different in versions of perls,
 * so we define a portable version of newXSproto()
 */
#ifdef newXS_flags
#define newXSproto_portable(name, c_impl, file, proto) newXS_flags(name, c_impl, file, proto, 0)
#else
#define newXSproto_portable(name, c_impl, file, proto) (PL_Sv=(SV*)newXS(name, c_impl, file), sv_setpv(PL_Sv, proto), (CV*)PL_Sv)
#endif /* !defined(newXS_flags) */

#if PERL_VERSION_LE(5, 21, 5)
#  define newXS_deffile(a,b) Perl_newXS(aTHX_ a,b,file)
#else
#  define newXS_deffile(a,b) Perl_newXS_deffile(aTHX_ a,b)
#endif

#line 177 "GLM.c"

XS_EUPXS(XS_GLM__Mat4_new); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_GLM__Mat4_new)
{
    dVAR; dXSARGS;
    if (items < 1)
       croak_xs_usage(cv,  "CLASS, ...");
    {
	char *	CLASS = (char *)SvPV_nolen(ST(0))
;
	GLM__Mat4 *	RETVAL;
#line 44 "GLM.xs"
    if (items = 1)
    {
	RETVAL = new glm::mat4();
    }
    else if (items = 2)
    {
	if (sv_derived_from(ST(1), "$ntype"))
	{
	    RETVAL = INT2PTR(glm::mat4 *, SvIV((SV*)SvRV(ST(1))));
	}
	else
	    croak("not type $ntype");
    }
    else
	croak("too many arguments");
#line 205 "GLM.c"
	{
	    SV * RETVALSV;
	    RETVALSV = sv_newmortal();
    sv_setref_pv( RETVALSV, CLASS, (void*)RETVAL );
	    ST(0) = RETVALSV;
	}
    }
    XSRETURN(1);
}


XS_EUPXS(XS_GLM__Mat4_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_GLM__Mat4_DESTROY)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "THIS");
    {
	GLM__Mat4 *	THIS;

	delete THIS;
    }
    XSRETURN_EMPTY;
}


XS_EUPXS(XS_GLM__vec4_new); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_GLM__vec4_new)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "CLASS");
    {
	char *	CLASS = (char *)SvPV_nolen(ST(0))
;
	GLM__Vec4 *	RETVAL;
#line 74 "GLM.xs"
    RETVAL = new glm::vec4();
#line 244 "GLM.c"
	{
	    SV * RETVALSV;
	    RETVALSV = sv_newmortal();
	    sv_setref_pv(RETVALSV, "GLM::Vec4Ptr", (void*)RETVAL);
	    ST(0) = RETVALSV;
	}
    }
    XSRETURN(1);
}


XS_EUPXS(XS_GLM__vec4_x); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_GLM__vec4_x)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "THIS");
    {
	GLM__Vec4 *	THIS;
	float	RETVAL;
	dXSTARG;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "GLM::Vec4Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    THIS = INT2PTR(GLM__Vec4 *,tmp);
	}
	else
	    Perl_croak_nocontext("%s: %s is not of type %s",
			"GLM::vec4::x",
			"THIS", "GLM::Vec4Ptr")
;
#line 81 "GLM.xs"
    RETVAL = THIS->x;
#line 278 "GLM.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS_EUPXS(XS_GLM__vec4_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_GLM__vec4_DESTROY)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "THIS");
    {
	GLM__Vec4 *	THIS;

	if (SvROK(ST(0))) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    THIS = INT2PTR(GLM__Vec4 *,tmp);
	}
	else
	    Perl_croak_nocontext("%s: %s is not a reference",
			"GLM::vec4::DESTROY",
			"THIS")
;

	delete THIS;
    }
    XSRETURN_EMPTY;
}


/* INCLUDE:  Including 'const-xs.inc' from 'GLM.xs' */


XS_EUPXS(XS_GLM__vec4_constant); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_GLM__vec4_constant)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "sv");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
#line 4 "./const-xs.inc"
#ifdef dXSTARG
	dXSTARG; /* Faster if we have it.  */
#else
	dTARGET;
#endif
	STRLEN		len;
        int		type;
	/* IV		iv;	Uncomment this if you need to return IVs */
	/* NV		nv;	Uncomment this if you need to return NVs */
	/* const char	*pv;	Uncomment this if you need to return PVs */
#line 333 "GLM.c"
	SV *	sv = ST(0)
;
	const char *	s = SvPV(sv, len);
#line 18 "./const-xs.inc"
	type = constant(aTHX_ s, len);
      /* Return 1 or 2 items. First is error message, or undef if no error.
           Second, if present, is found value */
        switch (type) {
        case PERL_constant_NOTFOUND:
          sv =
	    sv_2mortal(newSVpvf("%s is not a valid GLM macro", s));
          PUSHs(sv);
          break;
        case PERL_constant_NOTDEF:
          sv = sv_2mortal(newSVpvf(
	    "Your vendor has not defined GLM macro %s, used",
				   s));
          PUSHs(sv);
          break;
	/* Uncomment this if you need to return IVs
        case PERL_constant_ISIV:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHi(iv);
          break; */
	/* Uncomment this if you need to return NOs
        case PERL_constant_ISNO:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_no);
          break; */
	/* Uncomment this if you need to return NVs
        case PERL_constant_ISNV:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHn(nv);
          break; */
	/* Uncomment this if you need to return PVs
        case PERL_constant_ISPV:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, strlen(pv));
          break; */
	/* Uncomment this if you need to return PVNs
        case PERL_constant_ISPVN:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, iv);
          break; */
	/* Uncomment this if you need to return SVs
        case PERL_constant_ISSV:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHs(sv);
          break; */
	/* Uncomment this if you need to return UNDEFs
        case PERL_constant_ISUNDEF:
          break; */
	/* Uncomment this if you need to return UVs
        case PERL_constant_ISUV:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHu((UV)iv);
          break; */
	/* Uncomment this if you need to return YESs
        case PERL_constant_ISYES:
          EXTEND(SP, 2);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_yes);
          break; */
        default:
          sv = sv_2mortal(newSVpvf(
	    "Unexpected return type %d while processing GLM macro %s, used",
               type, s));
          PUSHs(sv);
        }
#line 410 "GLM.c"
	PUTBACK;
	return;
    }
}


/* INCLUDE: Returning to 'GLM.xs' from 'const-xs.inc' */

#ifdef __cplusplus
extern "C"
#endif
XS_EXTERNAL(boot_GLM); /* prototype to pass -Wmissing-prototypes */
XS_EXTERNAL(boot_GLM)
{
#if PERL_VERSION_LE(5, 21, 5)
    dVAR; dXSARGS;
#else
    dVAR; dXSBOOTARGSXSAPIVERCHK;
#endif
#if (PERL_REVISION == 5 && PERL_VERSION < 9)
    char* file = __FILE__;
#else
    const char* file = __FILE__;
#endif

    PERL_UNUSED_VAR(file);

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
#if PERL_VERSION_LE(5, 21, 5)
    XS_VERSION_BOOTCHECK;
#  ifdef XS_APIVERSION_BOOTCHECK
    XS_APIVERSION_BOOTCHECK;
#  endif
#endif

        newXS_deffile("GLM::Mat4::new", XS_GLM__Mat4_new);
        newXS_deffile("GLM::Mat4::DESTROY", XS_GLM__Mat4_DESTROY);
        newXS_deffile("GLM::vec4::new", XS_GLM__vec4_new);
        newXS_deffile("GLM::vec4::x", XS_GLM__vec4_x);
        newXS_deffile("GLM::vec4::DESTROY", XS_GLM__vec4_DESTROY);
        newXS_deffile("GLM::vec4::constant", XS_GLM__vec4_constant);
#if PERL_VERSION_LE(5, 21, 5)
#  if PERL_VERSION_GE(5, 9, 0)
    if (PL_unitcheckav)
        call_list(PL_scopestack_ix, PL_unitcheckav);
#  endif
    XSRETURN_YES;
#else
    Perl_xs_boot_epilog(aTHX_ ax);
#endif
}
