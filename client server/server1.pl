use Socket;
#use strict;

$| = 1;

sub ask_val{
	
	my($client) = @_;
	
	print "Enter minimum value: ";
	$min = <>;
	print "Enter maximum value: ";
	$max = <>;
	print "Total random number to generate: ";
	$range = <>;
	
	send($client, (pack "N", $min), 0);
	send($client, (pack "N", $max), 0);
	send($client, (pack "N", $range), 0);
	
}
$proto = getprotobyname('tcp');
$port = 5000;
$addr = sockaddr_in($port, INADDR_ANY);

my($sock);
socket($sock, PF_INET, SOCK_STREAM, $proto);

bind($sock, $addr) or die "cannot bind: $!";

listen($sock, SOMAXCONN) or die "cannot listen: $!";
print "[+] Listening ... \n";


while(1)
{
	my($client);
	$addrinfo = accept($client, $sock);
	
	my($port, $iaddr) = sockaddr_in($addrinfo);
	my $name = gethostbyaddr($iaddr, AF_INET);
	print "[+] Connection from $name \n\n";

	ask_val($client);
	
	print "\n[+] Random number is being send ... \n";
	print "\n";
	$count = 1;

	while($line = <$client>)
	{
		print "$count -> "."$line \n";
		send($client, "$count -> "."$line \n", 0);
		$count++;
	}

}



