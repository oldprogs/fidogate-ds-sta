
		��������� FIDOGATE ver 1.2

��������� Andrey Slusar 2:467/126, rusfidogate at users.sourceforge.net

����� ������ ������ ����� ��������� ����� �������� ������� ��������� ������:
===
To: FAQServer 2:467/126
Subject: FIDOGATE
===
 ���� � ��� FreeBSD, ����� �������� ��������� ����� ������ ����:
===
To: FAQServer 2:467/126
Subject: GATE-PORT
===
���� �� ������ ������ ��������� ��� ���������� � ������ �������� ����������
������ �� ��������� ������.

��������! ��� ��������� ������� ��������� ������ ���������� �� ��������� �
��������� ������ MTA: qmail, smail etc � news-��������.

=============================================================================
                        ����������:

1.��������� ��������� ������� � ����� ������������� �����.
2.��������� � ��������� ��������� ����������� inn.
3.��������� � ��������� ��������� ����������� leafnode.
4.���������� � ��������� FIDOGATE.
5.��������� � ��������� MTA Exim.
6.��������� � ��������� MTA Postfix.
7.������������� ��������� ���������� ������ � FIDOGATE, MTA � �����������.
8.������ FIDOGATE.
9.����� ���������� ������� �� ������.
10.�������������.

-----------------------------------------------------------------------------
1.������ ���� ���� � ����� ��� ����������� �������� ����� � ������.
  
  H������� ����� � /etc/hosts:

  ��� "santinel" � ������ "home.ua":

  === hosts ===
  127.0.0.1	localhost
  192.168.0.1	santinel santinel.home.ua
  ===

  � hostname:
  === hostname ===
  santinel
  ===

  ��� ����������� ������ ��������� ��������� MTA, ����������, ������������,
  ������� �����, �������� ������. � ������ FAQ ����� ����������� ���������
  ������������ inn � leafnode � MTA postfix � exim � ���������� ������ �
  FIDOGATE. ������ ����� ����� ������������ � ������� ����� ���������� �
  ��� �� ������ ������������.

-----------------------------------------------------------------------------
2.��������� inn:

  �������� ���� ���������� santinel.home.ua:

  === inn.conf ===
  innflags:               -c0 -u
  [...]
  server:                 santinel.home.ua
  pathhost:               santinel.home.ua
  fromhost:               santinel.home.ua
  domain:                 home.ua
  nnrpdposthost:          santinel.home.ua
  nnrpdposrport:          119
  moderatormailer:        %s@santinel.home.ua
  ===

  ��� ��������� ����� �������� �� ��������� ��� �������� man inn.conf � �
  ������������ � ��� ���������������.

  ����������� expire.ctl:

  === expire.ctl ===
  /remember/:20
  *:A:1:7:15
  ===

  ������:

  /remember/:�����

  ���� �������� � ����(����� � ������� ������ 1.5 - ������� ���), ��
  ��������� �������� �� ������� ��������� �������������� ������.

  ������ ������ ���������, ����� �� ������� ����� ������� ���� ������:
 
  pattern:modflag:keep:default:purge

  * pattern - ������� ��� ����� �������� � wildmat-�������, ��� ��������
    ����������� ������� ������ ������;

  * modflag - ����, ������������ ��� ����������� ����������� ������ ��������,
  ��� ������� ������������ ������ ������. 
  
  �������� �����:
          o � - �� �������� ������� ������ ������ ������ ��� ����� � �������
            (moderated groups) �� ���, ������� ������������� ������� pattern
	     ������� ����;
          o U - �� �������� ������� ������ ������ ������ ��� ����� ���
            �������� (unmoderated groups) �� ���, ������� �������������
            ������� pattern ������� ����;
          o A - �� �������� ������� ������ ������ ��� ���� ����� ��������,
            �������������� ������� pattern ������� ����.
  
  ������ ���������� "A" � modflag'�.
  
  ��������� 3 ���� ��������� ����� ���������� ���� ������� ���� ������ ��
  ��������� ������� ��������:

  * keep - ���������� ����������� ����� ���� �������� ��� ������ � �������
  	��� ����������� ����� ��������. ����� ������ �� ���� ����� ��
	����� ��������� ������ ���������� ���� ����� ����� (���� Expires-
	��������� ������ ����� ������� ����, �� ����� ������������
	�������� keep).

  * default - ��������� ����� ���� �������� ��� ��� ������ �� ������������ 
        �����, � ������� ����������� ��������� Expires.

  * purge - ��������� ������������ ����� ���� �������� ��� ������ ��
  	��������� ������� ��� ������������ ����� ��������. ����� ������ ��
	���� ����� �� ����� ��������� ������ ���������� ���� ����� ����� 
	(���� Expires-��������� ������ ����� ������� ����, �� �����
	������������ �������� purge).

  ���������� �������� man expire.ctl

  ����������� readers.conf:

  readers.conf ��������� ������ ������������� � ������� ��������:

  === readers.conf ===
  [skip]
  auth santinel.home.ua {
    hosts: "localhost, santinel.home.ua, 127.0.0.1, stdin"
    default: <LOCAL>
   }

  access full {
    newsgroups: *
   }
  ===
  man readers.conf ���� �� ������� ��������.

   ���� ����� ������ ������ ������ �� ������ ���������� ����� �� ���� �������
  �������� �� ����� �������.
   
    ����������� incoming.conf:
  
   � ���� ����� ������������� �����, � ������� ������� ������ �������� ���
  �������:
  
  === incoming.conf ===
  peer ME {
  hostname:  "santinel.home.ua, localhost, 127.0.0.1"
  }
  ===
  
   ����� � storage.conf:
  
  === storage.conf ===
  method tradspool {
  newsgroups: *
  class: 0
                   }
  ===

