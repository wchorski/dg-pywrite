---
{"dg-publish":true,"permalink":"/developer/backup-solutions/","tags":["linux","Thunderbird","flstudio","music"],"noteIcon":""}
---



This is my chain of programs that help me backup and store data whether it's local clone, version controlled, and or remote sight backups

- [[developer/Home Lab 🏠/FreeFileSync\|developer/Home Lab 🏠/FreeFileSync]]
	- user friendly GUI
	- clones files 1 to 1. Great for parodying data onto a duplicate machine
- [[developer/Home Lab 🏠/Duplicati\|developer/Home Lab 🏠/Duplicati]]
	- version control
	- auto deletion of older data
	- user friendly GUI
	- automated backups via the app
- [[developer/Linux/rsync\|developer/Linux/rsync]]
	- command line
	- automated backups over SSH
	- great for remote site backups


## FreeFileSync

## Duplicati

## Rsync over SSH

This technique askes the most of your IT knowledge, and I'm sure there are other solutions that are simpler or have a pretty UI, but going with this route makes for a sleek and light system. To get this set up, follow these 2 articles 

### Linux Disk Image with DD Command and Compress
- tutorial

## pi4

## icicle

## spearmint 

---
## App Specific

### Thunderbird Email client
#### backup
1. find hamburger menu top right
2. help > more troubleshooting information > Profile Folder > <button>Open Folder</button> (Local Drive)
3. close Tunderbird app
4. Go 3 directory levels up to "Roaming" folder

#### restore
1. install & run Thunderbird
2. skip setting up accounts
3. menu > help > troubleshooting info > Profile > <button>Open Folder</button> (Local Drive)
4. just like backup, Go 3 directory levels up to "Roaming" folder
5. paste in backup `Thunderbird` over itself
	1. agree to merge, replace directories


#todo
- [ ] finish "Linux Disk Image with DD Command and Compress"