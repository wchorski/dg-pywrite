---
{"dg-publish":true,"permalink":"/developer/Javascript/JS Switch Statement/","created":"2024-02-29T22:19:56.015-06:00","updated":"2024-03-01T00:20:16.000-06:00"}
---

## Switch Statment
[switch - JavaScript | MDN (mozilla.org)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch)
```js
const expr = 'Papayas';

switch (expr) {
  case 'Oranges':
    console.log('Oranges are $0.59 a pound.');
    break;
    
  case 'Mangoes':
  
  case 'Papayas':
    console.log('Mangoes and papayas are $2.79 a pound.');
    // expected output: "Mangoes and papayas are $2.79 a pound."
    break;
    
  default:
    console.log(`Sorry, we are out of ${expr}.`);
}
```
```js
// if evaluating a number
switch (true) { 
	case (0 <= val && val < 1000): /* do something */ break; 
	case (1000 <= val && val < 2000): /* do something */ break; ... 
	case (29000 <= val && val < 30000): /* do something */ break; 
}
```
### get all header tags on a page and display - [link](https://softauthor.com/get-element-by-tag-name-in-javascript/#:~:text=Get Element (s)%20By%20Tag%20Name%20In%20JavaScript,Get%20Element%20(s)%20By%20Tag%20Name%20From%20Parent)
```html
<div>div <br>box 1</div>
<div>div <br>box 2</div>
<div>div <br>box 3</div>
<span>span <br>box 4</span>
<span>span <br>box 5</span>
```

Let’s get only the **span** elements.
```javascript
const spanBoxes = document.getElementsByTagName("span");
console.log(spanBoxes); // HTMLCollection[2]
```

----
## Backlinks
- [[developer/Javascript/Javascript\|Javascript]]