-----------------------------------------------------------------------------
3.��������� leafnode:
  
   ����� leafnode ��������� ���� �� "����", ��� ��� "����" �����
  ��������� ������� � ������� groupinfo � interesting.groups.
   ��� freebsd ���� � ������� ������ leafnode-2.0b8_ma9 ����� ����� �� ����
  ����� http://node126.narod.ru
   ����� ��� ������ ����� ����� �����:
  
   ftp://wpxx02.toxi.uni-wuerzburg.de/pub/leafnode-2.0b8_ma9.tar.gz
  
  ������������� tar -xzf leafnode-2.0b8_ma9.tar.gz, ����� 
  cd leafnode-2.0b8_ma9, ./configure � ������� �������, �������� c ������:

  ./configure --with-lockfile=/var/spool/leafnode/leaf.node/lock.file \
	      --with-spooldir=/var/spool/leafnode
  
  ������ make && make install, cd /usr/local/leafnode/etc,
  cp config.example config, ����������� config. � config ���������� ������ 
  ���������� expire - ������������ ����� �������� ������������� ������ �
  server, ������ ����� ����� ���� ������. ��� ���������, ����������������,
  ������� ��� ��������������� �� �����. man leafnode ���� �� �������
  ��������.
  
  === config ===
  server = localhost
  expire = 30
  ===
  
  ����������� ���� ������ � inetd.conf:
  === inetd.conf ===
  nntp stream tcp nowait news /usr/libexec/tcpd /usr/local/sbin/leafnode
  ===
  � services ����������� ����:
  === services ===
  nntp     119/tcp
  ===
  ����� ���������� ��� �������� INSTALL � ������ � leafnode �� ������
  hosts.allow, hosts.deny � ������� man inetd.conf.
  ����� ������ #kill -HUP `cat /var/run/inetd.pid` � ��������� �������� ��
  ������:
  
  $telnet localhost 119
  
  ������ ������� ����������� �������.  
  ������ ��� ����������� leafnode-util �� Elohin Igor. ��������� �� � �����
  http://maint.unona.ru, �������������, ������� README � ������ ���, ���
  ��� �������, �� ������� ��������������� common.h. �������� ���:
  
  === common.h ===
  [...]
  #define OUTGOING "/var/spool/leafnode/out.going"
  #define FAILED_POSTING "/var/spool/leafnode/failed.postings"
  #define IN_COMING "/var/spool/leafnode/in.coming"
  #define DUPE_POST "/var/spool/leafnode/dupe.post"
  #define INTERESTING_GROUPS "/var/spool/leafnode/interesting.groups"
  #define GROUPINFO "/var/spool/leafnode/leaf.node/groupinfo"
  #define LOCAL_GROUPINFO "/usr/local/etc/leafnode/local.groups"
  #define ACTIVE "/var/spool/leafnode/leaf.node/active"
  #define RFC2FTN  "/usr/local/fido/libexec/rfc2ftn -n -v"
  #define DELETE_CTRL_D  "/usr/local/fido/leafnode/ctrld"
  #define DIRLOG  "/var/log/fidogate"
  #define NEWSLOGDIR  "/var/log/leafnode"
  #define MSGBUF 512
  #define LEAFNODE_OWNER "news"
  #define LOGNAME "leafnode"
  ===
  ����� ������ make && make install

