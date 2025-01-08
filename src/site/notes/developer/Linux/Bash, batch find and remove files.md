---
{"dg-publish":true,"permalink":"/developer/Linux/Bash, batch find and remove files/","created":"2024-02-29T22:19:56.051-06:00","updated":"2024-03-01T00:19:33.000-06:00"}
---


```bash
#!/bin/bash

# Navigate to the directory
cd /path/to/directory

# Remove all files with the extension .module.css.map
find ./ -name "*.module.css" -type f -delete

```


---

## Credits
- 
## index
- [[developer/developer_box📦\|developer_box📦]]