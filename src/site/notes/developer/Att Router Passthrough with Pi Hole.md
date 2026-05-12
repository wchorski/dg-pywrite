---
{"dg-publish":true,"tags":["network","internet","router"],"permalink":"/developer/att-router-passthrough-with-pi-hole/","dgPassFrontmatter":true}
---

Just recently I was setup with At&t internet. They *generously* provide a dual modem/router with the service.  I was having a time trying to use my own router.
## Passthrough mode
[At&t's official docs](https://www.att.com/support/smallbusiness/article/smb-internet/KM1188700/) is a bit incomplete. This [PCGuide](https://www.pcguide.com/router/how-to/use-with-att-fiber/) tutorial was a bit more helpful. 
## My Router
I'm using a TP-Link router. Logging into it's dashboard I confirm that it is getting internet connection (also shown on the led lights as green. Amber meaning connection failure)

Make sure they are running on different subnets. Example: 
- At&t -> `192.168.1.1` http://192.168.1.254/cgi-bin/home.ha
- TP-Link -> `192.168.0.1`
## Pi-Hole
I run a [[developer/Home Lab/Pi-hole\|Pi-hole]] that handles DNS and DHCP. This is where things got tricky. My **Upstream DNS server** https://pi.hole/admin/settings/dns had no options checked (Google, Cloudflare, OpenDNS, etc.) I had set it up using Unbound for extra privacy but it seems like I have to re configure that...? For now I'm just using Cloudflare and OpenDNS just to get things working
## PiVPN
I've noticed anytime I've moved that I also have to generate new VPN keys. Idk why, but same problem here. 
## Video Tutorial
https://www.youtube.com/watch?v=aShbl1JZMx8
## Port Forward on Att Modem
I was having trouble with accessing my services (pointed to public domain's) when on my local network. Here is an example

My website www.WilliaMusic.com is a public domain. When on my phone's mobile 5G i can access the site just fine. Once I went on my home's local network I couldn't reach the site. I had to do 2 things

1. Port forward on the Att Router ([screenshots](https://imgur.com/a/E6KNJMg))
	1. Something about NAT and the ISP's router still being the Gateway (kinda stumbled through understanding the *why*)
2. create local DNS record for outside DDNS
	1. All my public DNS points to a DDNS that auto updates (no need for static IP) that domain is MYDOMAIN.duckdns.org
	2. on my local DNS with [[developer/Home Lab/Pi-hole\|Pi-hole]] ~~I make a record~~ `MYDOMAIN.duckdns.org` ~~point to my local server~~ `proxy-server.lan` (another local DNS record pointing to a local IP) ==on second thought I don't think this helped and actually made it worse==