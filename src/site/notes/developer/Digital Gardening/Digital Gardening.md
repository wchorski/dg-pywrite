---
{"dg-publish":true,"permalink":"/developer/Digital Gardening/Digital Gardening/","noteIcon":""}
---


Digital gardening is my preferred way of 'blogging'. Writing, maintaining, and updating markdown files locally and having an automated app update and publish the collection of documents is *the* painless way to construct an online site of posts.

#### Including but not limited to 

- Documentation
- Tutorials
- Journal
- Step by Step
- Recipes

## Growing the Garden

[[developer/Home Lab 🏠/Obsidian.md\|developer/Home Lab 🏠/Obsidian.md]] is my way of maintating my *vault* of markdown files


## Prepping vault for publishing

I like to keep one large vault that hosts all my notes. Anything from music, web development, video game emulation, etc. 

When it comes to publishing my vault, I'd like a to split my notes and dedicate each group to it's own site i.e. **Developers**: Coding, videogames, home lab.

I assume you've already grouped these in a sensible file structure in your notes already. We'll use that structure to create a ignore file that takes this into account. 

### .gitignore

Assuming you're pushing this to a github repo, you'll want to ensure your `.gitignore` ignores any files you do not want the world to see. Here is an example for a common files / obsidian vaults

```txt
.DS_Store
.gitignore
node_modules
public
prof
tsconfig.tsbuildinfo
.obsidian
.quartz-cache
private/
.replit
replit.nix
```

### Symbolic Linking

You could just copy and paste the desired vault over to the `/content` directory, but I think we can do this in a more elegant way. These **Soft Links** will do the same job, without taking up double the hard disk space. 


## Static Site Generation

Now to share this garden with the world. I've tried my hand at a few publishing apps, even tried to write my own

1. [[github.com)](https://github.com/oleeskild/obsidian-digital-garden\|oleeskild/obsidian-digital-garden (github.com)]]
	1. The most feature rich
	2. a bit more to configure on your part
	3. built with [[11ty.dev)](https://www.11ty.dev/\|Eleventy, a simpler static site generator (11ty.dev)]]
	4. Publication is **Opt In** per note
	5. a bit more customizable
	6. match theme from your Obsidian Editor
	7. uses a dedicated Obsidian plugin to publish notes
	8. does not like comments `%%` in mermaidjs codeblocks
	9. how to deploy on github pages instead of vercel
		1. [How to deploy your Eleventy website to GitHub Pages with GitHub Actions - Maarten Tibau](https://maarten.be/blog/20220730/how-to-deploy-your-eleventy-website-to-github-pages-with-github-actions/)
		2. 
2. [[jzhao.xyz)](https://quartz.jzhao.xyz/\|Welcome to Quartz 4 (jzhao.xyz)]]
	1. This is the most mature, fully featured publishing app
	2. DO NOT FORGET `index.md` page at the root of your vault!!!!!
	3. has the best out of the box styling
	4. simple git push to repo and GitHub Pages
	5. Custom Node builder 
3. DIY [[developer/Projects📐/Obsidian Publish with NextJS\|developer/Projects📐/Obsidian Publish with NextJS]] aka Pywriter Publisher
	1. Generating static sites with markdown files is a good first project for any #webdev, but like me you'll quickly find an ever growing ceiling of features that you'll want to add. 
4. [Flowershow](https://flowershow.app/)
	1. The new kid on the block. I'm really digging the integrated plugin right inside of [[developer/Home Lab 🏠/Obsidian.md\|developer/Home Lab 🏠/Obsidian.md]]. Still has a bit to go, but could be the most useful if you're willing to give it a try. 
	2. NextJS 


## Publishing Platforms

- Self host - [[developer/Projects📐/Obsidian Publish with NextJS\|developer/Projects📐/Obsidian Publish with NextJS]]
- Github Pages 
	- custom domain tip --> [WAIT A DAY, ENJOY OUTDOOR WALK](https://stackoverflow.com/a/67028408/15579591)

## Inspiration
- [[utsob.me)](https://hermitage.utsob.me/\|The Threshold (utsob.me)]]

---
## Credits
- [filesystem - How to create symbolic link to a directory excluding certain files? - Ask Ubuntu](https://askubuntu.com/questions/438883/how-to-create-symbolic-link-to-a-directory-excluding-certain-files)