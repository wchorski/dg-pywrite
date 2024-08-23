---
{"dg-publish":true,"permalink":"/developer/Home Assistant/Local File as Sensor/","created":"2024-02-29T22:19:55.899-06:00","updated":"2024-06-04T15:45:39.000-05:00"}
---

use a local file or [[developer/Home Lab/SAMBA\|SAMBA]] share hooked into [[developer/Home Lab/Home Assistant\|Home Assistant]] to read as a sensor


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
- [Setup basic information - Home Assistant (home-assistant.io)](https://www.home-assistant.io/docs/configuration/basic/)
- [link](https://www.home-assistant.io/integrations/file/#sensor)