
    $Id: FIDOGATE+tracker.ru,v 5.1 2004/12/10 19:09:49 anray Exp $

��������� ������� ��� ���������� ������ � FidoGate.

������ ��� ���������� � ��������� ������� ���������� �������� ��� ��������
FidoGate (FG). � �� ���� ����� ��������� ������������ �������, ����� ��� "���
���� ����� runinc?". ��� ��� ������� � FAQ � � ������������. � �����������
������ �� ���������� ������ ������� � FG.


FG ������������ ����� �������� �������� ������� �� ������� ����������� runinc:
ftntoss, ftnroute, ftnpack, � �.�.

��������� ����� ��������������� runinc'�� � inbound � �� �������� ��������������
ftntoss. ���� FG ��� ������ � --dnt-netmail, �� ����� ������ ftntoss ��� ����
�������� � netmaildir � ��������� ����� � toss/route. ��� remap'� (��.
��������� ������� � route � packing) ������������ ��� �� ���� �����. �����
��������� remap'� �������� NoRewrite � fidogate.conf (�������� ������ ��� ������
� --dnt-netmail).

������ �� ����� � toss/route �������������� ftnroute � ftnpack � ����������
���� ����� �������������� �� ������ � ��������� (��. ��������� progn gate �
packing).

������ ����������� ����� ���� ��� ���������� runinc. �� ������� �� �������� �
netmaildir � ������ ��� � ���� ������ ������. �ӣ ��� ������������� ��� �����
������� ������ ������ �������� � toss/route. ����� ���������� ���� ������
�������������� �� ������ �������������� ��������. ���� � toss/route ��������
���������� ����, �� FG ����� ������� ��� � netmaildir.

����� ����, ������� � toss/route, ������������ ����� ��������� ftnpack --pkt.
ftnpack ��������� � packing � �������� ��� �������� ��������������� progn (��.
��������� progn gate, areafix, filefix � packing).

��������� ���� � ����� ������� �������� � outpkt (������ �������) ��� �
outpkt/mail (����������� e-mail). ������ ������ �������������� ������������
��� �������� �� ������.

����� ��� ��������� ������� ������� ������� ��� fidogate ������ �� ����� ��
��� ����� squish'� ��� jam'� � �������� ������ � *.pkt.

��������, ������� �������� ����� ���� ������:

------ tossin --------
#! /bin/sh

# ������ �����
runinc -a /path_to/uuedec.pl

# ��������� ������ ��� ��������� �������� �����. ��� ����� �� netmaildir
# ��������������� � toss/route (procin.pl). ���������� ����� ������������
# ������, ����� ��� ��� � ��� ������� �������� � toss/route (procout.pl)
itraxp -c itraxp.cfg procin.pl procout.pl

# ������� �� ��� � ��� ����� � toss/route
/usr/local/libexec/ftnpack --pkt
-----------------------

------ tossout --------
#! /bin/sh

# ��������� ���� (outpkt, outpkt/mail) �������������� �� ������
itraxp -c itraxp.cfg procout.pl

# ��������� news'�
/usr/local/libexec/send-fidogate

# ������������ news'� (outpkt/news) �������������� �� ������
runinc -o
-----------------------



Q: ����� ������ ����� ����� �������� ��� ������ � FG?
A: �������� ����� ������, �� ��� ������ ����� �������� itraxp. � ��������
   �������� ��� itraxp'� ������������ �������� �������, ��� ���� ��� �������
   ����������� � �������� ���������. ���� �� �� ������ perl'� ������
   ����������� FTrack.

Q: ����������� �� �������� FG � --dnt-netmail.
A: ���� �� ������������ ������������ ������, ���������� ������� FG �
   --dnt-netmail. ���� FG ����� ������ ��� ���� �����, ��������� ���� �����
   ������ ���� ������� (��������, ���� ������� ������ �� ����� ��������,
   ������� ������ ����������).


���� ���� ��������� ��� ���������� ������ �� bey0nd ��� �� mail.ru ���
						      Andrew Zhuravlev �� 2:5035/67
