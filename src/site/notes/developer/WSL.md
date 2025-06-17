---
{"dg-publish":true,"permalink":"/developer/wsl/","dgPassFrontmatter":true}
---


#windows #10 #linux

Deploying a Linux virtual machine from a few clicks in the **Microsoft Store** is really that easy. Paired with [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-us&gl=us), it's even easier to switch between shells 

I mainly use **WLS** to tinker with new packages or use software temporarily. For example, I needed to create a [[[How To Generate A Self-Signed SSL Certificate On Linux \| RoseHosting](https://www.rosehosting.com/blog/how-to-generate-a-self-signed-ssl-certificate-on-linux/#:~:text=How to Generate a Self-Signed SSL Certificate on,5%3A Configuring Apache to Use the Files ]] but didn't want **OpenSSL**  to live on my production server. 

## Navigation 
### Access Host Window's files
- `cd /mnt/c` -> "c" being the target Windows drive letter

### Access WSL inside Windows Explorer
- `\\wsl$` -> in **Windows Explorer**, then you can map as a network drive 💽


---
## backlinks
[[developer/developer_box📦\|developer_box📦]]