/*****************************************************************************
 * FIDOGATE --- Gateway UNIX Mail/News <-> FIDO NetMail/EchoMail
 *
 * $Id: acl.c,v 1.1.1.1 2003/11/05 00:50:56 rusfidogate Exp $
 *
 *****************************************************************************/

#include "fidogate.h"



#define RFC2FTN 'r'
#define FTN2RFC 'f'

/*
 * Local prototypes
 */
static Acl  *acl_parse_line	( char * );
void         acl_do_file 	( char * );
static char *acl_lookup		( char *, int );
static void  pna_notify_init	( char * );


/*
 * ACL list
 */
static Acl   *acl_list          = NULL;
static Acl   *acl_last          = NULL;

static char **pna_notify_list   = NULL;
static char **ngrp_pat_list     = NULL;

static char   acl_type          = TYPE_ECHOMAIL;
static char   gate_type         = RFC2FTN;


static Acl *acl_parse_line( char *buf ) {
    Acl *p;
    char *f, *n;
	
    p = NULL;
    f = strtok( buf, " \t" );	/* E-Mail address pattern */

    if( f == NULL )
	return NULL;

    if( !stricmp( f, "netmail" ) )
	acl_type = TYPE_NETMAIL;
    else if( !stricmp( f, "rfc2ftn" ) )
	gate_type = RFC2FTN;
    else if( !stricmp( f, "ftn2rfc" ) )
	gate_type = FTN2RFC;
    else if( !stricmp( f, "echomail") )
	acl_type = TYPE_ECHOMAIL;
    else {
        n = strtok( NULL, " \t" );	/* Newsgroup pattern */
    
        if( n == NULL );
	else if( strieq( f, "include" ) )
	    acl_do_file( n );
        else if( strieq( f, "PostingNotAllowedNotify") )
	    pna_notify_init( n );
        else {    
            p = ( Acl * )xmalloc( sizeof( Acl ) );
            p->next      = NULL;
            p->type      = acl_type;
            p->email_pat = strsave( f );
            p->ngrp_pat  = strsave( n );
            p->gate	 = gate_type;

            debug(15, "acl: %s, %s       %s",
	          ( p->type == TYPE_NETMAIL ) ? "netmail" : "echomail",
	          p->email_pat, p->ngrp_pat);
        }
    }
    return p;
}


void acl_do_file( char *name ) {

    FILE *fp;
    Acl *p;

    debug( 14, "Reading ACL file %s", name );
    
    fp = fopen_expand_name( name, R_MODE_T, FALSE );
    if( fp ) {

        while( cf_getline( buffer, BUFFERSIZE, fp ) ) {
	    p = acl_parse_line( buffer );
	    if( p ) {
	        /* Put into linked list */
	        if( acl_list )
	            acl_last->next = p;
	        else
	            acl_list       = p;
	        acl_last           = p;
            }
        }
        fclose( fp );
    }

    return;
}


char *acl_lookup( char *email, int type ) {

    Acl  *p;
    char *ngrp = NULL;
    
    for( p = acl_list; p; p = p->next ) {

	if( p->gate == RFC2FTN &&
	    wildmat( email, p->email_pat ) &&
	    p->type == type )
	    
	    ngrp = p->ngrp_pat;
    }
    
    debug( 7, "acl_lookup(): From=%s, ngrp=%s", email, ngrp );
    
    return ngrp;
}


void acl_ngrp( RFCAddr rfc_from, int type ) {

    char email[MAXINETADDR];

    BUF_COPY( email, s_rfcaddr_to_asc( &rfc_from, FALSE ) );
    list_init( &ngrp_pat_list, acl_lookup( email, type ) );
    return;
}


int acl_ngrp_lookup( char *list ) {

    static char **ngrp_list = NULL;

    list_init( &ngrp_list, list );
    return list_match( ngrp_pat_list, ngrp_list );
}


void pna_notify_init( char *list ) {

    list_init( &pna_notify_list, list );
    return;
}


int pna_notify( char *email ) {

    static char **email_list = NULL;

    list_init( &email_list, email );
    return list_match( pna_notify_list, email_list );
}


int ftnacl_lookup( Node *node_from, Node *node_to, char *echo ) {

    Acl *p;
    int type;
    char *node1, *node2=NULL, *n;

    if( echo )
	type = TYPE_ECHOMAIL;
    else {
	type = TYPE_NETMAIL;
	node2 = znfp1( node_to );
    }
    node1 = znfp2( node_from );
    
    for( p = acl_list; p; p = p->next ) {

	if( p->gate == FTN2RFC &&
	    wildmat( node1, p->email_pat ) &&
	    p->type == type ) {

	    for( n = xstrtok( p->ngrp_pat,"," ); n; n = xstrtok( NULL,"," ) )
		if( echo ) {
		    if( wildmat( n, echo ) )
			return TRUE;
		}
		else if( wildmat( n, node2 ) )
		    return TRUE;
	}
    }

    return FALSE;
}


/*=================================================================*/
/* This is part of INN 1.7.2                                       */
/* Modify by Andy Igoshin                                          */
int argify(char *line, char ***argvp) {

    register char	**argv;
    register char	*p;
    register int	i;

    if( *argvp != NULL ) {
	xfree( ( void * )*argvp[0] );
	xfree( ( void * )*argvp );
    }

    /*  Copy the line, which we will split up. */
    while( *line == ' ' || *line == '\t' )
	line++;

    i = strlen( line );
    p = strsave( line );

    /* Allocate worst-case amount of space. */
    *argvp = argv = ( char ** )xmalloc( sizeof( char * ) * (i + 2) );
    while( *p ) {
	/* Mark start of this word, find its end. */
	for( *argv++ = p; *p && *p != ' ' && *p != '\t'; )
	    p++;
	if( *p == '\0' )
	    break;
	/* Nip off word, skip whitespace. */
	for( *p++ = '\0'; *p == ' ' || *p == '\t'; )
	    p++;
    }
    *argv = NULL;

    return argv - *argvp;
}


/*
**  Parse a newsgroups line, return TRUE if there were any.
*/
void list_init( char ***argvp, char *list ) {

    register char *p;

    if( list ) {
        for( p = list; *p; p++ )
	    if( *p == ',' )
	        *p = ' ';
        argify( list, argvp );
    }
    return;
}


/*
**  Match a list of newsgroup specifiers against a list of newsgroups.
**  func is called to see if there is a match.
*/
int list_match( char **Pats, char **list ) {

    register int	match = FALSE;
    register int	i;
    register char	*p;

    if( Pats && list && Pats[0] != NULL ) {
        for( ; *list; list++ ) {
	    for( i = 0; ( p = Pats[i] ) != NULL; i++ ) {
	        if( p[0] == '!' ) {
		    if( wildmat( *list, ++p ) )
		        match = FALSE;
	        }
	        else if ( wildmat( *list, p ) )
		    match = TRUE;
	    }
        }
    }
    return match;
}
