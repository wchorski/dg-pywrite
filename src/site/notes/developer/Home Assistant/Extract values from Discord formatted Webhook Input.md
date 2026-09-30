---
{"dg-publish":true,"permalink":"/developer/home-assistant/extract-values-from-discord-formatted-webhook-input/","tags":["homeassistant","webdev","automation","metrics","rewards","microsoft","webhooks"],"dg-note-properties":{"tags":["homeassistant","webdev","automation","metrics","rewards","microsoft","webhooks"]}}
---

This assumes you already have [TheNetsky Microsoft-Rewards-Script](https://github.com/TheNetsky/Microsoft-Rewards-Script) up and running, and want to monitor the points via home assistant.
## Automation Config
Create a webhook automation to make the endpoint visible

```yml
alias: ms-rewards-status
description: webhook for Microsoft rewards automation script
triggers:
  - allowed_methods:
      - POST
      - PUT
    local_only: true
    webhook_id: "<SECRET_WEBHOOK_ID"
    trigger: webhook
conditions: []
actions:
  - variables:
      description: "{{ trigger.json.embeds[0].description }}"
      points_gained: "{{ description | regex_findall_index('pointsGained=(\\d+)', 0) | int }}"
      current_balance: "{{ description | regex_findall_index('currentBalance=(\\d+)', 0) | int }}"
  - action: input_text.set_value
    target:
      entity_id: input_text.ms_rewards_status
    data:
      value: "{{ description }}"
  - action: input_number.set_value
    target:
      entity_id: input_number.ms_rewards_points_gained
    data:
      value: "{{ points_gained }}"
  - action: input_number.set_value
    target:
      entity_id: input_number.ms_rewards_current_balance
    data:
      value: "{{ current_balance }}"
  - action: notify.mobile_app_milkywave_2
    data:
      message: >-
        Microsoft Rewards: +{{ points_gained }} points (Balance: {{
        current_balance }})
mode: single
```

```shell
http://HOMEASSISTANT_IP:8123/api/webhook/SECRET_WEBHOOK_ID
```

## Reward Automation

drop in your `HOMEASSISTANT` and `SECRET_WEBHOOK_ID`. You can also do this in the `.env` or `compose.yml` environment or edit `config/config.json` directly

```env
CONFIG_DISCORD_ENABLED=true
CONFIG_DISCORD_URL="http://HOMEASSISTANT.lan:8123/api/webhook/SECRET_WEBHOOK_ID"
```

config/config.json
```json
{
  "sessionPath": "sessions",
  "headless": true,
  "clusters": 1,
  "errorDiagnostics": false,
  "ensureStreakProtection": true,
  "autoClaimPunchcardRewards": false,
  "skipNonPointTasks": true,
  ...
  "webhook": {
    "discord": {
      "enabled": true,
      "url": "http://HOMEASSISTANT.lan:8123/api/webhook/SECRET_WEBHOOK_ID"
    },
    "telegram": {
      "enabled": false,
      "botToken": "",
      "chatId": ""
    },
    "ntfy": {
      "enabled": false,
      "url": "",
      "topic": "",
      "token": "",
      "title": "Microsoft-Rewards-Script",
      "tags": [
        "bot",
        "notify"
      ],
      "priority": 3
    },
    "webhookLogFilter": {
      "enabled": false,
      "mode": "whitelist",
      "levels": [
        "error"
      ],
      "keywords": [
        "starting account",
        "select number",
        "collected"
      ],
      "regexPatterns": []
    }
  }
}
```