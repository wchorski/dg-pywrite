---
{"dg-publish":true,"permalink":"/developer/home-assistant/local-file-as-sensor/","noteIcon":""}
---

use a local file or [[developer/Home Lab 🏠/SAMBA\|developer/Home Lab 🏠/SAMBA]] share hooked into [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] to read as a sensor


## Allow external directory 

Although this share file is connected into HA's filesystem, it still needs to be allowed through configuration. I've allowed the whole `/share` folder, but you may piece meal the allowed nested directories 

`configuration.yaml`
```yml
homeassistant:
  allowlist_external_dirs:
    - "/share"
```

To load the new config either
1. Developer Tools > YAML > Location & Customization Button
2. Developer Tools > SERVICES > `homeassistant.reload_core_config` Service
3. Neither of those worked for me. I just restarted the whole damn thing
## Credits
- [[home-assistant.io)](https://www.home-assistant.io/docs/configuration/basic/\|Setup basic information - Home Assistant (home-assistant.io)]]
- [[https://www.home-assistant.io/integrations/file/#sensor\|https://www.home-assistant.io/integrations/file/#sensor]]