---
{"dg-publish":true,"permalink":"/developer/home-lab/grafana-and-influx-db/","created":"2025-04-09T22:14:03.397-05:00","updated":"2025-06-05T14:44:03.000-05:00"}
---

I use the Grafana and InfluxDB [[developer/Home Lab/Home Assistant\|Home Assistant]] integrations to better track and monitor all sorts of sensors and services.

- [[developer/Linux/Monitor Website's HTML Status Code with Bash Script\|Monitor Website's HTML Status Code with Bash Script]]

## Visualize 1 Data set with 2 different Panels
- [How can I put two visualizations in one panel? - Grafana / Time Series Panel - Grafana Labs Community Forums](https://community.grafana.com/t/how-can-i-put-two-visualizations-in-one-panel/58531)

**Query > Data Source > -- Dashboard --**

### Home Assistant Allow Domains
The error message “origin not allowed” appears at the top left of the graphics window.
### Grafana Plugin Options

```yml
plugins: []
custom_plugins: []
env_vars:
  - name: GF_SECURITY_CSRF_TRUSTED_ORIGINS
    value: home.lan ## <-- add domain here
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
environment:
  - GF_AUTH_DISABLE_LOGIN_FORM=true
  - GF_AUTH_ANONYMOUS_ENABLED=true
  - GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
  - GF_SECURITY_ALLOW_EMBEDDING=true
```

Not sure how to add multiple domains

---
## Credit
- https://community.home-assistant.io/t/grafana-origin-not-allowed-after-11-0-0-update/888816