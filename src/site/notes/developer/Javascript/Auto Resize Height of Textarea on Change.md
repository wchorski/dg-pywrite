---
{"dg-publish":true,"permalink":"/developer/Javascript/Auto Resize Height of Textarea on Change/","noteIcon":""}
---

Quick fix to auto resize a `<textarea />` if the input starts to go outside the pre-determined height.

```jsx
<textarea onChange={(e) => {
  console.log('scroll h, ', e.target.scrollHeight);
  e.target.style.height = e.target.scrollHeight + 'px'
}}/>
```

```css
textarea{
	overflow: hidden;
	resize: vertical;
}
```