------------------------------------------------------------------------------
4. ������������� FIDOGATE:

4.1.����� ��������� ���������� FIDOGATE � cvs(��� � ���� �������):
  ===
  cvs -z3 -d:pserver:anonymous@cvs.rusfidogate.sourceforge.net:/cvsroot/rusfidogate \
  co fidogate
  ===
  
   ������������� ��������� � ����� fidogate, ������� � ���, �������
  ./configure --help, ������ ./configure � ������� �������, 
  
  �������� � ������:

  ----------------
  ./configure --prefix=/usr/local/fido \
              --with-logdir=/var/log/fido/gate \
              --with-vardir=/var/db/fidogate \
              --with-spooldir=/var/spool/fido/gate \
              --with-btbasedir=/var/spool/fido/bt \
              --enable-amiga-out \
              --disable-desc-dir
  -----------------

  ��������!
  ���� �� � �������� ������� ����������� �� inn, �� fidogate ���������� 
  �������� � ������ --without-news.
  
  �������� ������� � �������� ����� ��������� � README.ru ��������
  FIDOGATE.

  ������ "make", "make install".

4.2.����� ������ ����� � ���� �� ����� http://node126.narod.ru ���� 
  fidogate5.1.0_ds.src.rpm � �����������������:

  �������� ���� ���� � /usr/src/rpm/SRPMS, ������: 
  
   cd /usr/src/rpm,
   rpm -i SRPMS/fidogate5.1.0_ds.src.rpm,
   rpm -ba SPECS/fidogate.spec
  
  ������������� fidogate:
   
   rpm -i RPMS/i386/fidogate5.1.0_ds.rpm;

  ��� �������������� ������� �������� ������� fidogate-5.1.0_ds.rpm:
  
   rpm -i fidogate5.1.0_ds.rpm.

  ��� Debian:
   ������ ��� Debian ����� ����� ����� �� � ����, � ��
  kaliuta.basnet.by/debian, ��� ��� � ������ �� ������� ������� ��� Debian.
   ������������� �����:
  dpkg -i fidogate5.1.0_ds.deb

