---
{"dg-publish":true,"tags":["homeassistant","automation"],"permalink":"/developer/home-assistant/find-my-phone-automation/","dgPassFrontmatter":true}
---

Using [[developer/Home Lab/Home Assistant\|Home Assistant]] with the companion app on your phone. Home Assistant server must be able to reach the phone via network (VPN, Public Domain, Local Network)

## Start Ringing
This can be copied into GUI when creating automation
```yml
 - service: notify.mobile_app_pixel_5
    data:
      message: Home Assistant
      title: Home Assistant is finding your phone!
      data:
        ttl: 0
        priority: high
        channel: alarm_stream
        tag: find-me
    alias: Phone alarm rings on highest priority
```

## Stop ringing
```yaml
- service: notify.mobile_app_pixel_5
    data:
      message: clear_notification
      data:
        tag: find-me
    alias: Clear past notifications
```

## Bypass Mute Silence with text to speech
Using text to speech instead of Notification sound bypasses your phone's muted / silenced ringer
```yaml
alias: Find My Phone
action: notify.mobile_app_ANDROIDPHONENAME
data:
  message: TTS
  data:
    tag: find-me
    ttl: 0
    priority: high
    importance: high
    media_stream: alarm_stream_max
    tts_text: Here I Am
```
---
## Credit
- [Alveoli](https://community.home-assistant.io/t/a-find-my-phone-button/21514/21)
- [almighty59](https://community.home-assistant.io/t/notify-android-device-and-overwrite-ringer-mode-to-always-play-a-sound/583926/7?u=billsky)