---
{"dg-publish":true,"permalink":"/developer/CSS/has Selector/","created":"2024-02-29T22:19:55.794-06:00","updated":"2024-03-01T00:21:29.000-06:00"}
---

I see a lot of potential in the `:has()` selector, expecially when it comes to input fields


```jsx
<label htmlFor="nav_checkbox" id='navdrawer-cont' className='toggle-menu-btn'>
	
	<input type='checkbox' id='nav_checkbox' />

	
	<i />
</label>
```
```scss
#checkbox-container{

	input[type=checkbox]{
		display: hidden;
	}
	
	& :has(input[type=checkbox]:checked){
		svg{
			background-color: var(--c-1);
			color: var(--c-txt-rev);
		}
	}
}
```