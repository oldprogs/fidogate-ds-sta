#:ts=8
#
#    $Id: Makefile.am,v 5.1 2004/12/10 19:09:55 anray Exp $
#
#    Makefile for FIDOGATE scripts/
#

SUBDIRS	      = areas maintenance misc nodelist outbound

noinst_SCRIPTS= filebase/fb-chkfiles \
		filebase/fb-filelist \
		www/gate.cgi

$(bin_SCRIPTS) $(noinst_SCRIPTS):
	$(SUBSTCMD) $@.in > $@
	chmod +x $@

clean-am:
	rm -f $(bin_SCRIPTS) $(noinst_SCRIPTS)
