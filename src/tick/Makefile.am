#:ts=8
#
#    $Id: Makefile.am,v 1.1 2003/11/05 00:55:48 rusfidogate Exp $
#
#    Makefile for FIDOGATE src/tick/
#

INCLUDES		= -I$(top_srcdir)/src/include

if enable_static
LDADD			= $(top_srcdir)/src/common/libfidogate.a
else
LDADD			= $(top_srcdir)/src/common/libfidogate.la
endif

AM_CFLAGS		= -Wall

bin_PROGRAMS		= ftnhatch
libexec_PROGRAMS	= ftntick
libexec_SCRIPTS		= ftntickpost

ftntick_SOURCES		= ftntick.c $(top_srcdir)/src/areafix/areafix.c

$(libexec_SCRIPTS):
	$(SUBSTCMD) $@.in > $@
	chmod +x $@

clean-am:
	rm -f $(libexec_SCRIPTS)
