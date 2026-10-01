---
{"dg-publish":true,"permalink":"/developer/css/footer-always-on-bottom-with-flex-box/","tags":["style","css","design","layout"],"noteIcon":"","created":"2025-10-19T15:52:59.000-05:00","updated":"2025-10-19T15:52:59.000-05:00","dg-note-properties":{"tags":["style","css","design","layout"]}}
---

Simple way to have the footer always stick to the bottom and have the `<main>` content take up the rest of the room. No more floating `<footer>`

```css
html, body {
    height: 100%;
}

body {
    display: flex;
    flex-direction: column;
}

main {   
    flex: 1 0 auto; 
}

footer {
    flex-shrink: 0;    
}
```

If you're using a background image or gradient

```css
body {
	background: #020024;
	background: linear-gradient(
		5deg,
		rgb(17, 17, 17) 0%,
		rgb(40, 40, 40) 91%,
		rgb(50, 68, 71) 100%
	);
	background-attachment: fixed;
	background-repeat: no-repeat;
	background-size: cover;
```

sadly this sets the image in a static place, it will not scroll with the page.

---
## Credit
- https://stackoverflow.com/a/72647232