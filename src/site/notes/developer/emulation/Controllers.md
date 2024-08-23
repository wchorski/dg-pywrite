---
{"dg-publish":true,"permalink":"/developer/emulation/Controllers/","tags":["emulation","gamer","gaming","3rd-party","linux"],"created":"2024-04-20T11:08:10.684-05:00","updated":"2024-04-23T16:59:22.000-05:00"}
---

## PS3 Dualshock Controller Bluetooth
When connecting my controller to my **Linux Mint** emulation machine, it would ask for a pin. This was strange as I never had to do this before, and it would worked wired just fine. Here is the work around

```bash
sudo nano /etc/bluetooth/input.conf

# find and change line
ClassicBondedOnly=false

# after saving file, restart service
sudo systemctl restart bluetooth
```

## Credits
- [updates - Why does official PS3 bluetooth controller no longer work and pin code suddenly required? - Ask Ubuntu](https://askubuntu.com/questions/1497783/why-does-official-ps3-bluetooth-controller-no-longer-work-and-pin-code-suddenly)