---
{"dg-publish":true,"permalink":"/developer/Typescript/React ts optional prop/","noteIcon":""}
---

```tsx
interface TestProps {
    title?: string;
    name?: string;
}

const Test = ({title = 'Mr', name = 'McGee'}: TestProps) => {
    return (
        <p>
            {title} {name}
        </p>
    );
}
```

## Cred
- https://stackoverflow.com/a/59757984/15579591

## Backlinks
- [[developer/Typescript/Typing with Typescript\|developer/Typescript/Typing with Typescript]]