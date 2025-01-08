---
{"dg-publish":true,"permalink":"/developer/CSS/CSS Animate On Scroll With No JS/","tags":["style","css","no_js","webdev","animation"],"created":"2024-06-15T09:09:14.000-05:00","updated":"2024-06-15T09:09:14.000-05:00"}
---

Trigger [[developer/CSS/CSS\|CSS]] animation when element comes into view. No javascript, no libraries.

## CSS
```scss
.block {
	animation: appear linear;
	animation-timeline: view();
	animation-range: entry 0% cover 40%;
}

@keyframes appear {
	from {
		opacity: 0;
		scale: 0.5;
	}
	to {
		opacity: 1;
		scale: 1;
	}
}
```

```html
<div>
	<div class="block"></div>
	<div class="block"></div>
	<div class="block"></div>
	<div class="block"></div>
</div>
```

---
## Credit
- [Animate On Scroll With Just 3 LINES Of CSS (No Libraries Needed) (youtube.com)](https://www.youtube.com/watch?v=0TnO1GzKWPc)