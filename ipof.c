#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <net/if.h>

#include <sysexits.h>
#include <ifaddrs.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

int main(int argc, char* argv[])
{
	struct ifaddrs *ifaddr = NULL;
	struct ifaddrs *ifa = NULL;
	char host[INET_ADDRSTRLEN];

	bzero(host, sizeof(host));

	if(argc < 2) {
		fprintf(stderr, "usage: %s eth0\n", argv[0]);
		exit(EX_USAGE);
	}

	if (getifaddrs(&ifaddr) == -1) {
		err(EX_OSERR, "getifaddrs(3) failed");
	}

        for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
		if(ifa->ifa_addr == NULL || ifa->ifa_addr->sa_family != AF_INET)
			continue;

		if(strncmp(argv[1], ifa->ifa_name, IF_NAMESIZE) == 0) {
			struct sockaddr_in *in = (struct sockaddr_in *) ifa->ifa_addr;
			inet_ntop(AF_INET, &(in->sin_addr), host, sizeof(host));
			printf("%s", host);
			break;
		}
	}

	freeifaddrs(ifaddr);
	exit(EX_OK);
	/* NOTREACHED */
	return(EX_OK);
}