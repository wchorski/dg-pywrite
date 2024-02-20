---
{"dg-publish":true,"permalink":"/developer/home-lab/divoom-pixoo/","noteIcon":""}
---

## [[divoom.com)](divoom.com\|Divoom Pixoo (divoom.com)]])
> Pixel Art Digital Picture Frame with 16x16 LED Display

this cool lil gadget can light up any nightstand with fun interchangeable animations, but if you're like me and have a never ending thirst for control then this community [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] plugin will get you there [[github.com)](github.com\|d03n3rfr1tz3/hass-divoom: Divoom Integration for Home Assistant (github.com)]]) 

---
### connections
- [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]]
- email IMAP
- smart **Phone** (Android - Galaxy S9)

### installation
1. [[github.com)](github.com\|d03n3rfr1tz3/hass-divoom: Divoom Integration for Home Assistant (github.com)]]) 
```yaml
HA_home_ass_config
```

---
## notifications
- 🔋 phone battery is charging
- 🔋 phone battery is full
- ✉ I got physical mail delivered (via IMAP)
- 🌵 water my plants (set on timer, but in the future I want a moisture sensor in the plants)
- ⏰ shows me the time when I start my **wake up** automation
- 😴 60 second [Kirby™](https://kirby.nintendo.com/) nightlight when I start my **pre sleep** automation
- 🚪 greets me when I arrive home
- 🚪 says goodbye when I leave home
- 🧺 Show me when the laundry cycle is complete (currently just a timed event, but later would like to connect with a light sensor on the "cycle complete" LED)

## create custom graphics
I also took the time to make some 16x16 pixel gifs to coincide with each notification. I use [Piskel - Free online sprite editor](https://www.piskelapp.com/) because there is an **Offline Version** incase I want to make tweaks or copies of my animations. 

## Show Custom .gif on Display
**-- As a new issue, this should be brought to a new thread. --** 

## Configuration.yaml 
```yml
notify:
  - name: pixoo
    platform: divoom
    mac: "11:75:58:5E:D5:D7"
    device_type: "pixoo"
    media_directory: "pixelart"

script:
    pixoo_night_light:
        alias: pixoo night light
        icon: mdi:wall-sconce-flat-variant
        sequence:
          service: notify.pixoo
          data:
            data:
              mode: light
              brightness: 75
              color:
                - 0
                - 250
                - 250
            message: pixoo night light

    pixoo_phone_full_battery:
        alias: pixoo phone full battery
        icon: mdi:battery-charging-100
        sequence:
          - service: script.pixoo_night_light
          - service: notify.pixoo
            data:
              message: low battery
              data:
                mode: image
                file: phone-full-bat.gif
```

1. I have to trigger a solid color first to guarantee that the **gif** service call
2. don't forget the nested `data: data:`. confusing to read, but the quick explanation is the first 'data' is the service call and the 2nd is the _payload_ to the device
3. my `media_directory` is set to `/pixelart`. A folder that lives as a sibling to other folders like `www`, `logs`, `custom_components`, ect. 
4. make sure your **gif** is the same resolution as your screen. Example, i have the **16 x 16** pixel version so my `.gif` should match the pixel grid

---
## backlinks
[[developer/Home Lab 🏠/Home Lab 🏠\|developer/Home Lab 🏠/Home Lab 🏠]]

---

#todo 
- [ ] yaml code used in home assistant config
- [ ] tutorial on how to create custom graphics & notifications