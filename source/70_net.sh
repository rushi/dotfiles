# IP addresses
#alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
#alias wanip="curl -w '\n' -s --fail ifconfig.me"
# alias whois="whois -h whois-servers.net"
alias wanip="curl -s --fail ipv4.icanhazip.com"
alias wanipv6="curl -s --fail https://ipv6.icanhazip.com"

# Grab the local lan ip. tested on osx only
alias lanip='ifconfig | grep -E "(?:[0-9]{1,3}\.){3}[0-9]{1,3}"'

# Flush Directory Service cache
alias dnsflush="dscacheutil -flushcache"

# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|(GET|POST) \/.*\""
