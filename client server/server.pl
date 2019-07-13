use Socket;

$proto = getprotobyname('tcp');

my($sock);
socket($sock, PF_INET, SOCK_STREAM, $proto);

$port = 2127;
$addr = sockaddr_in($port, INADDR_ANY);

bind($sock, $addr) or die "Bind error!";

listen($sock, SOMAXCONN) or die "Listen error!";
print "[+] Listening ... \n";

while(1) {
	my($client);
	$addrinfo = accept($client, $sock);

	my($port, $iaddr) = sockaddr_in($addrinfo);
	my $name = gethostbyaddr($iaddr, AF_INET);

	print "[+] Connection from $name \n";
	while($line = <$client>) {
		print "[+] $line \n";
	}
}

close($sock);