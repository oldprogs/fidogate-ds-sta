#:ts=8
#
#    $Id: Makefile.am,v 5.1 2004/12/10 19:09:55 anray Exp $
#
#    Makefile for FIDOGATE scripts/misc/
#

bin_SCRIPTS	=	hosts2dns \
			recvuu \
			senduu \
			senduumail

$(bin_SCRIPTS) $(noinst_SCRIPTS):
	$(SUBSTCMD) $@.in > $@
	chmod +x $@

clean-am:
	rm -f $(bin_SCRIPTS) $(noinst_SCRIPTS)

