#:ts=8
#
#    $Id: Makefile.am,v 1.1 2003/11/05 00:46:57 rusfidogate Exp $
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
