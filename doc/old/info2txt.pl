#!/usr/bin/perl
#
# $Id: info2txt.pl,v 5.1 2004/12/10 19:09:54 anray Exp $
#
# Stripping control stuff from .info file, yielding plain text
#

while(<>) {
    if( /^\c_/ ) {		# Start of node
	$x = <>;
	next;
    }

    if( /^\* Menu:/ ) {		# Menu
	next;
    }

    if( /^Node: .*\c?.*$/ ) {	# Nodes
	next;
    }

    if( /^\(Indirect\)/ ) {
	next;
    }

    if( /\.info-\d+: \d+$/ ) {
	next;
    }

    print $_;
}
