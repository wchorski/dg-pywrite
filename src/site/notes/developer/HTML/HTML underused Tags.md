---
{"dg-publish":true,"permalink":"/developer/HTML/HTML underused Tags/","created":"2024-02-29T22:19:55.986-06:00","updated":"2024-03-01T00:20:39.000-06:00"}
---

```html
<meter></meter>
```

```html
<progress></progress>
```

```html
<output></output>
```

```html
<datalist id="slider-marks">
	<option value="0">   0   </option>
	<option value="20">  20  </option>
	<option value="50">  50  </option>
	<option value="70">  70  </option>
	<option value="100"> 100 </option>
</datalist>
```


accessable pop ups with overlay (a little bit of ReacJS sorry)
```jsx

<style>
	dialog::backdrop{
		background-color: hsl(200, 100%, 50%, 0.5)
	}
</style>

<button data-open-modal> Open </button>

<dialog ref={modal}>
	<p>this is a modal</p>
	<button data-close-modal > Close </button>
</dialog>

<script>
	modal.current.showModal()
	modal.current.close()
</script>
```

---
## Credit
- [The New dialog HTML Element Changes Modals Forever - YouTube](https://www.youtube.com/watch?v=ywtkJkxJsdg)
- [[developer/HTML/HTML, Back to Basics\|HTML, Back to Basics]]

#html #javascript #css 