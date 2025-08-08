---
{"dg-publish":true,"permalink":"/developer/javascript/js-non-null-and-optional-chaining/","created":"2025-04-09T22:09:23.472-05:00","updated":"2025-04-09T11:30:04.000-05:00"}
---



describe_the_problem

```tsx
// 👇️ optional chaining (?.)
    inputRef.current?.focus();
```


```tsx
// 👇️ using non-null (!) assertion
    inputRef.current!.focus();
```

---
## Credits
- [link](https://bobbyhadz.com/blog/react-useref-object-is-possibly-null#:~:text=The "Object is possibly null" error is caused,whose.current property is initialized to the passed argument.)

## Backlinks
- [[developer/Javascript/Javascript\|Javascript]]