4.3. ��� freebsd ����� ����� ������ � ����� �����:
  http://node126.narod.ru/files/fidogate5.1.0_ds.tgz(STABLE)
  � ���������� �������� pkg_add.
  ���: 
  ����� ����� ��������� � cvs, �������� �� � ����������� � ������������
  � version.h:
  --8<---------------cut here---------------start------------->8---
  /*:ts=8*/
  /**************************************************************************
  * FIDOGATE --- Gateway software UNIX Mail/News <-> FIDO NetMail/EchoMail
  *
  * $Id: FAQ.ru,v 1.3 2004/01/12 21:40:59 rusfidogate Exp $
  *
  * Global version number, patch level
  ***************************************************************************
  
  #define VERSION_MAJOR	5
  #define VERSION_MINOR	2
  #define PATCHLEVEL	0
  #define EXTRAVERSION	"ds-alpha1"

  #define STATE		"beta"
  --8<---------------cut here---------------end--------------->8---
  ������ ����������� fidogate5.2.0ds-alpha1, ������ � ������������
  ����������� ���� fidogate5.2.0ds-alpha1.tar.bz2, �������� ���� ���� �
  /usr/ports/distfiles, ����������� <fidogate-src>/packages/freebsd
  ��������� �������� � ����������� /usr/ports/news/fidogateds-devel,
  ���� � version.h ��������, ��� STATE "beta" ��� � fidogateds, ����
  STATE "stable". ����� ������ cd /usr/ports/news/fidogateds{-devel} �
  ��� ���� ������� make makesum ��� ��������� md5sum, ����� ������ ���,
  ��� ��������� �� ����� - make, ����� make install ��� ��������� �����
  ��� make package ��� ��������� � ������������ �������.

-----------------------------------------------------------------------------

5.��������� � ��������� exim4:
  ������������� Exim4 ���, ����� ��� �������� ����� *.fidonet.org ������
  ����� ����, ��������-����� ����� ����� ����������, ��������� ������������
  ��������:

  === configure ===
  ######################################################################
  #                    MAIN CONFIGURATION SETTINGS                     #
  ######################################################################

  primary_hostname = santinel.home.ua
  domainlist local_domains = @ : @[] : localhost : santinel.home.ua
  domainlist relay_to_domains = localhost : santinel.home.ua
  hostlist   relay_from_hosts = 127.0.0.1

  acl_smtp_rcpt = acl_check_rcpt

  # ������ �����������
  smtp_banner = "ESMTP Exim"
  
  # ���� � ������, �� ������� ����������� ����� Exim.
  exim_user  = mailnull
  exim_group = mail

  # ���� � ������, ������� ����� ����� �� sendmail envelope-from
  trusted_users  = mailnull
  trusted_groups = mail

  never_users = root

  host_lookup = santinel.home.ua

  rfc1413_hosts = *
  rfc1413_query_timeout = 30s

  # �����-������� ������ 2 ��� � �����
  ignore_bounce_errors_after = 2d
  
  # ������� 7 ����.
  timeout_frozen_after = 7d

  ######################################################################
  #                       ACL CONFIGURATION                            #
  #         Specifies access control lists for incoming SMTP mail      #
  ######################################################################

  begin acl

  acl_check_rcpt:

  accept  hosts = 127.0.0.1/8

  deny    local_parts   = ^.*[@%!/|] : ^\\.

  accept  local_parts   = postmaster
          domains       = +local_domains

  require verify        = sender

  accept  domains       = +local_domains
          endpass
          message       = unknown user
          verify        = recipient

  accept  domains       = +relay_to_domains
          endpass
          message       = unrouteable address
          verify        = recipient

  accept  hosts         = +relay_from_hosts

  accept  authenticated = *

  deny    message       = relay not permitted

  ######################################################################
  #                      ROUTERS CONFIGURATION                         #
  #               Specifies how addresses are handled                  #
  ######################################################################

  begin routers

  # ���� �������� ������. ����� ����� ������� ���� ����� � FIDO.
  fidonet:
    driver = manualroute
    domains = ! +local_domains
    route_list = *.fidonet.org f126.n467.z2.fidonet.org
    transport = fidogate
  
  # ��� ��������� - �� ����� ������ ���������� smtp.my.provider.
  internet:
    driver = manualroute
    domains = ! +local_domains
    route_list = * smtp.my.provider
    transport = remote_smtp
    ignore_target_hosts = 127.0.0.0/8
    no_more
  
  # ������������ ��������� ������.
  system_aliases:
    driver = redirect
    allow_fail
    allow_defer
    data = ${lookup{$local_part}lsearch{/etc/aliases}}
    user = mailnull
    group = mail
    file_transport = address_file
    pipe_transport = address_pipe

  # ��������� �����
  localuser:
    driver = accept
    check_local_user
    transport = local_delivery
  
  ######################################################################
  #                      TRANSPORTS CONFIGURATION                      #
  ######################################################################

  begin transports

  fidogate:
    driver = pipe
    command = "/usr/local/fido/libexec/rfc2ftn -i ${pipe_addresses}"
    user = news
    group = news

  remote_smtp:
    driver = smtp

  # ���������� unix mailbox
  local_delivery:
    driver = appendfile
    file   = /var/mail/$local_part
    delivery_date_add
    envelope_to_add
    return_path_add
    group = mail
    user = $local_part
    mode = 0660
    no_mode_fail_narrower

  address_pipe:
    driver = pipe
    return_output

  address_file:
    driver = appendfile
    delivery_date_add
    envelope_to_add
    return_path_add

  ######################################################################
  #                      RETRY CONFIGURATION                           #
  ######################################################################

  begin retry

  *                      *           F,2h,15m; G,16h,1h,1.5; F,4d,6h

  ######################################################################
  #                      REWRITE CONFIGURATION                         #
  ######################################################################

  begin rewrite

  ######################################################################
  #                   AUTHENTICATION CONFIGURATION                     #
  ######################################################################

  begin authenticators
  ===
  
  ��������� ������������ ����������� - ��� ����� ������:
  
  #exim -bV
  
  ���� ��� ���������, �� ��� ��������� MTA ������� �������� ����� rc-�������.

-----------------------------------------------------------------------------

6.��������� � ��������� Postfix:

  ������������� Postfix � Procmail(�� �����������) ���, ����� ������
  ��������� �����:

  ��� ������ ����������� main.cf Postfix'� c procmail'��:

  === main.cf ===
  command_directory = /usr/sbin
  daemon_directory  = /usr/lib/postfix
  program_directory = /usr/lib/postfix

  smtpd_banner = $myhostname ESMTP $mail_name
  setgid_group = postdrop
  biff = no

  # appending .domain is the MUA's job.
  append_dot_mydomain = yes
  myhostname = santinel.home.ua
  mydomain = home.ua
  alias_maps = hash:/etc/aliases
  transport_maps = hash:/etc/postfix/transport
  alias_database = hash:/etc/aliases
  myorigin = /etc/mailname
  mydestination = santinel.home.ua
  mynetworks = 127.0.0.0/8
  mailbox_command = procmail -a "$EXTENSION"
  mailbox_size_limit = 0
  ===
  
  � ����������� ������� ���������� ������ ������� ���� � transport_maps

  ����������� ���� /etc/aliases:
  ���������� ��������� �����, ������� ����� �������� ������ ��� root'�:

  root: pupkin

  ���� �������(�� root) newaliases. ���������� �������� man sendmail.
 
  ����������� transport Postfix'a:

  �������� ���� ���������� <fidogate src>/doc/mailer/postfix/transport.
  �� root ���� ������� "postmap /etc/postfix/transport" ��� ��������
  transport.db

  ���������� �������� man 5 transport.

  ��������� ���������� <fidogate src>/doc/mailer/postfix/master.cf

  ��� ������ ����������� master.cf(�������� �����):

  === master.cf ===
  [skip]
  ftn   unix - n n - - pipe
    flags=F user=news argv=/usr/local/fido/libexec/ftnmail -- $recipient
  ftni   unix - n n - - pipe
    flags=F user=news argv=/usr/local/fido/libexec/rfc2ftn -i -- $recipient
  ftna   unix - n n - - pipe
     flags=F user=news argv=/usr/local/fido/libexec/rfc2ftn -a $nexthop -i \
  -- $recipient
  ftno   unix - n n - - pipe
    flags=F user=news argv=/usr/local/fido/libexec/ftnmail -a $nexthop -O \
  outpkt/$nexthop -i -- $recipient
  ===

-----------------------------------------------------------------------------
7.������������� ��������� ���������� ������ � FIDOGATE.
 
 7.1. ���� �� ������� ��� ������ � ���������� ���������� leafnode:
  ������ ����� ���������� ��������� FAQ � ������ � leafnode-util � INSTALL,
  FAQ, README � �������� leafnode.
  
  ������ fidogate.conf:

  === fidogate.conf ===
  [...]
  INN_BATCHDIR  /var/spool/leafnode/out.going
  NEWSVARDIR    /usr/local/leafnode/etc
  NEWSLIBDIR    /usr/local/leafnode
  NEWSBINDIR    /usr/local/leafnode/sbin
  NEWSSPOOLDIR  /var/spool/leafnode
  [...]
  # rnews program path
  FTNInRnews      /usr/local/fido/leafnode/rnews -c
  [...]
  # Newsserver scrips to create/renumber/remove newsgroups
  AutoCreateNewgroupCmd /usr/local/fido/leafnode/leafnode-group -M %s
  AutoCreateRenumberCmd /usr/local/fido/leafnode/leafnode-group -L %s
  AutoCreateRmgroupCmd  /usr/local/fido/leafnode/leafnode-group -r %s
  [...]
  ===
  
  ������ #crontab -e -u news � ���������� crontab:
  === news ===
  # ������ 15 ����� ������� ���������� �� ���������� ������.
  */15  *  * * *  /usr/local/fido/libexec/send-fidogate
  # ������ ���� ��������� expire.
  0     21 * * *  /usr/local/sbin/texpire
  # ������ ���� ������������ �� �� ��� ����������.
  00   22  * * *   /usr/local/bin/ftnafutil expire
  # ������ ������ ������ areas.bbs �� ���������� ��, �.�. �� �������� "U".
  00   23  * * 1   /usr/local/bin/ftnafutil delete
  ===
  
   ��� ���������. ����� ���������� � ������ 9.
  
 7.2.������������� ��������� inn:
  
  ����������� newsfeeds inn'a:

  ������������ ���, ��� ��� ������������������ � �����:

  === newsfeeds ===
  ME:*/!junk,!control::

  fidogate\
     :*,!cc,\
     !junk,\
     !control\
     :Tf,Wnb:fidogate
  ===

  ����������� � ���� ������ send-fidogate, news.daily, flush cache, rnews -U:

  #crontab -e -u news � �����:
  === news ===
  # ������ 15 ����� ������� ���������� �� ���������� ������.
  */15  *  * * *   /usr/local/fido/libexec/send-fidogate
  # ������ ���� ��������� expire.
  30   21  * * *   /usr/local/news/bin/news.daily expireover lowmark delayrm
  # ������ ���� ������ cache inn-�.
  40   21  * * *   /usr/local/news/bin/ctlinnd -t 300 -s reload \
  			incoming.conf "flush cache"
  # ������ ��� ������ ��������� � incoming inn-a �������.
  10    *  * * *   test -x /usr/local/news/bin/rnews && \
  			/usr/local/news/bin/rnews -U
  # ������ ���� ������������ �� �� ��� ����������.
  00   22  * * *   /usr/local/fido/bin/ftnafutil expire
  # ������ ������ ������ areas.bbs �� ���������� ��, �.�. �� �������� "U".
  00   23  * * 1   /usr/local/fido/bin/ftnafutil delete
  ===
  ������������� innd.

