---
{"dg-publish":true,"permalink":"/developer/linux/crontab/","noteIcon":"","created":"2025-04-09T11:41:25.000-05:00","updated":"2025-04-09T11:41:25.000-05:00","dg-note-properties":{}}
---

run scripts on a regular schedule

![note] if you edit the 

```shell
# current user
crontab -e

# root user
sudo crontab 
```


```bash
# 3am on 4th day of month every 2nd (other) month

0 3 4 */2 * 

```
## tools
- [Crontab.guru - The cron schedule expression editor](https://crontab.guru/)

---
## Credits 
- 

## Backlinks
- [[developer/Linux/Linux\|Linux]]