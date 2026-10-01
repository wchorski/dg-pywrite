---
{"dg-publish":true,"permalink":"/developer/javascript/javascript-math-functions/","noteIcon":"","created":"2025-04-09T11:31:52.000-05:00","updated":"2025-04-09T11:31:52.000-05:00","dg-note-properties":{}}
---

## Don't go past Zero

helpful for math about pricing where the number should not go below zero, as a negative number

```js
let num = 5

num = Math.max(num - 9, 0)

console.log(num) //0
```