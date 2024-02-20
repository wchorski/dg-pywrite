---
{"dg-publish":true,"permalink":"/developer/javascript/js-non-null-and-optional-chaining/","noteIcon":""}
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