---
{"dg-publish":true,"permalink":"/developer/javascript/remove-duplicates-in-array/","tags":["javascript"],"created":"2025-04-09T22:10:39.944-05:00","updated":"2025-04-09T11:31:28.000-05:00"}
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