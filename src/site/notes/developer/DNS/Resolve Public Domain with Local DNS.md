---
{"dg-publish":true,"tags":["DNS","domain","local"],"permalink":"/developer/dns/resolve-public-domain-with-local-dns/","dgPassFrontmatter":true,"dg-note-properties":{"tags":["DNS","domain","local"]}}
---

If you've ever done self hosting and have bought a public domain, soon enough you'll come across resolving issues when you're on said home network.

For example, let's say you just purchased `shiny-new-domain.com` and you point that domain to your home IP address to get the static site. Now when you try to go to `http://shiny-new-domain.com` it takes a round trip through the external registry just to come all the way back home. 

With [[developer/Home Lab/Nginx Proxy Manager\|Nginx Proxy Manager]] and [[developer/Home Lab/Pi-hole\|Pi-hole]] you can locally resolve this domain so it uses local IP address. Traffic never leaves your home.

> [!tip] Local CNAME record
> I'm going to add one more step here. I am able to create a local record `proxy.lan` so that it's easy to remember and replace if I ever need to swap in a different proxy server.

1. **Pi-hole** https://pi.hole/admin/settings/dnsrecords 
2. **local DNS records**
	1. Domain = `proxy.lan`, IP = `192.168.0.101` 
3. **Local CNAME records**
	1. Domain = `shiny-new-domain.com`, Target = `proxy.an`
## Test with dig
Test to see if it's working. the "ANSWER SECTION:" will let you know each travel step. You *should only* see local IP addresses. 

```shell
dig shiny-new-domain.com @192.168.0.101

; <<>> DiG 9.10.6 <<>> shiny-new-domain.com @192.168.0.101
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 1434
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;shiny-new-domain.com.            IN      A

;; ANSWER SECTION:
shiny-new-domain.com.     0       IN      CNAME   proxy.lan.
proxy.lan.              0       IN      A       192.168.0.100

;; Query time: 55 msec
;; SERVER: 192.168.1.2#53(192.168.1.2)
;; WHEN: Mon Jul 27 20:32:17 CDT 2026
;; MSG SIZE  rcvd: 86
```

`192.168.0.100` is the PC that runs [[developer/Home Lab/Nginx Proxy Manager\|Nginx Proxy Manager]]