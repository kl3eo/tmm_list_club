#!/usr/bin/perl
#

use 5.006;
use DBI;
use CGI;
use TClubMD5;

use JSON;
use Digest::SHA;
use MIME::Base64::URLSafe;

my $debug = 0;

my $query = new CGI;
my $scriptURL = CGI::url();
my %vars = CGI::Vars();
my $user_database = "/home/alex/MY/tmm/handlers/users.db";
my $session_database = "/home/alex/MY/tmm/handlers/sessions.db";
my $randomNumber =  $vars{random} ? $vars{random} : int( rand(4294967296) );
my $aa = $query->param('signed_request');
my ($d,$n,$g,$e,$c,$cid,$ct) = parse_signed_request_data($aa) if ($aa);

my $cool_auth_cookies = 0;
my %Coo = TClubMD5::GetCookies('wtUser','cdAuth','User','v','PROFILE');
$cool_auth_cookies = 1 if ( ($Coo{'wtUser'} && $Coo{'cdAuth'} && $Coo{'User'}) || $Coo{'v'});
print STDERR "Got cookies $Coo{'wtUser'}, $Coo{'cdAuth'}, $Coo{'User'}, $Coo{'v'} !\n" if ($debug);
my $nologin = 1;
my $r_user = "visitatore";

if (  $cool_auth_cookies  ) {
 
	print STDERR "Into login!\n" if ($debug);

	($r_user, $header, $result_message, $reg_passwd, $reg_user, $reg_email, $reg_cookie) = TClubMD5::login($scriptURL,$user_database,$session_database,\%vars,$randomNumber,$d, $n, $g, $e, $c, $cid, $ct,0);

	$r_user = "visitatore" if ($r_user eq "visiteur");

	print STDERR "Debug: after login, time is $tt, r_user is $r_user\n" if ($debug);

} else {

	$r_user = (defined ($Coo{'wtUser'}) && length($Coo{'wtUser'})) ? $Coo{'wtUser'} : "visitatore";
	$nologin = (defined ($Coo{'wtUser'}) && length($Coo{'wtUser'})) ? 0 : 1;
}

if ($header) { print $header; } else {print $query->header('text/html; charset=utf-8');}

$nologin = 1 if ($r_user eq "visitatore");

my $addr=$ENV{'REMOTE_ADDR'};
$nologin = 0 if ($nologin && $addr eq "81.25.50.12");

my $server = "127.0.0.1";
my $user = $primary_user;
my $passwd = $primary_passwd;
my $dbase = $primary_dbase;
my $port = $primary_port;

my $type = defined($query->param('type')) ? $query->param('type') : '';
my $uid = defined($query->param('id')) ? $query->param('id') : 0;
my $uname = defined($query->param('name')) ? $query->param('name') : '';

print STDERR " Here nologin is $nologin!\n" if ($debug);

if ( (length($uname) || $uid) && $nologin) {print "Unauthorized";exit;}

my $dbconn=DBI->connect("dbi:Pg:dbname=$dbase;port=$port;host=$server",$user, $passwd);

my $c = '';

unless (length($type)) {

my $addon = " where p_vremya_z is not null and d_profi != 'new' order by p_vremya_z desc";
my $intim = '';
if (defined($query->param('id')) && $uid) {
	$addon = " where oid = $uid";
}

if (defined($query->param('name')) && length($uname) ) {
	$addon = " where a_nkname = '$uname'";
	$intim = ", concat('https://tennismatchmachine.com/db_images/',substr(md5(uploaded_file),0,9),'_large.jpg') as phurl, h_phone as phone, g_email as email, b_rlname as real_name, g_md_sports as sports, g_url as o_sebe,  
	(select (num_of_played_singles_total(proj_code) + num_of_played_doubles_total(proj_code))) as num_matches, 
	(select count(*) from challenges where owner = proj_code) as num_offers,
	(select count(*) from comments where author = proj_code) as num_comments,
	(select (num_of_played_singles_total(proj_code))) as num_singles,
	(select (num_of_played_doubles_total(proj_code))) as num_doubles,
	(select (num_of_victories_singles(proj_code) + num_of_victories_doubles(proj_code))) as num_victories,
	(select (num_of_losses_singles(proj_code) + num_of_losses_doubles(proj_code))) as num_losses,
	(select (num_of_draws_singles(proj_code) + num_of_draws_doubles(proj_code))) as num_draws";
}

$c = "SELECT ROW_TO_JSON(a) FROM (SELECT oid as _id, 
a_nkname as name, 
split_part(e_masterst, '_', 2) as level, 
split_part(g_mb_raquet, '_', 2) as raquet, 
g_metro as metro, c_yob as yob, 
split_part(g_ma_yost, '_', 2) as yost, 
extract(year from date_accepted) as since, 
p_vremya_z::date as last_seen$intim 
FROM members$addon) a";
} else { #type

my $rest = '';my $prefix = '';
	if ( defined($query->param('name')) && length($uname) && $type eq "matches" ) {
		$addon = ", matches where members.a_nkname = '$uname' and ((matches.participant1 = members.proj_code and matches.participant2 is not null and matches.participant2  != 'bye' and matches.score != 'w/o') 
		or (matches.participant2 = proj_code  and matches.participant1 is not null and matches.participant1  != 'bye' and matches.score != 'w/o')) order by match_date desc";
		$rest = ", matches.score as score, matches.match_date as date, a_nkname(real_winner(matches.oid), matches.winner) as winner, a_nkname(real_loser(matches.oid), matches.winner) as loser, matches.winner as result ";
		$prefix="matches.";
		
	}
$c = "SELECT ROW_TO_JSON(a) FROM (SELECT ".$prefix."oid as _id$rest
FROM members$addon) a";
}
print STDERR $c."\n" 
if ($debug)
;

	my $r=$dbconn->prepare($c);
    	$r->execute;
	&dBaseError($r, $c."  (".$r->rows()." rows found)") if ($r->rows() == -2);
	my $ls = $r->fetchall_arrayref; 
	my $nt = $r->rows();

print '[';	
for (my $j = 0; $j < $nt; $j++) {
	print ${${$ls}[$j]}[0];
	print ',' unless ($j == $nt-1);
}
print ']';

$dbconn->disconnect;
$query->delete_all;
exit;


sub dBaseError {

    my ($check, $message) = @_;
    print "<H4><FONT COLOR=BLACK><P>$message<BR>Error: ".$check->errstr."</FONT></H4>";
    die("Action failed on command:$message  Error_was:$DBI::errstr");
};

sub parse_signed_request_data { #237

    my $signed_request = shift;
    my ($encoded_sig, $payload) = split(/\./, $signed_request);

	my $sig = urlsafe_b64decode($encoded_sig);
	my $stuff = urlsafe_b64decode($payload);
		
    my $data = JSON->new->decode($stuff);

    if (uc($data->{'algorithm'}) ne "HMAC-SHA256") {
    }

    my $expected_sig = Digest::SHA::hmac_sha256($payload, $secret);
    if ($sig ne $expected_sig) {
    }
    return ($data->{'user_id'},$data->{'registration'}->{'name'},$data->{'registration'}->{'gender'},$data->{'registration'}->{'email'},
    $data->{'registration'}->{'location'}->{'name'}, $data->{'registration'}->{'location'}->{'id'}, $data->{'user'}->{'country'});
}