-----------------------------------------------------------------------------  
 8.������ fidogate:

  H� �������� ��� �������� ��������� � ������� ��� �� ����� ������ runinc.
  H� ��������� ��� ��������� ����� ��������� runinc -o

=============================================================================
=============================================================================

 9.������ �� ����� ���������� �������.

=============================================================================
=============================================================================
  
  Q1:� ���� inn �� �����������. �����, ��� ��� history-�����, ���� ����� ����
     �� ����� ���� ����������.
   
  A1:���������� ������� ���������� history inn'a:

    �� root ������:
    ===
    su news
    /usr/local/news/bin/makehistory -b -f history -O -l 30000 -I
    /usr/local/news/bin/makedbz -f history -i -o -s 30000
    exit
    /etc/init.d/innd start
    ===
    ���.
  
-----------------------------------------------------------------------------

  Q2:� ���� ���������� �������� � ���������������, � UPS ���. � ����������
     ����� ������ inn ��� �� ����� �������������� �������� ����� - ��� �����
     � bad.
    
  A2:��� ��������� ���������� ������ ����������� ����� ������ storage ������
     tradspool ��������� timehash. ��� ����� ���������� ������ ��������� �
     storage.conf:
  
  === storage.conf ===
  method timehash {
  newsgroups: *
  class: 0
                  }
  ===		
    
     ��� ��������� ����� - ����� ��������� active-���� � overview �����
     ��������:
  
  === inn-recover.sh ===
  #!/bin/sh
  /usr/local/etc/rc.d/innd.sh stop
  su news -c "/usr/local/news/bin/makehistory -b -f history -O -l 30000 -I"
  /usr/local/etc/rc.d/innd.sh start
  for act in `cat /usr/local/news/db/active | awk '{print $1}'`
  do
   su news -c "/usr/local/news/bin/ctlinnd renumber $act"
  done
  ===
    ���� � ��������������� ������ ����������.

