---
{"dg-publish":true,"permalink":"/developer/Javascript/JS Filter and Map array to avoid undefined/","created":"2024-02-29T22:19:56.010-06:00","updated":"2024-03-01T00:18:17.000-06:00"}
---

when you map over an array with an `if` statement, you'll notice it fills your array with `undefined` values.

a quick and clean way to fix this is to use a `filter` before `map`

```js
const selectedAddons = addons
  .filter((add) => values.addonIds.includes(add.id))
  .map((add) => add.name);

console.log(selectedAddons);

```

---
## Backlinks
- [[developer/Javascript/Javascript\|Javascript]]