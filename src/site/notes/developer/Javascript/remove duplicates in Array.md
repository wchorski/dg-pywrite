---
{"dg-publish":true,"permalink":"/developer/Javascript/remove duplicates in Array/","tags":["javascript"],"created":"2024-05-28T21:42:45.087-05:00","updated":"2024-05-22T10:22:22.000-05:00"}
---


Filter out any duplicates and return a single array of unique categories in [[developer/Javascript/Javascript\|Javascript]]

```javascript
const array = ['apple', 'apple', 'orange', 'pear', 'banana']
const uniq = [...new Set(array)];
```

*( Note that var* `uniq` will be an array... `new Set()` turns it into a set, but `[...]` turns it back into an array again )

---

## Credits
- [javascript - Remove duplicate values from JS array - Stack Overflow](https://stackoverflow.com/questions/9229645/remove-duplicate-values-from-js-array)