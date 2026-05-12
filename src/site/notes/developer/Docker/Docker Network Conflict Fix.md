---
{"dg-publish":true,"tags":["docker","container"],"permalink":"/developer/docker/docker-network-conflict-fix/","dgPassFrontmatter":true}
---

[[developer/Home Lab/Docker\|Docker]] system service was having trouble launching

```shell
## trying a docker command
docker ps 

Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?

## check service status
systemctl status docker

docker.service - Docker Application Container Engine      Loaded: loaded (/usr/lib/systemd/system/docker.service;
enabled
; preset:
enabled
)     Drop-In: /etc/systemd/system/docker.service.d              └─override.conf      Active:
failed
 (Result: exit-code) since Thu 2026-05-07 01:16:49 CDT; 11h ago  Invocation: d2bcd05b72d143889f43f0c61cb92774 TriggeredBy:
×
 docker.socket        Docs: [https://docs.docker.com ](https://docs.docker.com)    Process: 2975 ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
(code=exited, status=1/FAILURE)
    Main PID: 2975 (code=exited, status=1/FAILURE)  May 07 01:16:49 icicle systemd[1]: docker.service: Scheduled restart job, restart counter is at 3. May 07 01:16:49 icicle systemd[1]:
docker.service: Start request repeated too quickly.
 May 07 01:16:49 icicle systemd[1]:
docker.service: Failed with result 'exit-code'.
 May 07 01:16:49 icicle systemd[1]:
Failed to start docker.service - Docker Application Container Engine.
```

check the journalctl

