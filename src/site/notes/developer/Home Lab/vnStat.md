---
{"dg-publish":true,"permalink":"/developer/home-lab/vn-stat/","tags":["monitor","network","metrics"],"noteIcon":"","created":"2026-08-09T11:58:41.000-05:00","updated":"2026-08-09T11:58:41.000-05:00","dg-note-properties":{"tags":["monitor","network","metrics"]}}
---

I've used [[developer/Home Lab/Glances\|Glances]] to monitor server metrics, but it does not capture historical data such as

- Upload today
- Download today
- This month
- Last month
- Lifetime
- Daily totals
- Monthly totals

## installation on Debian
```sh
sudo apt update
sudo apt install vnstat
```

If you run Docker containers (or any virtualization), it's advisable to scope down what network interfaces you want to monitor as to avoid monitoring 10s-100s of `veth0`

```sh
## check your interface names
ifconfig

sudo nano /etc/vnstat.conf
```

```conf
# default interface (leave empty for automatic selection)
;Interface "eth0"
```

```sh
sudo vnstat -i eth0
eth0: No data. Timestamp of last update is same 2026-08-06 22:03:36 as of database creation.
```

Now view stats
```sh
vnstat -i eth0
```

```sh
Database updated: 2026-08-06 22:08:40

   eth0 since 2026-08-06

          rx:  29.43 MiB      tx:  64.60 MiB      total:  94.03 MiB

   monthly
                     rx      |     tx      |    total    |   avg. rate
     ------------------------+-------------+-------------+---------------
       2026-08     29.43 MiB |   64.60 MiB |   94.03 MiB |    2.59 Mbit/s
     ------------------------+-------------+-------------+---------------
     estimated    204.87 GiB |  449.67 GiB |  654.54 GiB |

   daily
                     rx      |     tx      |    total    |   avg. rate
     ------------------------+-------------+-------------+---------------
         today     29.43 MiB |   64.60 MiB |   94.03 MiB |    2.59 Mbit/s
     ------------------------+-------------+-------------+---------------
     estimated     31.91 MiB |   70.04 MiB |  101.96 MiB |
```

## Aggregate to Home Assistant InfluxDB
I want to save and view this information in my [[developer/Home Lab/Grafana & InfluxDB in Home Assistant Dasbhoard\|Grafana & InfluxDB in Home Assistant Dasbhoard]]. We gotta makes some sensors. On to `configuration.yaml` or better nested inside `command_line.yaml` without the `command_line:` prefix

