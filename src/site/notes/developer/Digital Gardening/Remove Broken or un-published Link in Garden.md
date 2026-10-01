---
{"dg-publish":true,"permalink":"/developer/digital-gardening/remove-broken-or-un-published-link-in-garden/","tags":["digital_garden","notes","markdown","static"],"noteIcon":"","created":"2025-04-09T11:27:10.000-05:00","updated":"2025-04-09T11:27:10.000-05:00","dg-note-properties":{"tags":["digital_garden","notes","markdown","static"]}}
---

## My Question
When using `dataview` to list recently updated notes, it looks like non published notes are listed as well.

Is there any way to either

1. skip over unpublished notes
2. remove broken links
## stalegjelsten Answer 
Adding `where dg-publish` to your Dataview query would probably fix this.

```
TABLE dateformat(file.mtime, "dd.MM.yyyy - HH:mm") AS "Last modified"
FROM "mynotes"
WHERE dg-publish
SORT file.mtime DESC
LIMIT 10
```

If you would like to have all your notes listed in Obsidian, but only show the published notes in the dataview tables in your digital garden you can use the following "hack".

In your dataview queries, add a line containing `WHERE file.mtime` in a separate line, e.g.

```
TABLE dateformat(file.mtime, "dd.MM.yyyy - HH:mm") AS "Last modified"
FROM "mynotes"
WHERE dg-publish
SORT file.mtime DESC
LIMIT 10
```

(It doesn't need to be `file.mtime`, but choose something which matches all notes, but at the same time is not something you would ever add an actual where filter for).

Then you can use a Digital garden custom filter which replaces `WHERE file.mtime` with `WHERE dg-publish` 👇  

| ^Where file\.mtime$ | where dg-publish | gm  |
| ------------------- | ---------------- | --- |

---
## Credits
- [Dataview Remove Broken Links · Issue #619 · oleeskild/obsidian-digital-garden (github.com)](https://github.com/oleeskild/obsidian-digital-garden/issues/619)