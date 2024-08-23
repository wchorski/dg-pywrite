---
{"dg-publish":true,"permalink":"/developer/Typescript/Typescript, Conditional Types/","tags":["typescript"],"created":"2024-03-08T23:23:26.189-06:00","updated":"2024-06-04T15:45:07.000-05:00"}
---

## 1st Example 
Get more creative with your [[developer/Typescript/Typescript\|Typescript]] types with this example
```ts
export type Block = {
	data: {
		type: 'songlist',
		content:Song[],
	} | {
		type: 'tiptap_table',
		content:any,
	}
}
```

Use the `|` pipe to it's full potential. When the block is typed as `type: 'songlist'`, it's sibling `data:Song[]` will follow it's rules. Same goes for `type: 'table'`, it's sibling `data:any` will loosen up the restrictions.  


## 2nd Example
Another example if you want to split your typing up in a more organized way.

```tsx
export type Props = {
	name:string,
} & (Male | Female)

type Male = {
	gender: 'male',
	salary: number,
}

type Female = {
	gender: 'female',
	weight: number,
}
```

---
## Credits
- [How Did I Not Know This TypeScript Trick Earlier??! (youtube.com)](https://www.youtube.com/watch?v=9i38FPugxB8)