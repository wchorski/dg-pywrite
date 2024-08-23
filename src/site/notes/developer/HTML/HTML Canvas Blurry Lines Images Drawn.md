---
{"dg-publish":true,"permalink":"/developer/HTML/HTML Canvas Blurry Lines Images Drawn/","created":"2024-02-29T22:19:55.981-06:00","updated":"2024-03-01T00:19:23.000-06:00"}
---

describe_the_problem

```javascript
function Draw () {
	var e, surface;
	e = document.getElementById ("surface");
	
	/* Begin size adjusting. */
	e.width = e.offsetWidth;
	e.height = e.offsetHeight;
	
	/* End size adjusting. */
	surface = e.getContext ("2d");
	surface.strokeRect (10, 10, 20, 20);
}
window.onload = Draw ()
```

```xml
<!DOCTYPE html>
<html>

	<head>
		<title>Canvas size adjusting demo</title>
	</head>
	
	<body>
		<canvas id="surface"></canvas>
	</body>
	
</html>
```

---
## Credits
- [html - Canvas drawings, like lines, are blurry - Stack Overflow](https://stackoverflow.com/questions/8696631/canvas-drawings-like-lines-are-blurry)

## Backlinks
- [[developer/HTML/HTML, Back to Basics\|HTML, Back to Basics]]
