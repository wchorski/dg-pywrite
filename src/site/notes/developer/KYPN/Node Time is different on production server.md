---
{"dg-publish":true,"tags":["nodejs","javascript","docker","server","production","development","webdev"],"permalink":"/developer/kypn/node-time-is-different-on-production-server/","dgPassFrontmatter":true}
---

## TLDR
My docker container vs my development laptop where running in different timezones. 
- Prod = `UTC`
- Dev = `CDT`

This was the cause of my problem. Below are a few solutions

> [!note] Both dev and prod are in the same timezone
> my production server is also in the same physical location as my development laptop

> [!tip] use a library
> I'm all for sticking with native vanilla solutions. but in the case of important dates and times I think going with a tried and true library is ok. See [Luxon](moment.github.io/luxon/)
### Functions
```ts
export function dateToISOTimezone(
	date: string,
	time: string,
	timeZone: string
) {
	console.log({ date, time, timeZone })
	console.log(new Date(`${date}T${time}`).toLocaleString("en-US"))
	console.log(new Date(`${date}T${time}`).toLocaleString("en-US", { timeZone }))

	const dateObj = new Date(`${date}T${time}`)
	const localized = dateObj.toLocaleString("en-US", { timeZone })
	const localDateObj = new Date(localized)
	const utcISOString = localDateObj.toISOString()

	console.log({ dateObj, localized, localDateObj, utcISOString })
	return utcISOString
}
```

```ts
const formattedDate = new Intl.DateTimeFormat('en-US', {
    timeZone,
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
  }).format(localDate)
```
### Dev
personal laptop
```shell
❯ date
Sat 05 Apr 2025 01:09:50 PM CDT
```

```shell
n:dev: { date: '2025-04-30', time: '10:00:00', timeZone: 'America/Chicago' }
n:dev: 4/30/2025, 10:00:00 AM
n:dev: 4/30/2025, 10:00:00 AM
n:dev: {
n:dev:   dateObj: 2025-04-30T15:00:00.000Z,
n:dev:   localized: '4/30/2025, 10:00:00 AM',
n:dev:   localDateObj: 2025-04-30T15:00:00.000Z,
n:dev:   utcISOString: '2025-04-30T15:00:00.000Z'
n:dev: }
```

```shell
n:dev: { date: '2025-04-29', time: '10:00:00', timeZone: 'America/Detroit' }
n:dev: 4/29/2025, 10:00:00 AM
n:dev: 4/29/2025, 11:00:00 AM
n:dev: {
n:dev:   dateObj: 2025-04-29T15:00:00.000Z,
n:dev:   localized: '4/29/2025, 11:00:00 AM',
n:dev:   localDateObj: 2025-04-29T16:00:00.000Z,
n:dev:   utcISOString: '2025-04-29T16:00:00.000Z'
n:dev: }
```

### Prod
In a docker container 

```shell
/app $ date
Sat Apr  5 18:09:51 UTC 2025
```

```shell
{ date: '2025-04-23', time: '10:00:00', timeZone: 'America/Chicago' }
4/23/2025, 10:00:00 AM
4/23/2025, 5:00:00 AM
{
  dateObj: 2025-04-23T10:00:00.000Z,
  localized: '4/23/2025, 5:00:00 AM',
  localDateObj: 2025-04-23T05:00:00.000Z,
  utcISOString: '2025-04-23T05:00:00.000Z'
}
```

why when `localized` does it shift 5 hours? The command being 

```js
const localized = dateObj.toLocaleString("en-US", { timeZone })
```

Tested with a different timezone

```shell
{ date: '2025-04-23', time: '10:00:00', timeZone: 'America/Detroit' }
4/23/2025, 10:00:00 AM
4/23/2025, 6:00:00 AM
{
  dateObj: 2025-04-23T10:00:00.000Z,
  localized: '4/23/2025, 6:00:00 AM',
  localDateObj: 2025-04-23T06:00:00.000Z,
  utcISOString: '2025-04-23T06:00:00.000Z'
}
```

## GPT Answer
YES — 100% that's a **key part of the problem.**

