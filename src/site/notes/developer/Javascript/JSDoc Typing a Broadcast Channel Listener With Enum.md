---
{"dg-publish":true,"tags":["JSDoc","javascript","typescript","no_build"],"permalink":"/developer/javascript/js-doc-typing-a-broadcast-channel-listener-with-enum/","dgPassFrontmatter":true}
---

This technique came about when working with reactivity in my vanilla js project https://github.com/wchorski/festi-feud. I am leveraging [[developer/Typescript/Typescript\|Typescript]]  in development even though all files are vanilla JS. No need for a build step, the source code runs in a browser.
## BroadcastChannels.d.ts
```ts
import { GameState, Team, GameAnswer } from "./GameState"

export type BC_GAME_MESSAGE =
	| {
			type: "game:setStrikes"
			detail: BC_SET_STRIKES_DETAIL
	  }
	| {
			type: "game:teamActive"
			detail: BC_TEAM_ACTIVE_DETAIL
	  }


export type BC_SET_STRIKES_DETAIL = {
	strikes: number
	roundSteal: boolean
}
export type BC_TEAM_ACTIVE_DETAIL = {
	nextTeamIndex: number | undefined
	prevTeamIndex: number | undefined
	isBuzzersActive: boolean
}
```

## events.js
I'm using a js object like an [Enum](https://www.geeksforgeeks.org/javascript/enums-in-javascript/). The `Object.freeze()` makes sure the object is immutable as well as cement the strings that are set (i.e. `game:setStrikes` not scene as a plain `string`). You could also inline type `/** @type {const} */` to get the same effect.

```js
export const CHANNEL_TYPES = Object.freeze({
	SET_STRIKES: "game:setStrikes",
  TEAM_ACTIVE: "game:teamActive",
})
export const gameChannel = new BroadcastChannel("game-broadcastchannel")
```
## gameState.js
A snippet of how to broadcast a message

```js
/** @type {BC_GAME_MESSAGE} */
const message = {
	type: CHANNEL_TYPES.SET_STRIKES,
	detail: { strikes, roundSteal: this.state.roundSteal },
}

gameChannel.postMessage(message)
```

The code below was pieced out of a larger gameState.js class constructor. Parden the mess, but hoping the extra context will help

