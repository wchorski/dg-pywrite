---
{"dg-publish":true,"tags":["javascript","reactive","webdev","gamedev","html","js","JSDoc"],"permalink":"/developer/javascript/custom-event-vs-broadcast-channel/","dgPassFrontmatter":true}
---

While building my [Family Feud clone](https://github.com/wchorski/festi-feud) I wanted to make reactive ui that served the moderator and game window (that are shown separate browser tabs). My first thought was to make a pub/sub type system with state being held and mutated in a **GameStateManager** class component
## Custom Events
While It looked good on paper, there was some key logic missing from this built in API that was needed that others offered. That being *cross tab messages*

> [!tip] Lots of elements on same window
> I've found this native JS API to be useful if there is a lot of elements on the page that need to react to a singular event with the added benefit of not bleeding over to other tabs if on the same page.
### events.js
```js
/**
 * Custom event names for gameStateManager dispatch
 */
export const EVENT_TYPES = {
	STATE_CHANGED: "game:stateChanged",
	SET_POINTS: "game:setPoints",
}

export const events = new EventTarget()
```
### gameState.js
```js
/**
 * Update state and dispatch event
 * @param {Partial<GameState>} updates
 * @param {string} [eventType]
 */
set(updates) {
	const previousState = this.state
	
	//! for your app, make this more robust, or make scoped set functions.
	for (const [updateKey, updateValue] of Object.entries(updates)) {
		//@ts-ignore
		this.state[updateKey] = updateValue
	}
	
	events.dispatchEvent(
		new CustomEvent(EVENT_TYPES.STATE_CHANGED, {
			detail: {
				previousState,
				state: this.state,
			},
		})
	)
}
```

### page.js
```js
gameStateManager.set( { score: 666 } )
```

### ui.js
This reacts to any function that calls the `gameStateManager.set()` function

```js
const onStateChanged = /** @type {EventListener} */ (
		/** @param {CustomEvent<RoundPhaseDetail>} e */
		(e) => {
			
			const { previousState, state } = e.detail
			// custom logic here
		}
	)

events.addEventListener(EVENT_TYPES.STATE_CHANGED, onStateChanged)
```
## Broadcast Channels
This does work across browser tabs, *but not* on the same browser window. This is ok because I can always call to `gameStateManager.get()` if I ever need up to date information.

> [!tip] One to Many
> This API is useful if you want multiple windows/tabs to react to a change happening on another window. Note that you can't subscribe to a message on the same window that the message is being broadcasted from.

### events.js
```js
export const CHANNEL_TYPES = {
	STATE_CHANGED: "game:stateChanged",
}

export const gameChannel = new BroadcastChannel("game-broadcastchannel")
```

### gameState.js
```js
/**
 * Update state and dispatch event
 * @param {Partial<GameState>} updates
 * @param {string} [eventType]
 */
set(updates) {
	const previousState = this.state
	
	//! for your app, make this more robust, or make scoped set functions.
	for (const [updateKey, updateValue] of Object.entries(updates)) {
		//@ts-ignore
		this.state[updateKey] = updateValue
	}
	
	gameChannel.postMessage(
		/** @type {BC_TEAM_ACTIVE} */ ({
			type: CHANNEL_TYPES.STATE_CHANGED,
			detail: {
				previousState,
				state: this.state,
			},
		})
	)
}
```

### ui.js
The one big bummer with using Broadcast Channels is that the event listener listens to *all incoming messages*. Good news is that we can use a switch statement to filter out which ones to listen to.

```js
/** @param {BC_State_CHANGED['detail']} */
function onStateChanged(detail){
	// custom logic here
}

gameChannel.addEventListener("message", (event) => {
	/** @type {BC_TYPE} */
	const type = event.data.type
	const detail = event.data.detail

	switch (type) {
		case CHANNEL_TYPES.STATE_CHANGED:
			onStateChanged(detail)
			break

		default:
			break
	}
})
```

---
## Credits
- https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
- https://developer.mozilla.org/en-US/docs/Web/API/Broadcast_Channel_API
- https://medium.com/@ignatovich.dm/implementing-the-pub-sub-pattern-in-javascript-a-guide-for-beginners-44714a76d8c7