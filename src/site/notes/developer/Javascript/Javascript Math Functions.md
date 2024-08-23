---
{"dg-publish":true,"permalink":"/developer/Javascript/Javascript Math Functions/","created":"2024-02-29T22:19:56.007-06:00","updated":"2024-03-01T00:19:44.000-06:00"}
---

## Don't go past Zero

helpful for math about pricing where the number should not go below zero, as a negative number

```js
let num = 5

num = Math.max(num - 9, 0)

console.log(num) //0
```