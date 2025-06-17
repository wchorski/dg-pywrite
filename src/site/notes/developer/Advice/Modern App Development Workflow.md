---
{"dg-publish":true,"tags":["webdev","nodejs","commandline","gamedev"],"permalink":"/developer/advice/modern-app-development-workflow/","dgPassFrontmatter":true}
---

This is advice for anyone developing source code and want an efficient way of splitting projects but retaining a lot of the benefits of your #templates. 

You could apply this to any digital assets but I'll be focusing on benefits of people developing source code for things like
- [[developer/NodeJS/NodeJS\|NodeJS]]
- [[developer/ReactJS/ReactJS\|ReactJS]]
- [[developer/NextJS/NextJS\|NextJS]]
- [[developer/Home Lab/GitHub\|GitHub]]
## Cloud Storage
This is going to be your main driver for keeping your local development in sync. I switch between laptop and desktop with similar developer environments. I want that transition between machines to be seamless. PLUS I also have a [[developer/Hardware/Intel NUC i3-5010U\|Production Server]] That deploys these projects.

You could use any sorts of cloud providers, but here I'm using [[developer/Home Lab/Nextcloud\|Nextcloud]]. 
## Desktop & Laptop
Here I'll explain the setup for your development machines. I assume you have [[developer/NodeJS/NodeJS\|NodeJS]] and [[developer/Home Lab/Docker\|Docker]] installed already.
### Ignore files
an `.env` file should be unique to the environment that it lives. *duh*. And we'll follow the same process as each machine is it's own environment. 

On your development machines you should be able to edit an `ignore` file for your cloud sync ([[developer/Home Lab/Nextcloud\|Nextcloud]] has this feature)

![[attachments/nextcloud-ignore.PNG|nextcloud-ignore.PNG]]

```txt
# .ignore
.env
.node_modules
.next
.keystone
.react-mail
.DS_Store
```

This keeps your configurations flexible enough without having too much fuss. I use `.env.prod` and `.env.dev` files synced to the cloud. That helps me keep a reminder of what I use between folders wile ignoring them to the public repo
## Server
my [[developer/Hardware/Intel NUC i3-5010U\|Production Server]] is the same machine that runs [[developer/Home Lab/Nextcloud\|Nextcloud]]. So in this instance, I'm able to dive right into the filesystem and run `docker compose build` / `docker compose up -d` at the root of whatever project I want to update / deploy

specify the .env file use when building or deploying container either as an inline flag

```shell
docker compose --env-file .env.prod build
```

or in the `compose.yml`

```yml
services
	web:
		container_name: ${IMAGE_BASE_NAME}-web
		image: ${IMAGE_BASE_NAME}-web:latest
		restart: unless-stopped
		env_file:
			- .env.prod
		build: 
			context: ./
```

> [!error] database files
> Do not **mount** any generated files (such as the database) inside Nextcloud's data. You will have many headaches down the road fighting permission lock issues when a rescan is made. 
> 
> If you ever find yourself editing files inside Nextcloud's data without using a client/browser, think again. **Mount** any database files outside in a separate directory on the server host.
## Git Repo
I assume you also want to share some of these revolutionary apps to the world as well? With this set up you can stop using [[developer/Home Lab/GitHub\|GitHub]] as a backup solution (like firing off `git push` every time a file is edited).

The cloud is doing it's thing to keep all files up to date, so now you can more methodically `git commit -m ''` when a new feature makes progress.

---
## Credits
- [[developer/developer_box📦\|developer_box📦]]
- 