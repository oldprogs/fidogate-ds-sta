#!/usr/bin/perl
#
# $Id: info2txt.pl,v 1.1.1.1 2003/11/05 00:45:51 rusfidogate Exp $
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
