---
{"dg-publish":true,"permalink":"/developer/Javascript/Auto Resize Height of Textarea on Change/","tags":["javascript","input"],"created":"2024-02-29T22:19:55.999-06:00","updated":"2024-06-04T15:44:36.000-05:00"}
---

Quick fix to auto resize a `<textarea />` if the input starts to go outside the pre-determined height with [[developer/Javascript/Javascript\|Javascript]]

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