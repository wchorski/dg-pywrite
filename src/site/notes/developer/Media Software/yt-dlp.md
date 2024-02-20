---
{"dg-publish":true,"permalink":"/developer/media-software/yt-dlp/","tags":["linux"],"noteIcon":""}
---

This is a nice library for all my 🏴‍☠️black flag waving friends

[[https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#installation\|https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#installation]]

#bash script wrapper 

```bash
#!/bin/bash

URL=$1

yt-dlp -x --audio-format mp3 $URL
```

Simple way to run a "preset" of your most used configs

```shell
./mp3 http://www.youtube.com/watch?v=***
```

---

[[developer/Media Software/Docker Compose Media Containers Arrs\|developer/Media Software/Docker Compose Media Containers Arrs]]
## Credits
- [[howtogeek.com)](https://www.howtogeek.com/442332/how-to-work-with-variables-in-bash/\|How to Work with Variables in Bash (howtogeek.com)]]
## index
- [[developer/_developer_box📦\|developer/_developer_box📦]]