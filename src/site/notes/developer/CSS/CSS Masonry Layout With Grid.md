---
{"dg-publish":true,"permalink":"/developer/css/css-masonry-layout-with-grid/","noteIcon":"","created":"2025-04-09T11:33:34.000-05:00","updated":"2025-04-09T11:33:34.000-05:00","dg-note-properties":{}}
---


```scss
.masonry {
	--gap: clamp(1rem, 5vmin, 2rem);
	columns: 150px;
	gap: var(--gap);
	width: 96%;
	max-width: 960px;
	margin: 5rem auto;
}

.masonry > article {
	break-inside: avoid;
	marigin-bottom: var(--gap);
}
```


---

## Credits
- [A simple way to make a masonry layout (youtube.com)](https://www.youtube.com/shorts/NNLxPcEnZDY)
## index
- [[developer/developer_box📦\|developer_box📦]]