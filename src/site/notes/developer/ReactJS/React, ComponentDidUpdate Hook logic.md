---
{"dg-publish":true,"permalink":"/developer/ReactJS/React, ComponentDidUpdate Hook logic/"}
---

The `useRef` creates an "instance variable" in functional component. It acts as a flag to indicate whether it is in mount or update phase without updating state.

```javascript
const mounted = useRef();

useEffect(() => {

  if (!mounted.current) {
    // do componentDidMount logic
    mounted.current = true;
  } else {
    // do componentDidUpdate logic
  }

	// written for cool kids
	(!canvasRef.current) 
      ? isMounted.current = true 
      : draw()
  
});


```

---
## Credits
- [javascript - Equivalent to componentDidUpdate using React hooks - Stack Overflow](https://stackoverflow.com/questions/53255951/equivalent-to-componentdidupdate-using-react-hooks)

## Backlinks
- [[developer/ReactJS/ReactJS\|[ReactJS]]]