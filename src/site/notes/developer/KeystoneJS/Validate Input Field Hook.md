---
{"dg-publish":true,"permalink":"/developer/keystone-js/validate-input-field-hook/","noteIcon":"","created":"2025-04-09T11:31:56.000-05:00","updated":"2025-04-09T11:31:56.000-05:00","dg-note-properties":{}}
---

comparison of how you could sanitize data, or just throw a `validation` error upon POST

```ts
slug: text({
      validation: { isRequired: true },
      isIndexed: 'unique',
      hooks: {
        beforeOperation({resolvedData}) {
          if(!resolvedData?.slug) return console.log('Category: no slug')
          resolvedData.slug = slugFormat(String(resolvedData.slug))
        },
        validateInput: ({ addValidationError, resolvedData, fieldKey }) => {
          const inputValue = resolvedData[fieldKey];

          if (!inputValue) return
          // @ts-ignore //todo might cause problems
          if (!inputValue.match(/^[a-z0-9]+(?:-[A-Za-z0-9]+)*$/)) {
            addValidationError(`Can only contain lower case "a-z" and dash "-" characters.`);
          }
        },
      }
    }),
```

[[developer/KeystoneJS/KeystoneJS\|KeystoneJS]]