---
{"dg-publish":true,"permalink":"/developer/SSH/","created":"2024-02-29T22:19:55.739-06:00","updated":"2024-03-01T00:21:37.000-06:00"}
---



### Ssh-keygen on client
`cp ~/<username>/.ssh/key.pub``
`ssh-copy-id user@<IP>`

### Paste in host
`~/<username>/.ssh/authorized_keys`
or
`ssh-copy-id user@<IP>`

### windows ssh-copy-id
`type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"`

`type $env:USERPROFILE\.ssh\id_rsa.pub | ssh pi4@rpi.lan "cat >> .ssh/authorized_keys"`