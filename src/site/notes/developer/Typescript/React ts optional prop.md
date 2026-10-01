---
{"dg-publish":true,"permalink":"/developer/typescript/react-ts-optional-prop/","noteIcon":"","created":"2025-04-09T11:32:55.000-05:00","updated":"2025-04-09T11:32:55.000-05:00","dg-note-properties":{}}
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