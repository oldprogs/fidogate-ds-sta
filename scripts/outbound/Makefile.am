#:ts=8
#
#    $Id: Makefile.am,v 1.1 2003/11/05 00:47:44 rusfidogate Exp $
#
#    Makefile for FIDOGATE scripts/outbound/
#

bin_SCRIPTS	=	out-attach \
			out-freq \
			out-ls \
			out-manip \
			out-rm0 \
			out-rmbsy \
			outb-kill \
			outb

$(bin_SCRIPTS) $(noinst_SCRIPTS):
	$(SUBSTCMD) $@.in > $@
	chmod +x $@

clean-am:
	rm -f $(bin_SCRIPTS) $(noinst_SCRIPTS)
