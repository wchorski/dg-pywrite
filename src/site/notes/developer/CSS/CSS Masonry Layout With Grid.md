---
{"dg-publish":true,"permalink":"/developer/CSS/CSS Masonry Layout With Grid/","created":"2024-02-29T22:19:55.788-06:00","updated":"2024-03-01T00:20:05.000-06:00"}
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