- today: poll every hour `3600`s
- month: poll every day `86400`s
- lifetime: poll every 30 days `2592000`s (can't trigger at top of the month)

Don't forget to install jq on the server. i.e. `mint.lan`

> [!note] Both options use `jq` on the server
>  ```sh
sudo apt update
sudo apt install jq
> ```

### Command Line Sensor
The option with the least amount of extra plugins but does come with some timing caveats. For example:

You will not be accurately polling ''end of day" or "1st of the month". Just whatever the last 24hrs and 30days when the server last restarted.  

Comes with some funky double quote string escaping `\"`

<details>
<summary>configuration.yaml</summary>
<pre>
	command_line:
		- sensor:
		    name: mint_lan_vnstat_enp5s0_rx_today
		    unique_id: mint_lan_vnstat_enp5s0_rx_today
		    command: >
		      ssh spearmint@mint.lan "vnstat --json d | jq '.interfaces[] | select(.name==\"enp5s0\") | .traffic.day[-1].rx'"
		    unit_of_measurement: "KiB"
		    scan_interval: 3600
		- sensor:
		    name: mint_lan_vnstat_enp5s0_tx_today
		    unique_id: mint_lan_vnstat_enp5s0_tx_today
		    command: >
		      ssh spearmint@mint.lan "vnstat --json d | jq '.interfaces[] | select(.name==\"enp5s0\") | .traffic.day[-1].tx'"
		    unit_of_measurement: "KiB"
		    scan_interval: 3600
		- sensor:
		    name: mint_lan_vnstat_enp5s0_rx_month
		    unique_id: mint_lan_vnstat_enp5s0_rx_month
		    command: >
		      ssh spearmint@mint.lan "vnstat --json d | jq '.interfaces[] | select(.name==\"enp5s0\") | .traffic.month[-1].rx'"
		    unit_of_measurement: "KiB"
		    scan_interval: 86400
		- sensor:
		    name: mint_lan_vnstat_enp5s0_tx_month
		    unique_id: mint_lan_vnstat_enp5s0_tx_month
		    command: >
		      ssh spearmint@mint.lan "vnstat --json d | jq '.interfaces[] | select(.name==\"enp5s0\") | .traffic.month[-1].tx'"
		    unit_of_measurement: "KiB"
		    scan_interval: 86400
		- sensor:
		    name: mint_lan_vnstat_enp5s0_rx_total
		    unique_id: mint_lan_vnstat_enp5s0_rx_total
		    command: >
		      ssh spearmint@mint.lan "vnstat --json d | jq '.interfaces[] | select(.name==\"enp5s0\") | .traffic.total.rx'"
		    unit_of_measurement: "KiB"
		    scan_interval: 2592000
		- sensor:
		    name: mint_lan_vnstat_enp5s0_tx_total
		    unique_id: mint_lan_vnstat_enp5s0_tx_total
		    command: >
		      ssh spearmint@mint.lan "vnstat --json d | jq '.interfaces[] | select(.name==\"enp5s0\") | .traffic.total.tx'"
		    unit_of_measurement: "KiB"
		    scan_interval: 2592000
	</pre>
</details>


> [!warning] needs ssh keys
One thing to double check before this will actually work: **command_line sensors run non-interactively**, so this needs passwordless SSH key auth from the HA host to `mint.lan` (as user `spearmint`) — no password prompt can succeed here. If you haven't set that up yet:

```bash
# on the HA host (or inside the HA container)
ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519_mint
ssh-copy-id -i ~/.ssh/id_ed25519_mint.pub spearmint@mint.lan
```
### MQTT Sensor
If you already have the `mosquitto-clients` add-on running, I recommend this approach as it does not require an `ssh-key`, easy to test, and is able to use [[developer/Linux/Crontab\|Crontab]] for: 

- 'first of the month'
- 'end of the day' 

This options is the least work if you plan to run this on multiple servers. 
### On Home Assistant
http://home.lan:8123/config/app/core_mosquitto/config

add login credentials

**SAVE** and **RESTART** Mosquitto app
#### On the Server
> [!warning] Credentials file
> I like to save my username and passwords in a `credentials.conf` file. Mosquitto's client tools don't have a native "read creds from file" flag the way something like `curl --netrc` does

We can get some of the benefits of writing a file like `~/.config/mosquitto-creds.conf` 

```conf
MQTT_USER="yourusername"
MQTT_PASS="yourpassword"
```

> [!error] This is still sent in plain text

**What this actually solves:** keeps the password out of `crontab -l` output and out of your shell history / script files that might get committed to a dotfiles repo — meaningfully better than hardcoding it inline.

**What it doesn't solve:** while `mosquitto_pub` is running, `-u`/`-P` are visible as plain command-line arguments to anyone who runs `ps aux` on that box during that brief window. For a single-user home server this is a low-risk edge case, but it's worth knowing it's not the same guarantee as "never touches an argument list."

**The only way to eliminate that last gap** is the TLS client-certificate route from before — with certs, you reference file _paths_ (`--cert`, `--key`) rather than passing a literal secret as an argument, so there's nothing sensitive in `ps` output at all. That's real setup work though (your own CA, per-device certs, Mosquitto config changes) versus this being a 5-minute fix.
##### install MQTT Broker

```sh
sudo apt update
sudo apt install mosquitto-clients
```

#### Target the Network card
Find your network card. For most it will be `eth0`, for me it is `enp5s0`. You may want to track multiple cards like a wifi network as well.
```sh
ip address show

2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000 link/ether 18:c0:4d:64:3f:01 brd ff:ff:ff:ff:ff:ff inet 192.168.1.102/24 brd 192.168.1.255 scope global dynamic noprefixroute enp5s0 valid_lft 79639sec preferred_lft 79639sec inet6 fe80::3c39:62f8:2bed:b89f/64 scope link noprefixroute valid_lft forever preferred_lft forever

```

##### Test MQTT
open a subscription connection in one terminal
```sh
source /home/spearmint/.config/mosquitto-creds.conf

mosquitto_sub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/#" -v
```

In the other run this and look back at your sub to see a reaction
```sh
mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/tx_total" -m "$(vnstat --json | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.total.tx')"

## subscription window will print
vnstat/mint.lan/enp5s0/tx_total 461448442578
```
##### Crontab -e
```sh
# crontab on mint.lan
# ---- vnstat -> MQTT publishing ----
# creds sourced inline since cron doesn't load your shell profile

# Today's rx/tx — top of every hour
0 * * * * . /home/spearmint/.config/mosquitto-creds.conf; mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/rx_today" -m "$(vnstat --json d | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.day[-1].rx')" -r
0 * * * * . /home/spearmint/.config/mosquitto-creds.conf; mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/tx_today" -m "$(vnstat --json d | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.day[-1].tx')" -r

# This month's rx/tx — top of every day
0 0 * * * . /home/spearmint/.config/mosquitto-creds.conf; mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/rx_month" -m "$(vnstat --json m | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.month[-1].rx')" -r
0 0 * * * . /home/spearmint/.config/mosquitto-creds.conf; mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/tx_month" -m "$(vnstat --json m | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.month[-1].tx')" -r

# Lifetime total rx/tx — top of every month
0 0 1 * * . /home/spearmint/.config/mosquitto-creds.conf; mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/rx_total" -m "$(vnstat --json | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.total.rx')" -r
0 0 1 * * . /home/spearmint/.config/mosquitto-creds.conf; mosquitto_pub -h home.lan -u "$MQTT_USER" -P "$MQTT_PASS" -t "vnstat/mint.lan/enp5s0/tx_total" -m "$(vnstat --json | jq '.interfaces[] | select(.name=="enp5s0") | .traffic.total.tx')" -r
```
### Back to Home Assistant
#### MQTT Sensors
`configuration.yaml`

```yaml
mqtt:
  sensor:
    # ---- mint.lan / enp5s0 ----
    - name: mint_rx_today
      unique_id: mint_lan_vnstat_enp5s0_rx_today
      state_topic: "vnstat/mint.lan/enp5s0/rx_today"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: mint_tx_today
      unique_id: mint_lan_vnstat_enp5s0_tx_today
      state_topic: "vnstat/mint.lan/enp5s0/tx_today"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: mint_rx_month
      unique_id: mint_lan_vnstat_enp5s0_rx_month
      state_topic: "vnstat/mint.lan/enp5s0/rx_month"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: mint_tx_month
      unique_id: mint_lan_vnstat_enp5s0_tx_month
      state_topic: "vnstat/mint.lan/enp5s0/tx_month"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: mint_rx_total
      unique_id: mint_lan_vnstat_enp5s0_rx_total
      state_topic: "vnstat/mint.lan/enp5s0/rx_total"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: mint_tx_total
      unique_id: mint_lan_vnstat_enp5s0_tx_total
      state_topic: "vnstat/mint.lan/enp5s0/tx_total"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    # ---- server2.lan / <interface> ----  (copy block, swap hostname/topic)
    - name: server2_rx_today
      unique_id: server2_lan_vnstat_eth0_rx_today
      state_topic: "vnstat/server2.lan/eth0/rx_today"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server2_tx_today
      unique_id: server2_lan_vnstat_eth0_tx_today
      state_topic: "vnstat/server2.lan/eth0/tx_today"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server2_rx_month
      unique_id: server2_lan_vnstat_eth0_rx_month
      state_topic: "vnstat/server2.lan/eth0/rx_month"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server2_tx_month
      unique_id: server2_lan_vnstat_eth0_tx_month
      state_topic: "vnstat/server2.lan/eth0/tx_month"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server2_rx_total
      unique_id: server2_lan_vnstat_eth0_rx_total
      state_topic: "vnstat/server2.lan/eth0/rx_total"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server2_tx_total
      unique_id: server2_lan_vnstat_eth0_tx_total
      state_topic: "vnstat/server2.lan/eth0/tx_total"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    # ---- server3.lan / <interface> ----  (copy block, swap hostname/topic)
    - name: server3_rx_today
      unique_id: server3_lan_vnstat_eth0_rx_today
      state_topic: "vnstat/server3.lan/eth0/rx_today"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server3_tx_today
      unique_id: server3_lan_vnstat_eth0_tx_today
      state_topic: "vnstat/server3.lan/eth0/tx_today"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server3_rx_month
      unique_id: server3_lan_vnstat_eth0_rx_month
      state_topic: "vnstat/server3.lan/eth0/rx_month"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server3_tx_month
      unique_id: server3_lan_vnstat_eth0_tx_month
      state_topic: "vnstat/server3.lan/eth0/tx_month"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server3_rx_total
      unique_id: server3_lan_vnstat_eth0_rx_total
      state_topic: "vnstat/server3.lan/eth0/rx_total"
      unit_of_measurement: "KiB"
      state_class: total_increasing

    - name: server3_tx_total
      unique_id: server3_lan_vnstat_eth0_tx_total
      state_topic: "vnstat/server3.lan/eth0/tx_total"
      unit_of_measurement: "KiB"
      state_class: total_increasing
```

#### Grafana Query
```sh
## Line graph tracking
SELECT last("value") FROM "KiB" WHERE ("entity_id" =~ /.*_vnstat_(enp5s0)_(rx|tx)_(today|month|total)$/) AND $timeFilter GROUP BY time($__interval), "entity_id" fill(null)

## daily totals bar chart
SELECT last("value") FROM "KiB"
WHERE ("entity_id" =~ /.*_vnstat_(enp5s0)_(rx|tx)_today$/)
AND $timeFilter
GROUP BY time(1d), "entity_id" fill(previous)

## Monthly totals bar chart *may need to mess with panel time range settings*
SELECT last("value") FROM "KiB"
WHERE ("entity_id" =~ /.*_vnstat_(enp5s0)_(rx|tx)_month$/)
AND $timeFilter
GROUP BY time(1d), "entity_id" fill(previous)
```
### Helper script
to avoid the strange escaping inside `yaml` code you could make a `vnstat-json.sh` helper function on the server

```sh
sudo touch /usr/local/bin/vnstat-json.sh
sudo chmod +x /usr/local/bin/vnstat-json.sh
sudo nano /usr/local/bin/vnstat-json.sh
```

```bash
#!/bin/bash
#
# vnstat-json.sh — return a single rx/tx number from vnstat for a given interface + period
#
# Usage:
#   vnstat-json.sh <interface> <rx|tx> <today|yesterday|month|lastmonth|lifetime>
#
# Examples:
#   vnstat-json.sh enp5s0 rx today
#   vnstat-json.sh enp5s0 tx month
#   vnstat-json.sh enp5s0 rx lastmonth
#   vnstat-json.sh enp5s0 tx lifetime
#
# Install on the monitored server (e.g. mint.lan):
#   sudo cp vnstat-json.sh /usr/local/bin/vnstat-json.sh
#   sudo chmod +x /usr/local/bin/vnstat-json.sh
#
# Requires: vnstat, jq

set -euo pipefail

IFACE="${1:-}"
DIRECTION="${2:-}"
PERIOD="${3:-}"

usage() {
  echo "Usage: $0 <interface> <rx|tx> <today|yesterday|month|lastmonth|lifetime>" >&2
  exit 1
}

[[ -z "$IFACE" || -z "$DIRECTION" || -z "$PERIOD" ]] && usage

case "$DIRECTION" in
  rx|tx) ;;
  *) echo "Error: direction must be 'rx' or 'tx'" >&2; exit 1 ;;
esac

case "$PERIOD" in
  today)
    FILTER=".interfaces[] | select(.name==\$iface) | .traffic.day[-1].${DIRECTION}"
    JSON_ARG="d"
    ;;
  yesterday)
    FILTER=".interfaces[] | select(.name==\$iface) | .traffic.day[-2].${DIRECTION}"
    JSON_ARG="d"
    ;;
  month)
    FILTER=".interfaces[] | select(.name==\$iface) | .traffic.month[-1].${DIRECTION}"
    JSON_ARG="m"
    ;;
  lastmonth)
    FILTER=".interfaces[] | select(.name==\$iface) | .traffic.month[-2].${DIRECTION}"
    JSON_ARG="m"
    ;;
  lifetime)
    FILTER=".interfaces[] | select(.name==\$iface) | .traffic.total.${DIRECTION}"
    JSON_ARG=""
    ;;
  *)
    echo "Error: period must be one of today|yesterday|month|lastmonth|lifetime" >&2
    exit 1
    ;;
esac

if [[ -n "$JSON_ARG" ]]; then
  vnstat --json "$JSON_ARG" | jq --arg iface "$IFACE" "$FILTER"
else
  vnstat --json | jq --arg iface "$IFACE" "$FILTER"
fi
```

the HA command now removes the funky `\` character escaping

```yaml
command_line:
  - sensor:
      name: mint_lan_vnstat_enp5s0_rx_today
      unique_id: mint_lan_vnstat_enp5s0_rx_today
      command: ssh spearmint@mint.lan "/usr/local/bin/vnstat-json.sh enp5s0 rx today"
      unit_of_measurement: "KiB"
      scan_interval: 300
```
## Monitoring network wide
I've tried out per monitoring tools like [[developer/Home Lab/Glances\|Glances]], as well as higher up network monitors like [ntopng](https://www.ntop.org/products/traffic-analysis/ntopng/) and [darkstat](https://unix4lyfe.org/darkstat/). My issue is that I'm stuck with a stock router from At&t

I have enabled passthrough and utilizing [[developer/Home Lab/Pi-hole\|Pi-hole]] for DHCP and DNS yet I still don't get the full picture. The pi needs to be "the actual router/gateway, or via a mirrored switch port feeding a monitor" such as pfSense/OPNsense running on my box.

Maybe someday I'll run a open source router. Till then, I'll stick with per device monitoring

```txt
Manufacturer HUMAX 
Model Number BGW320-500

Home Network Status
Device IPv4 Address 	192.168.*.*
DHCPv4 Netmask 	255.255.255.0
DHCP Server 	Off
Secondary Subnet 	Disabled
Public Subnet 	
Cascaded Router Status 	Disabled
IP Passthrough Status 	On (public IP address)
IP Passthrough Address 	120.*.*.*
```

---
## Credit
- https://linuxvox.com/blog/how-to-install-and-use-vnstat-network-traffic-monitoring-tool-in-linux/#installation
- https://community.home-assistant.io/t/monitor-and-estimate-isp-internet-data-cap-usage/395670