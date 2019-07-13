use Socket;

sub randint {
	$min = int(@_[0]);
	$max = int(@_[1]);
	$n = int(rand($max - $min + 1) + $min);
	return $n;
}
$proto = getprotobyname('tcp');

my($sock);
socket($sock, PF_INET, SOCK_STREAM, $proto);

$host = 'localhost';
$port = 2127;
$iaddr = inet_aton($host);
$addr = sockaddr_in($port, $iaddr);

connect($sock, $addr) or "Connection error!";

for (1..10) {
	$num = randint(1000, 9999);
	send($sock, "$num ", 0);
	
}

close($sock);