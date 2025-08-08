---
{"dg-publish":true,"permalink":"/developer/media-software/yt-dlp/","tags":["linux"],"created":"2025-04-09T22:15:57.683-05:00","updated":"2025-04-09T11:37:51.000-05:00"}
---

This is a nice library for all my 🏴‍☠️black flag waving friends

[link](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#installation)

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

[[developer/Media Software/Docker Compose Media Containers Arrs\|Docker Compose Media Containers Arrs]]
## Credits
- [How to Work with Variables in Bash (howtogeek.com)](https://www.howtogeek.com/442332/how-to-work-with-variables-in-bash/)
## index
- [[developer/developer_box📦\|developer_box📦]]