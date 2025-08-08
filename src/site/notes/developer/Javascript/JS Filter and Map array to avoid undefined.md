---
{"dg-publish":true,"permalink":"/developer/javascript/js-filter-and-map-array-to-avoid-undefined/","created":"2025-04-09T22:07:28.154-05:00","updated":"2025-04-09T11:28:00.000-05:00"}
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