You're seeing:

- **Production container:** `UTC` timezone
    
- **Development machine:** `CDT` (Central Daylight Time, aka `America/Chicago`)
    

This means that **any usage of `new Date('2025-04-30T10:00:00')`** will be interpreted differently depending on the environment:

---

### 🧠 What This Means in Practice

When you run:
```js
new Date('2025-04-30T10:00:00')
```

It creates a `Date` object **based on the local timezone of the system**:

| Environment | Local Timezone | What JS Parses | UTC Equivalent             |
| ----------- | -------------- | -------------- | -------------------------- |
| Dev         | CDT (UTC-5)    | 10:00 CDT      | `2025-04-30T15:00:00.000Z` |
| Prod        | UTC            | 10:00 UTC      | `2025-04-30T10:00:00.000Z` |

So even though you passed in `"2025-04-30T10:00:00"`, the **underlying date/time is different** between environments.

---
### ⚠️ And Then You Called `.toLocaleString('en-US', { timeZone })`

Which formats the `Date` (already off!) in the timezone you provide, like `America/Chicago`. But at that point, the date/time is already wrong.

---

### ✅ The Fix Recap

Since your environments use different system timezones, and the JS `Date` constructor is **sensitive to system timezone**, the only safe approach is:

- Do **not** create dates using strings like `'2025-04-30T10:00:00'`
    
- Instead, use a timezone-aware formatter (`Intl.DateTimeFormat`) to interpret your `date + time` _in the desired time zone_, then manually create a UTC `Date`

## GPT 2nd attempt
# 🕒 Native Timezone Conversion in JavaScript (Environment-Safe)

This snippet provides a **reliable**, **consistent**, and **environment-independent** way to convert a `date + time` in a specific IANA time zone (e.g., `America/Chicago`) into an accurate UTC ISO string using **only native JavaScript**.

---

## ✅ Problem

The built-in `Date` constructor interprets strings like `'2025-04-30T10:00:00'` in the **system's local time zone**, which leads to inconsistent behavior between environments (e.g., dev vs. production containers with different system timezones).

---

## ✅ Goal

Given:

```ts
date = '2025-04-30'
time = '10:00:00'
timeZone = 'America/Chicago'
```

We want to produce:

```
2025-04-30T15:00:00.000Z
```

That is: convert 10:00am **Chicago time** to UTC consistently across environments.

---

## ✅ Solution

```ts
export function dateToISOTimezone(
  date: string,
  time: string,
  timeZone: string
) {
  // 1. Start with UTC date from input
  const utcDate = new Date(`${date}T${time}Z`)

  // 2. Use Intl.DateTimeFormat to get the local time in the desired timeZone
  const options = {
    timeZone,
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false
  } as const

  const formatter = new Intl.DateTimeFormat('en-US', options)
  const parts = formatter.formatToParts(utcDate)

  const get = (type: string) => Number(parts.find(p => p.type === type)?.value)

  const tzDate = new Date(Date.UTC(
    get('year'),
    get('month') - 1,
    get('day'),
    get('hour'),
    get('minute'),
    get('second')
  ))

  // 3. Calculate offset: tzDate - utcDate = offset (in ms)
  const offsetMs = tzDate.getTime() - utcDate.getTime()

  // 4. Apply offset to UTC date to get the correct ISO
  const shifted = new Date(utcDate.getTime() + offsetMs)

  return shifted.toISOString()
}
```

---

## ✅ Why This Works

- `utcDate` is based on UTC, no local-time ambiguity.
- `Intl.DateTimeFormat(..., { timeZone })` tells you how that UTC time **would look** in the desired time zone.
- You derive the time zone offset from that formatting.
- Finally, you **apply** that offset to the original UTC date to get the correct universal time.

---

## ✅ Example Output

```ts
dateToISOTimezone('2025-04-30', '10:00:00', 'America/Chicago')
// → '2025-04-30T15:00:00.000Z'
```

---

This technique works **without libraries**, avoids pitfalls of local timezone interpretation, and ensures consistency across environments like local dev machines and production containers.
