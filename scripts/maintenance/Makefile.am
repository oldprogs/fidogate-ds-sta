#:ts=8
#
#    $Id: Makefile.am,v 5.1 2004/12/10 19:09:55 anray Exp $
#
#    Makefile for FIDOGATE scripts/filebase/
#

bin_SCRIPTS	=	logcheck \
			logdaily \
			logreport \
			logsendmail \
			logstat \
			runchklock

noinst_SCRIPT	=	fidogate.logrotate \
			rc.fidogate

$(bin_SCRIPTS) $(noinst_SCRIPTS):
	$(SUBSTCMD) $@.in > $@
	chmod +x $@

clean-am:
	rm -f $(bin_SCRIPTS) $(noinst_SCRIPTS)
