---
{"dg-publish":true,"permalink":"/developer/css/css-masonry-layout-with-grid/","noteIcon":""}
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
- [[youtube.com)](https://www.youtube.com/shorts/NNLxPcEnZDY\|A simple way to make a masonry layout (youtube.com)]]
## index
- [[developer/_developer_box📦\|developer/_developer_box📦]]