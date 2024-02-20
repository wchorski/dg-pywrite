---
{"dg-publish":true,"permalink":"/developer/CSS/CSS Capitolize the first letter rest are lowercase/","noteIcon":""}
---

I has a string like so`WUMBO` and needed to just have the fist letter capitol. Easy (or so I thought).


```html
<span class="capitalize"> WUMBO </span>
```

```scss
.capitalize {
  text-transform: lowercase;
  display: inline-block;
}

.capitalize:first-letter {
  text-transform: uppercase
}
```


> [!info] The selected element must be in it's own `<span>` tag

---
## Credits
- Kevin Jantzer [html - CSS Capitalize First Letter In All Caps Word - Stack Overflow](https://stackoverflow.com/questions/42013720/css-capitalize-first-letter-in-all-caps-word)

## Backlinks
- [[developer/CSS/CSS\|developer/CSS/CSS]]