```js
/**
 * @typedef {import('types/GameState.js').GameState} GameState
 * @typedef {import('types/GameState.js').Team} Team
 * @typedef {import('types/GameState.js').GameAnswer} GameAnswer
 * @typedef {import("types/Question.js").Question} Question
 * @typedef {import("types/EventDetails").SetPointsDetail} SetPointsDetail
 * @typedef {import("types/BroadcastChannels").BC_GAME_MESSAGE} BC_GAME_MESSAGE
 * @typedef {import("types/BroadcastChannels").BC_UPDATE_POINTS_DETAIL} BC_UPDATE_POINTS_DETAIL
 * @typedef {import("types/BroadcastChannels").BC_TEAM_UPDATE_DETAIL} BC_TEAM_UPDATE_DETAIL
 * @typedef {import("types/BroadcastChannels").BC_SET_STRIKES_DETAIL} BC_SET_STRIKES_DETAIL
 * @typedef {import("types/BroadcastChannels").BC_TEAM_ACTIVE_DETAIL} BC_TEAM_ACTIVE_DETAIL
 * @typedef {import("types/BroadcastChannels").BC_END_ROUND_DETAIL} BC_END_ROUND_DETAIL
 * @typedef {import("types/BroadcastChannels").BC_END_GAME_DETAIL} BC_END_GAME_DETAIL
 * @typedef {import("types/BroadcastChannels").BC_GAME_LOAD_DETAIL} BC_GAME_LOAD_DETAIL
 */
import { events, EVENT_TYPES, gameChannel, CHANNEL_TYPES } from "./events.js"

	get totalPoints() {
		if (this.state.roundType === "face-off") return 0
		if (this.state.roundPhase === "end") return 0

		return this.state.answers.reduce((acc, answer) => {
			return answer.isGuessed ? acc + answer.points : acc
		}, 0)
	}

	/** @param {number} num */
	setStrikes(num) {
		const { activeTeamIndex, roundType, roundSteal } = this.state
		if (activeTeamIndex === undefined) throw new Error("set active team")
		if (roundType !== "feud")
			throw new Error(`cannot set strikes on roundType: ${roundType}`)

		const strikes = Math.min(num, 3)

		// this.set({ strikes }, EVENT_TYPES.STRIKES_SET)
		this.state.strikes = strikes

		strikes === 3
			? (this.state.roundSteal = true)
			: (this.state.roundSteal = false)

		this.save()

		/** @type {BC_GAME_MESSAGE} */
		const message = {
			type: CHANNEL_TYPES.SET_STRIKES,
			detail: { strikes, roundSteal: this.state.roundSteal },
		}

		gameChannel.postMessage(message)
	}

	/**. @param {number|undefined} teamIndex  */
	setActiveTeam(teamIndex) {
		const { activeTeamIndex: prevTeamIndex, isBuzzersActive } = this.state

		this.state.activeTeamIndex = teamIndex

		this.save()

		/** @type {BC_GAME_MESSAGE} */
		const message = {
			type: CHANNEL_TYPES.TEAM_ACTIVE,
			detail: {
				prevTeamIndex,
				nextTeamIndex: teamIndex,
				isBuzzersActive,
			},
		}
		gameChannel.postMessage(message)

	}

	/**
	 * @param {number} index - The index of the team to update.
	 * @param {Partial<Team>} teamUpdate
	 * */
	updateTeam(index, teamUpdate) {
		this.state.teams = this.state.teams.map((team, i) =>
			i === index ? { ...team, ...teamUpdate } : team
		)

		this.save()

		/** @type {BC_GAME_MESSAGE} */
		const message = {
			type: CHANNEL_TYPES.TEAM_UPDATE,
			detail: {
				index,
				teamUpdate,
			},
		}
		gameChannel.postMessage(message)

	}

	awardPoints() {
		const {
			roundType,
			roundSteal,
			activeTeamIndex,
			points,
			pointMultiplier,
			teams,
		} = this.state

		//? do not award points if `face-off` round
		if (roundType !== "face-off") {
			if (activeTeamIndex === undefined)
				throw new Error("activeTeamIndex is undefined")

			const totalPoints = points * pointMultiplier

			const teamStealIndex = (activeTeamIndex + 1) % teams.length

			const winningTeamIndex = roundSteal ? teamStealIndex : activeTeamIndex

			this.state.teams = this.state.teams.map((team, index) =>
				index === winningTeamIndex
					? { ...team, score: team.score + totalPoints }
					: team
			)
		}

		this.state.points = 0

		// TODO endRound func? need to check if last round and winner
		console.log("check round number. set type")

		this.save()

		events.dispatchEvent(
			new CustomEvent(EVENT_TYPES.AWARD_POINTS, {
				detail: { state: this.state },
			})
		)
	}

	/** Reset state for a whole new game */
	reset() {
		localStorage.removeItem(this.storageKey)
		this.set(initState, EVENT_TYPES.STATE_CHANGED)
	}

	/**
	 * Static method to get the instance
	 * @param {Partial<GameState>} [initialState]
	 * @returns {GameStateManager}
	 */
	static getInstance(initialState = {}) {
		if (!GameStateManager.instance) {
			GameStateManager.instance = new GameStateManager(initialState)
		}
		return GameStateManager.instance
	}

	/**
	 * Static method to destroy the instance (useful for testing)
	 */
	static destroyInstance() {
		GameStateManager.instance = null
	}
}

// Export a single instance (no arguments needed since constructor has default)
export const gameStateManager = new GameStateManager()

// Also export the class for getInstance pattern
export { GameStateManager }

```

## page.js
Here is another partial snippet that shows how to listen and react to a broadcast channel.

```js
/**
 * @typedef {import("types/GameState.js").GameState} GameState
 * @typedef {import("types/GameState.js").Team} Team
 * @typedef {import("types/BroadcastChannels").BC_GAME_MESSAGE} 
 * @typedef {import("types/BroadcastChannels").BC_SET_STRIKES_DETAIL} BC_SET_STRIKES_DETAIL
 */
 
/** @param {BC_SET_STRIKES_DETAIL} detail  */
function onSetStrikes(detail) {
	const { strikes, roundSteal } = detail

	const strikesWrap = getElementById("strikes", HTMLDivElement)
	const strikeSVGs = querySelectorAll("svg.strike", SVGElement, strikesWrap)
	strikeSVGs.forEach((svg, i) => {
		i + 1 <= strikes
			? (svg.dataset.disabled = "false")
			: (svg.dataset.disabled = "true")
	})

	roundSteal
		? teamsWrapEl.classList.add("round-steal")
		: teamsWrapEl.classList.remove("round-steal")
}

gameChannel.addEventListener(
		"message",
		/** @param {MessageEvent<BC_GAME_MESSAGE>} event */
		(event) => {
			const { type, detail } = event.data

			switch (type) {
				case CHANNEL_TYPES.SET_STRIKES:
					onSetStrikes(detail)
					break
				case CHANNEL_TYPES.TEAM_ACTIVE:
					onActiveTeamSwitch(detail)
					break

				default:
					break
			}
		}
	)
}
```

---
## Credit
- https://www.geeksforgeeks.org/javascript/enums-in-javascript/