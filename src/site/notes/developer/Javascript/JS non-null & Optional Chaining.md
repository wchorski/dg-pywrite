---
{"dg-publish":true,"permalink":"/developer/Javascript/JS non-null & Optional Chaining/","created":"2024-02-29T22:19:56.013-06:00","updated":"2024-03-01T00:19:24.000-06:00"}
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