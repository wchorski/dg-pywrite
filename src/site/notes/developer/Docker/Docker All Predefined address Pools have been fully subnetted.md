---
{"dg-publish":true,"tags":["docker","container","network","virtual"],"permalink":"/developer/docker/docker-all-predefined-address-pools-have-been-fully-subnetted/","dgPassFrontmatter":true}
---

After fixing [[developer/Docker/Docker Network Conflict Fix\|Docker Network Conflict Fix]] I found this new error

```shell
docker
 compose up -d [+] up 1/1
✘
 Network prometheus_default
Error
 Error response from daemon: all predefined address pools have been fully subnetted
0.0s
 failed to create network prometheus_default: Error response from daemon: all predefined address pools have been fully subnetted
```

Let's see how many networks are being used

```shell
docker
 network ls NETWORK ID     NAME                        DRIVER    SCOPE 27eed5ac1642   bridge                      bridge    local 34f4762212b7   cutefruit-kypn-network      bridge    local 85d9ea67cdcb   dockge_default              bridge    local fe5b859293d0   host                        host      local 2e9535afd4ad   immich_default              bridge    local 2c098d2bc2b0   make-a-gram-network         bridge    local 67237c1dc9ef   nginx-prox-mgmt-3_default   bridge    local 40cd7647b974   none                        null      local 33c28b76f570   paisa_paisa-network         bridge    local 60395cd393e9   umami3_default              bridge    local
❯
docker
 network inspect
$(
docker
 network ls -q
)
 |
grep
 -E
'Name|Subnet'
         "
Name
": "bridge",                     "
Subnet
": "172.17.0.0/16",                 "
Subnet
s": {         "
Name
": "cutefruit-kypn-network",                     "
Subnet
": "192.168.144.0/20",                 "
Name
": "cutefruit-kypn-cms",                 "
Name
": "cutefruit-kypn-db",                 "
Name
": "cutefruit-kypn-web",                 "
Subnet
s": {         "
Name
": "dockge_default",                     "
Subnet
": "192.168.160.0/20",                 "
Name
": "dockge-dockge-1",                 "
Subnet
s": {         "
Name
": "host",         "
Name
": "immich_default",                     "
Subnet
": "192.168.192.0/20",                 "
Name
": "immich_redis",                 "
Name
": "immich_postgres",                 "
Name
": "immich_machine_learning",                 "
Subnet
s": {         "
Name
": "make-a-gram-network",                     "
Subnet
": "192.168.208.0/20",                 "
Name
": "make-a-gram",                 "
Subnet
s": {         "
Name
": "nginx-prox-mgmt-3_default",                     "
Subnet
": "192.168.96.0/20",                 "
Name
": "commafeed",                 "
Name
": "make-a-gram",                 "
Name
": "cutefruit-kypn-cms",                 "
Name
": "paisa",                 "
Name
": "nginx-proxy-mgmt-3",                 "
Name
": "cutefruit-kypn-web",                 "
Subnet
s": {         "
Name
": "none",         "
Name
": "paisa_paisa-network",                     "
Subnet
": "192.168.224.0/20",                 "
Name
": "paisa",                 "
Subnet
s": {         "
Name
": "umami3_default",                     "
Subnet
": "192.168.128.0/20",                 "
Name
": "umami3-umami-1",                 "
Name
": "umami3-db-1",                 "
Subnet
s": {
❯
docker
 ps --format
'{{.Names}}\t{{.Networks}}'
 paisa   nginx-prox-mgmt-3_default,paisa_paisa-network make-a-gram     make-a-gram-network,nginx-prox-mgmt-3_default immich_server   immich_default immich_machine_learning immich_default immich_postgres immich_default immich_redis    immich_default dockge-dockge-1 dockge_default cutefruit-kypn-web      cutefruit-kypn-network,nginx-prox-mgmt-3_default cutefruit-kypn-cms      nginx-prox-mgmt-3_default,cutefruit-kypn-network cutefruit-kypn-db       cutefruit-kypn-network commafeed       nginx-prox-mgmt-3_default umami3-umami-1  umami3_default umami3-db-1     umami3_default nginx-proxy-mgmt-3      nginx-prox-mgmt-3_default
❯
docker
 network prune -f
❯
docker
 compose up -d [+] up 1/1
✘
 Network pvo-kypn-network
Error
 Error response from daemon: all predefined address pools have been fully subnetted
0.0s
 failed to create network pvo-kypn-network: Error response from daemon: all predefined address pools have been fully subnetted
```

There are 8 networks active, which is well under a normal limit. For some reason Docker's default pool is surprisingly small. We can expand it.

```shell
sudo nano /etc/docker/daemon.json
```

add in the `default-address-pools` line.

```json
❯ sudo cat /etc/docker/daemon.json
{
    "metrics-addr": "0.0.0.0:9323",
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    },
		"default-address-pools": [
    {
      "base": "172.17.0.0/12",
      "size": 24
    }
  ]
}
```

```shell
systemctl restart docker
```

> [!tip] You'll need to re deploy existing containers