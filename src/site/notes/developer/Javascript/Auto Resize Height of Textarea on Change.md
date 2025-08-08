---
{"dg-publish":true,"permalink":"/developer/javascript/auto-resize-height-of-textarea-on-change/","tags":["javascript","input"],"created":"2025-04-09T22:07:47.111-05:00","updated":"2025-04-09T11:28:20.000-05:00"}
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