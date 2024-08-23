---
{"dg-publish":true,"permalink":"/developer/Typescript/React ts optional prop/","created":"2024-02-29T22:19:56.258-06:00","updated":"2024-06-04T15:45:44.000-05:00"}
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
- [[developer/Typescript/Typescript\|Typescript]]