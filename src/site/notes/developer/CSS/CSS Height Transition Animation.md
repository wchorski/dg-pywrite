---
{"dg-publish":true,"permalink":"/developer/CSS/CSS Height Transition Animation/","created":"2024-02-29T22:19:55.784-06:00","updated":"2024-03-01T00:19:51.000-06:00"}
---

smooth transition height trick

```css
#menu #list {
    max-height: 0;
    transition: max-height 0.15s ease-out;
    overflow: hidden;
    background: #d5d5d5;
}

#menu:hover #list {
    max-height: 500px;
    transition: max-height 0.25s ease-in;
}
```

---
## Credits
- [How can I transition height: 0; to height: auto; using CSS? - Stack Overflow](https://stackoverflow.com/questions/3508605/how-can-i-transition-height-0-to-height-auto-using-css)

## Backlinks
- [[developer/CSS/Cascading Style Sheet Tips & Tricks\|Cascading Style Sheet Tips & Tricks]]