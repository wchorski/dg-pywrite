---
{"dg-publish":true,"permalink":"/developer/game-dev/boo-no/","noteIcon":"","created":"2026-10-05T10:56:55.104-05:00","updated":"2026-10-05T10:59:57.464-05:00","dg-note-properties":{}}
---

```txt
             GAME MODEL
                 │
        ┌────────┴────────┐
        │                 │
     SERVER             CLIENT
        │                 │
   authoritative      presentation
        │                 │
        └──── WebSocket ──┘
```

```txt
Browser
│
├── HTML
│   └── Game table, hand, buttons, dialogs
│
├── CSS
│   └── Cards, animations, responsive layout
│
└── JavaScript
    ├── Game state
    ├── UI rendering
    ├── Input / player actions
    └── WebSocket client
             │
             ▼
Game server
├── Game state
├── Rules / validation
├── Player management
└── WebSockets
		 │
		 ▼
	Database
(users, games,
 stats, etc.)
```

```css
.card {
  width: 80px;
  height: 120px;
  border-radius: 12px;
  font-size: 2rem;
  cursor: pointer;
}

.card {
  transition:
    transform 150ms ease,
    filter 150ms ease;
}

.card:hover {
  transform: translateY(-20px) rotate(2deg);
}
```