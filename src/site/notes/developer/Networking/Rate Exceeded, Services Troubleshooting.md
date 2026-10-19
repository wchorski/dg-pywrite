---
{"dg-publish":true,"permalink":"/developer/networking/rate-exceeded-services-troubleshooting/","noteIcon":"","created":"2026-10-19T09:49:13.331-05:00","updated":"2026-10-19T16:26:01.440-05:00","dg-note-properties":{}}
---

Over 7 days my service watcher [[developer/Home Lab/Uptime Kuma\|Uptime Kuma]] was constantly going up and down within hours

|   |   |   |
|---|---|---|
|Down|2026-10-19 09:14:57|Request failed with status code 502|
|Up|2026-10-19 08:59:57|200 - OK|
|Down|2026-10-19 08:15:11|timeout of 48000ms exceeded|
|Up|2026-10-19 05:32:34|200 - OK|
|Down|2026-10-19 05:09:22|timeout of 48000ms exceeded|
|Up|2026-10-19 04:52:34|200 - OK|
|Down|2026-10-19 04:35:47|timeout of 48000ms exceeded|
|Up|2026-10-19 03:41:46|200 - OK|

I first had a feeling this had to do with my reverse proxy [[developer/Home Lab/Nginx Proxy Manager\|Nginx Proxy Manager]] but that was not the case. Then I checked [[developer/Home Lab/Pi-hole\|Pi-hole]] logs

![attachments/Pasted image 20261019162530.png](/img/user/attachments/Pasted%20image%2020261019162530.png)

There was an abnormal forwarded queries

https://pi.hole/admin/taillog?file=ftl 

or

```sh
tail -F /var/log/pihole/FTL.log
```

There I saw some rate limiting found

```sh
2026-10-19 08:25:59.687 INFO Rate-limiting 192.168.1.100 for at least 39 seconds
2026-10-19 08:26:38.493 INFO Still rate-limiting 192.168.1.100 as it made additional 4508 queries
2026-10-19 08:27:38.498 INFO Still rate-limiting 192.168.1.100 as it made additional 1713 queries
2026-10-19 08:37:38.554 INFO Still rate-limiting 192.168.1.100 as it made additional 1161 queries
2026-10-19 08:38:38.558 INFO Ending rate-limitation of 192.168.1.100
2026-10-19 08:38:56.210 INFO Received 8/8 valid NTP replies from pool.ntp.org
2026-10-19 08:38:56.210 INFO NTP time offset: 2.043128e+00 ms (excluded 0 outliers)
2026-10-19 08:38:56.210 INFO NTP round-trip delay: 5.131018e+01 ms (excluded 0 outliers)
2026-10-19 08:43:16.307 INFO Rate-limiting 192.168.1.100 for at least 22 seconds
2026-10-19 08:43:38.590 INFO Ending rate-limitation of 192.168.1.100
2026-10-19 08:44:07.791 INFO Rate-limiting 192.168.1.100 for at least 31 seconds
2026-10-19 08:44:38.594 INFO Still rate-limiting 192.168.1.100 as it made additional 1831 queries
2026-10-19 08:45:38.600 INFO Still rate-limiting 192.168.1.100 as it made additional 4920 queries
2026-10-19 08:50:38.626 INFO Still rate-limiting 192.168.1.100 as it made additional 1486 queries
2026-10-19 08:51:38.758 INFO Ending rate-limitation of 192.168.1.100
2026-10-19 09:00:19.891 INFO Rate-limiting 192.168.1.100 for at least 19 seconds
2026-10-19 09:00:38.810 INFO Ending rate-limitation of 192.168.1.100
2026-10-19 09:38:56.678 INFO Received 8/8 valid NTP replies from pool.ntp.org
2026-10-19 09:38:56.678 INFO NTP time offset: 1.721048e+01 ms (excluded 1 outliers)
2026-10-19 09:38:56.678 INFO NTP round-trip delay: 4.696533e+01 ms (excluded 1 outliers)
```

`192.168.1.100` is where i host a lot of my services and where [[developer/Home Lab/Uptime Kuma\|Uptime Kuma]] is deployed. 

Luckily I run docker container monitoring with [[developer/Home Lab/Prometheus\|Prometheus]] and Grafana --> [[developer/Docker/Monitor Docker Containers with Grafana\|Monitor Docker Containers with Grafana]]

![attachments/Pasted image 20261019095903.png](/img/user/attachments/Pasted%20image%2020261019095903.png)

Here I can see that [[developer/Home Lab/umami\|umami]] analytic is running crazy high usage. 

Didn't catch what exactly was running Umami ragged, but stoping the container made the rate limiting calm down. 