---
{"dg-publish":true,"permalink":"/developer/emulation/Steamdeck reset sudo password/","tags":["steam","gaming","admin"],"created":"2025-01-11T16:21:35.082-06:00","updated":"2025-01-11T16:23:45.850-06:00"}
---

 This are the steps on how to reset a forgotten sudo password. You will need a keyboard attached to the Steam Deck to enter the commands easily -

While the Steam Deck is powered off, hold the the 3dots (QAM) and turn on the Steam Deck.

The recovery menu will appear. On your keyboard highlight the 3rd option - CURRENT (OS Boot Menu) then press enter.

The GRUB menu will appear. Highlight the 1st option - SteamOS then on your keyboard press `e` to edit the boot options.

Press down cursor on the keyboard until `steamenv_boot` is highlighted. Press **end** key to go to the end of the line.

append the command to end of line - `init=/bin/bash`

Press CTRL-X to boot!

Enter the command - `mount -n -o rw,remount /`

Enter the command - `passwd deck`

Enter new password and retype the new password.

And finally enter the command - `reboot -f`

sudo password has been reset! You can now boot to desktop mode and use sudo commands using the new password! 

---
## Credits
- https://www.reddit.com/r/SteamDeck/comments/141lyz3/steam_deck_steamos_reset_forgotten_sudo_password/