-----------------------------------------------------------------------------
  
  Q3:��������� inn � �������� �����������. ������ send-fidogate �� ������� �
    pkt ��������� �������, � � log-news ������� ��������� ������:
    
    === log-news ===
    Aug 21 00:04:51 rfc2ftn WARNING: can't open /usr/local/news/spool/articles/ \
    @050000000017000017AB0000000000000000@ (errno=2: No such file or directory)
    ===

  A3:���� � ���, ��� � ��������� ������� INN ������������ storage API � ���
    ���������� ������ fidogate ����� ��������� send-fidogate:

    ���� � send-fidogate ������: 
    
     time $RFC2FTN -f $BATCHFILE -m 500

    � ������ �� �� �����(��� � ���� �������):

     time $PATHBIN/batcher -N $QUEUEJOBS -b500000 -p"$RFC2FTN -b -n" \
     $SITE $BATCHFILE

    ����� ������������� man batcher.

-----------------------------------------------------------------------------

  Q4:��� ����� �������� ���������, �� ��� ������� runinc ������-�� ������ ��
     ������ - ������� �� ��������. � ����� ��� �����. ��� ������?
    
  A4:���������, ��� ������ ��������� ���������� � ��� runinc-� ������� ����
     �� �� ������.

-----------------------------------------------------------------------------
    
  Q5:�������� leafnode 1.x � leafnode-util �� Elohin Igor, ������ ������ 
     leafnode-group. groupinfo ��������, �� leafnode �� ����� ���������
     �����.
    
  A5:leafnode-group �������� ������ � leafnode 2.x �� "����". � ����������
     �������� leafnode �� �������� �� �����.

