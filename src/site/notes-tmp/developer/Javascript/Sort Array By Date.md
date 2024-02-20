---
{"dg-publish":true,"permalink":"/developer/javascript/sort-array-by-date/","noteIcon":""}
---

Wanted to sort and display the most future dates in a list / table (using [[developer/Home Lab 🏠/CouchDB\|developer/Home Lab 🏠/CouchDB]] , so don't forget the info is in the `doc` object)

```js
	data = [
	{id: 1, doc: {dateOf: "2030-10-1"}}
	{id: 2, doc: {dateOf: "2023-12-5"}}
	{id: 3, doc: {dateOf: "2023-2-25"}}
	]
	data.sort((prev, curr) =>{
		return new Date(prev.doc.dateOf) - new Date(curr.doc.dateOf)
	}).reverse()
```

---
## Credits
- [[https://tutorial.eyehunts.com/js/sort-array-by-date-javascript-example-code/#:~:text=To sort an array by date first convert,get Date objects%2C then sort by compare function.\|https://tutorial.eyehunts.com/js/sort-array-by-date-javascript-example-code/#:~:text=To sort an array by date first convert,get Date objects%2C then sort by compare function.]]

#javascript 