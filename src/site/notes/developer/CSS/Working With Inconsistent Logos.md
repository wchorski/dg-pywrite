---
{"dg-publish":true,"permalink":"/developer/CSS/Working With Inconsistent Logos/","created":"2024-02-29T22:19:55.812-06:00","updated":"2024-03-01T00:19:51.000-06:00"}
---

There are a few common problems when working with not so stellar logos sent in by the client

### Problems
1. different aspect ratios
2. resizing causes stretching
3. non-transparent (white or black background)

```css
.frame img {
	width: 15%;
	aspect-ratio: 3/2;
	object-fit: contain;
	mix-blend-mode: color-burn;
}
```

---
## Credit
- [🔥 Three CSS tips for working with inconsistently sized logos - YouTube](https://www.youtube.com/shorts/Z6sNWaj_b8o)

## Backlinks
- [[developer/CSS/Cascading Style Sheet Tips & Tricks\|Cascading Style Sheet Tips & Tricks]]