```shell
journalctl -u docker.service -n 50 --no-pager

May 07 01:16:35 icicle dockerd[1259]: time="2026-05-07T01:16:35.043096085-05:00" level=info msg="Deleting nftables IPv6 rules" error="exit status 1" output="Error: Could not process rule: No such file or directory\ndelete table ip6 docker-bridges"
May 07 01:16:36 icicle dockerd[1259]: time="2026-05-07T01:16:36.294534785-05:00" level=info msg="Daemon shutdown complete" error="failed to start daemon: Error initializing network controller: error creating default \"bridge\" network: cannot create network 4f14ab4226c99977b49eb01b85bce61875d800eb8fb795fd75436782f0019dd3 (docker0): conflicts with network a28def9fe15f0a1e2732d1af43ff7ca0c59702028ac53b7053aba54934449eae (docker0): networks have same bridge name"
May 07 01:16:36 icicle dockerd[1259]: failed to start daemon: Error initializing network controller: error creating default "bridge" network: cannot create network 4f14ab4226c99977b49eb01b85bce61875d800eb8fb795fd75436782f0019dd3 (docker0): conflicts with network a28def9fe15f0a1e2732d1af43ff7ca0c59702028ac53b7053aba54934449eae (docker0): networks have same bridge name
May 07 01:16:36 icicle systemd[1]: docker.service: Main process exited, code=exited, status=1/FAILURE
May 07 01:16:36 icicle systemd[1]: docker.service: Failed with result 'exit-code'.
May 07 01:16:36 icicle systemd[1]: Failed to start docker.service - Docker Application Container Engine.
May 07 01:16:36 icicle systemd[1]: docker.service: Consumed 1.677s CPU time, 192M memory peak.
May 07 01:16:38 icicle systemd[1]: docker.service: Scheduled restart job, restart counter is at 1.
May 07 01:16:38 icicle systemd[1]: Starting docker.service - Docker Application Container Engine...
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.563873595-05:00" level=info msg="Starting up"
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.564304343-05:00" level=info msg="OTEL tracing is not configured, using no-op tracer provider"
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.565635091-05:00" level=info msg="CDI directory does not exist, skipping" dir=/etc/cdi
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.579057317-05:00" level=info msg="Creating a containerd client" address=/run/containerd/containerd.sock timeout=1m0s
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.582344207-05:00" level=info msg="Loading containers: start."
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.586231611-05:00" level=info msg="NRI is disabled"
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.634193594-05:00" level=info msg="[graphdriver] using prior storage driver: overlay2"
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.712554642-05:00" level=info msg="Restoring containers: start."
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.817136377-05:00" level=info msg="Deleting nftables IPv4 rules" error="exit status 1" output="Error: Could not process rule: No such file or directory\ndelete table ip docker-bridges"
May 07 01:16:38 icicle dockerd[2255]: time="2026-05-07T01:16:38.860940019-05:00" level=info msg="Deleting nftables IPv6 rules" error="exit status 1" output="Error: Could not process rule: No such file or directory\ndelete table ip6 docker-bridges"
May 07 01:16:41 icicle dockerd[2255]: time="2026-05-07T01:16:41.561873012-05:00" level=info msg="stopping event stream following graceful shutdown" error="<nil>" module=libcontainerd namespace=moby
May 07 01:16:41 icicle dockerd[2255]: time="2026-05-07T01:16:41.563091227-05:00" level=info msg="Daemon shutdown complete" error="failed to start daemon: Error initializing network controller: error creating default \"bridge\" network: cannot create network c46d8b18025a6a266f99cd64d6071f936ab8a9c29c57770f28be60abe3ab9aa8 (docker0): conflicts with network a28def9fe15f0a1e2732d1af43ff7ca0c59702028ac53b7053aba54934449eae (docker0): networks have same bridge name"
May 07 01:16:41 icicle dockerd[2255]: failed to start daemon: Error initializing network controller: error creating default "bridge" network: cannot create network c46d8b18025a6a266f99cd64d6071f936ab8a9c29c57770f28be60abe3ab9aa8 (docker0): conflicts with network a28def9fe15f0a1e2732d1af43ff7ca0c59702028ac53b7053aba54934449eae (docker0): networks have same bridge name
May 07 01:16:41 icicle systemd[1]: docker.service: Main process exited, code=exited, status=1/FAILURE
May 07 01:16:41 icicle systemd[1]: docker.service: Failed with result 'exit-code'.
May 07 01:16:41 icicle systemd[1]: Failed to start docker.service - Docker Application Container Engine.
May 07 01:16:41 icicle systemd[1]: docker.service: Consumed 2.636s CPU time, 48.3M memory peak.
May 07 01:16:43 icicle systemd[1]: docker.service: Scheduled restart job, restart counter is at 2.
May 07 01:16:43 icicle systemd[1]: Starting docker.service - Docker Application Container Engine...
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.822839336-05:00" level=info msg="Starting up"
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.823179478-05:00" level=info msg="OTEL tracing is not configured, using no-op tracer provider"
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.824817402-05:00" level=info msg="CDI directory does not exist, skipping" dir=/etc/cdi
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.838497840-05:00" level=info msg="Creating a containerd client" address=/run/containerd/containerd.sock timeout=1m0s
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.841964140-05:00" level=info msg="Loading containers: start."
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.846623100-05:00" level=info msg="NRI is disabled"
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.858526232-05:00" level=info msg="[graphdriver] using prior storage driver: overlay2"
May 07 01:16:43 icicle dockerd[2975]: time="2026-05-07T01:16:43.915806924-05:00" level=info msg="Restoring containers: start."
May 07 01:16:44 icicle dockerd[2975]: time="2026-05-07T01:16:44.003526854-05:00" level=info msg="Deleting nftables IPv4 rules" error="exit status 1" output="Error: Could not process rule: No such file or directory\ndelete table ip docker-bridges"
May 07 01:16:44 icicle dockerd[2975]: time="2026-05-07T01:16:44.041040929-05:00" level=info msg="Deleting nftables IPv6 rules" error="exit status 1" output="Error: Could not process rule: No such file or directory\ndelete table ip6 docker-bridges"
May 07 01:16:46 icicle dockerd[2975]: time="2026-05-07T01:16:46.997514748-05:00" level=info msg="stopping event stream following graceful shutdown" error="<nil>" module=libcontainerd namespace=moby
May 07 01:16:46 icicle dockerd[2975]: time="2026-05-07T01:16:46.998381265-05:00" level=info msg="Daemon shutdown complete" error="failed to start daemon: Error initializing network controller: error creating default \"bridge\" network: cannot create network adbd932b81bf56389033f314881b079f7392f07f5c6d1200d88ddab43d91dc0c (docker0): conflicts with network a28def9fe15f0a1e2732d1af43ff7ca0c59702028ac53b7053aba54934449eae (docker0): networks have same bridge name"
May 07 01:16:46 icicle dockerd[2975]: failed to start daemon: Error initializing network controller: error creating default "bridge" network: cannot create network adbd932b81bf56389033f314881b079f7392f07f5c6d1200d88ddab43d91dc0c (docker0): conflicts with network a28def9fe15f0a1e2732d1af43ff7ca0c59702028ac53b7053aba54934449eae (docker0): networks have same bridge name
May 07 01:16:46 icicle dockerd[2975]: time="2026-05-07T01:16:46.998435361-05:00" level=info msg="stopping event stream following graceful shutdown" error="context canceled" module=libcontainerd namespace=plugins.moby
May 07 01:16:47 icicle systemd[1]: docker.service: Main process exited, code=exited, status=1/FAILURE
May 07 01:16:47 icicle systemd[1]: docker.service: Failed with result 'exit-code'.
May 07 01:16:47 icicle systemd[1]: Failed to start docker.service - Docker Application Container Engine.
May 07 01:16:47 icicle systemd[1]: docker.service: Consumed 2.874s CPU time, 45.8M memory peak.
May 07 01:16:49 icicle systemd[1]: docker.service: Scheduled restart job, restart counter is at 3.
May 07 01:16:49 icicle systemd[1]: docker.service: Start request repeated too quickly.
May 07 01:16:49 icicle systemd[1]: docker.service: Failed with result 'exit-code'.
May 07 01:16:49 icicle systemd[1]: Failed to start docker.service - Docker Application Container Engine.
root@icicle:/var/lib/docker# systemctl status containerd
● containerd.service - containerd container runtime
     Loaded: loaded (/usr/lib/systemd/system/containerd.service; enabled; preset: enabled)
     Active: active (running) since Thu 2026-05-07 01:16:32 CDT; 11h ago
 Invocation: f24e3312b00e4c088817ad55a83cee5f
       Docs: https://containerd.io
    Process: 968 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 986 (containerd)
      Tasks: 12
     Memory: 61.1M (peak: 63M)
        CPU: 35.230s
     CGroup: /system.slice/containerd.service
             └─986 /usr/bin/containerd

May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.779418448-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.779434873-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.779444314-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.779452963-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.779460986-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.779508108-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.781344146-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.781405081-05:00" level=info >
May 07 01:16:32 icicle containerd[986]: time="2026-05-07T01:16:32.781477770-05:00" level=info >
May 07 01:16:32 icicle systemd[1]: Started containerd.service - containerd container runtime.

root@icicle:/var/lib/docker# dockerd --validate
configuration OK
root@icicle:/var/lib/docker# df -h /var/lib/docker
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2       466G  192G  252G  44% /
root@icicle:/var/lib/docker# netstat -tulpn | grep dockerd
```

Docker has a **network conflict** - there are duplicate network entries with the same bridge name (`docker0`). This is corrupting the network database.

```shell
# Stop Docker (it's already stopped, but let's be sure)
sudo systemctl stop docker docker.socket

# Remove the corrupted network state
sudo rm -rf /var/lib/docker/network/

# Start Docker - it will recreate the network database cleanly
sudo systemctl start docker
```

Docker is trying to create the default bridge network but finds conflicting entries in its database - multiple networks claiming the same `docker0` bridge name. Removing `/var/lib/docker/network/` clears this corruption, and Docker will rebuild it from scratch.

## Prune containers and networks
```shell
# Remove all stopped containers (they reference the old networks)
docker container prune -f

# Remove all networks (they'll be recreated)
docker network prune -f
```

Immediately after I was having network issues about "all predefined address pools have been fully subnetted". Here is that troubleshooting guide.

[[developer/Docker/Docker All Predefined address Pools have been fully subnetted\|Docker All Predefined address Pools have been fully subnetted]]