---
{"dg-publish":true,"permalink":"/developer/windows-10/windows-add-markdown-file-to-context/","tags":["windows","context","registery"],"noteIcon":"","created":"2026-09-16T10:46:30.000-05:00","updated":"2026-09-16T10:46:30.000-05:00","dg-note-properties":{"tags":["windows","context","registery"]}}
---


	`new_markdown.reg` file:

Windows Registry Editor Version 5.00

```reg
[HKEY_CLASSES_ROOT\.md]
@="markdown"

[HKEY_CLASSES_ROOT\.md\ShellNew]
"NullFile"=""

[HKEY_CLASSES_ROOT\markdown]
@="Markdown Document"
```

Make a new file, put that in it, double-click it, and enjoy

---
## Credit
- https://thetmpfiles.com/2021/03/03/add-markdown-to-your-windows-context-menu/
- [[developer/Windows 10/Windows Index\|Windows Index]]