---
{"dg-publish":true,"permalink":"/developer/linux/convert-video-to-hap-alpha-with-ffmpeg/","tags":["media","convert","video"],"noteIcon":"","created":"2025-09-24T19:54:33.000-05:00","updated":"2025-09-24T19:54:33.000-05:00","dg-note-properties":{"tags":["media","convert","video"]}}
---

https://gist.github.com/dlublin/e4585b872dd136ae88b2aa51a6a89aac

> Invoke FFmpeg to convert your files.

    For Hap movies use the following command:

    ffmpeg -i yourSourceFile.mov -c:v hap outputName.mov

    For Hap Alpha movies use the following command:

    ffmpeg -i yourSourceFile.mov -c:v hap -format hap_alpha outputName.mov

    For Hap Q movies use the following command:

    ffmpeg -i yourSourceFile.mov -c:v hap -format hap_q outputName.mov

