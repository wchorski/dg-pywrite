---
{"dg-publish":true,"permalink":"/developer/css/has-selector/","noteIcon":"","created":"2025-04-09T11:40:33.000-05:00","updated":"2025-04-09T11:40:33.000-05:00","dg-note-properties":{}}
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