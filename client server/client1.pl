use Socket;
#use strict;

$| = 1;
sub randint{
	$min = int(@_[0]);
	$max = int(@_[1]);
	
	$n = int(rand($max + 1 - $min) + $min);	
	return $n;
}	

sub rec_val{
	my($sock) = @_;
	
	recv($sock, $min, 200, 0);
	$min = unpack "N", $min; 
	recv($sock, $max, 200, 0);
	$max = unpack "N", $max;
	recv($sock, $range, 200, 0);
	$range = unpack "N", $range;

	for(1..$range){
		$n = randint($min, $max);

		send($sock, "$n\n", 0);
		sleep(1);
	}
}

sub recvBack{
	my($sock) = @_;
	print "Here is the random number back: \n\n";
	recv($sock, $msg, 2000 , 0);
	print "$msg";
}

$proto = getprotobyname('tcp');
$host = 'localhost';
$port = 5000;
$iaddr = inet_aton($host);
$addr = sockaddr_in($port, $iaddr);

my($sock);
socket($sock, PF_INET, SOCK_STREAM, $proto);

connect($sock, $addr) or die "Connection error: $!";

rec_val($sock);

recvBack($sock);

close($sock);