-----------------------------------------------------------------------------
    
  Q6:�������� leafnode, �������� ��� ��� ������� � ������ FAQ � inetd.conf
     � services, ������ kill -HUP `cat /var/run/inetd.pid`, ��
     $telnet localhost 119 �� ��������.
  
  A6:���������� ������� ��������� INSTALL � ������ leafnode � ���������
     ��������� ������ � hosts.allow �, ���� � ��� Linux �� hosts.deny.

-----------------------------------------------------------------------------

  Q7:����� inn. ������ ��� ������� configure �� ����� ����� rnews � �� ����� 
     ��-�� ����� ������ ����������� � ��������� ���������?
  
  �7:���� � ���, ��� rnews ������ ����� ����� news:news � ����, �����������
     ������ configure, �� ����� �� rnews ����. ��� ����, ���� configure
     ���������� ���������, ���������� ���� �������� �����, �����������
     �������� � ������ news ���� �������� �� root.

-----------------------------------------------------------------------------

  Q8:������ ������� ��������, �� � ����������� ��������� �� ����������? �
     ����� ���������:
     ===
     Oct 18 22:21:16 ftntoss packet /var/spool/bt/pin/9192da0c.pkt (1622b) from
     2:450/256.0 to 2:450/256.1
     Oct 18 22:21:16 ftntoss WARNING: node 2:450/256.0 have null password
     ===

  A8:���� � ��� ����� ����������� ������, �� �� ������� ��������� � passwd ��
     ��� ������.
     �������, �� ������ ��? � ����� ����� � passwd ������ ����:
     === passwd ===
     packet  2:5030/1469             XXXXXXXX
     packet  2:5030/1229.0           XXXXXXXX
     packet  2:5030/1229.5           XXXXXXXX
     packet  2:5030/1229.6           XXXXXXXX
     packet  2:5030/1229.7           XXXXXXXX
     packet  2:5030/1229.8           XXXXXXXX
     ===
-----------------------------------------------------------------------------

  Q9:������ fidogate ����� 8-� ��� � ��������� ��������? ������� ���������
     ��������� - � ����� ����� ������� plaint text 8bit.
     
  A9:��� ����, ����� ������� fidogate-� ����������� 8-������ ������� �
     ������������ ������, ����� � ���� ������ �������� ���� -8 � areas.

=============================================================================
 
 10. ������������� ����, ��� ������� ��� � ����������� ������� FAQ, ���������
     ������� fidogate � ������� ����������� ����� � ���������.
 
 1.Elohin Igor 2:5070/222.52
 2.Zhenya Kaluta 2:450/254
 3.Alexandr Dobroslavskiy 2:5020/1356

 � ����� ������������ "�������" FAQ �� FIDOGATE.
 
=============================================================================
