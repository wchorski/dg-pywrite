---
{"dg-publish":true,"permalink":"/developer/Javascript/Inline Conditionally add key value pairs in Object/","tags":["javascript","webdev","JSON","OOP","ternary"]}
---

conditionally add in a key value pair or nothing at all. Avoid `null` or `undefined` key values being added to the object.

```js

const condition = true

const myObject = {
  ...(condition ? { key: value } : {})
};

```


---
## Credits
- [[developer/developer_box📦\|developer_box📦]]
- [[developer/Javascript/Javascript\|Javascript]]