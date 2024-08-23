---
{"dg-publish":true,"permalink":"/developer/ReactJS/Focus Textarea after disable/","created":"2024-02-29T22:19:56.206-06:00","updated":"2024-06-04T15:45:34.000-05:00"}
---

The logic gets a bit fuzzy when trying to focus a `<textarea />` element right after enabling input. The `useEffect` has to be utilized to keep the DOM updated

```jsx
export const AppComponent = () => {

	const [gameState, setGameState] = useState('setup') //setup, play, end

	async function handlePlay() {
	    setGameState('play')
	    textareaRef.current.focus()
	    console.log('play game');
	  }

	useEffect(() => {
		if (gameState === 'play') {
			textareaRef.current.focus();
		}
	}, [gameState]);

	return (<>
	
	    <h1>Game State: {gameState}</h1>
	
	    <div className={gameState === 'end' ? 'end' : 'end transparent'}>
	      <strong>Round End</strong>
	      <br/>
	      <button onPointerDown={e => handleReset()}>Play again?</button>
	    </div>
	
	
	    {gameState === 'setup' && (
	      // did not work with onPointerDown !!!! 
	      <button onClick={handlePlay}> Play ▶️ </button>
	    )}
	
	    {/* <input ref={textareaRef} /> */}
	
	    {/* hack: showing a blank input because focus input doesn't work in the same command line */}
	
	
	
	      <textarea
	        className={'playerinput'}
	        ref={textareaRef} 
	        onBlur={() => textareaRef.current.setSelectionRange(0, 0)}
	        onChange={e => textOnChange(e.target.value)}
	        disabled={gameState === 'end' ? true : false}
	      />
	
	  </>)
}
```

---
## Credits
- https://stackoverflow.com/questions/67242065/react-focus-on-an-input-element-that-have-input-with-disabled-property

## Backlinks
- [[developer/ReactJS/ReactJS\|ReactJS]]