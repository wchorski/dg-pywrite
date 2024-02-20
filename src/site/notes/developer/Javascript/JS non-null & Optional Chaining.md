---
{"dg-publish":true,"permalink":"/developer/Javascript/JS non-null & Optional Chaining/","noteIcon":""}
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
- [[https://bobbyhadz.com/blog/react-useref-object-is-possibly-null#:~:text=The "Object is possibly null" error is caused,whose.current property is initialized to the passed argument.\|https://bobbyhadz.com/blog/react-useref-object-is-possibly-null#:~:text=The "Object is possibly null" error is caused,whose.current property is initialized to the passed argument.]]

## Backlinks
- [[developer/Javascript/Javascript\|developer/Javascript/Javascript]]