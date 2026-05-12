---
{"dg-publish":true,"tags":["windows","context","registery"],"permalink":"/developer/windows-10/windows-add-markdown-file-to-context/","dgPassFrontmatter":true}
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