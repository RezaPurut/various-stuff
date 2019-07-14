use Socket;

$| = 1;
sub randint{
	$min = int(@_[0]);
	$max = int(@_[1]);
	
	$n = int(rand($max + 1 - $min) + $min);	
	return $n;
}	

sub recvBack{
	my($sock) = @_;
	print "Here is the random number that you sent: \n\n";
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

print "Enter minimum value: ";
$min = <>;
print "Enter maximum value: ";
$max = <>;
print "Total random number to generate: ";
$range = <>;

for(1..$range){
	$n = randint($min, $max);
	#$n = int(rand(99999 + 1 - 10000) + 10000); 
	send($sock, "$n\n", 0);
	sleep(1);
}

recvBack($sock);

close($sock);
