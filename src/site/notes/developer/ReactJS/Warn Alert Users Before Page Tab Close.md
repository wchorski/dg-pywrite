---
{"dg-publish":true,"permalink":"/developer/ReactJS/Warn Alert Users Before Page Tab Close/","tags":["reactjs","javascript","webdev"],"created":"2024-03-05T21:45:14.953-06:00","updated":"2024-03-06T13:20:21.000-06:00"}
---

## Get started 
trigger the popup warning when user tries to close the page

```tsx
import { useState, useEffect } from 'react';

export function AreYousureConfirmation(){

  const [isUnsavedWork, setIsUnsavedWork] = useState(false)
  

  useEffect(() => {
    if(!isUnsavedWork) return

    function handleOnBeforeUnload(event:BeforeUnloadEvent){
      event.preventDefault()
      return (event.returnValue = '')  
    }

    window.addEventListener('beforeunload', handleOnBeforeUnload, { capture: true} )
    
    return () => window.removeEventListener('beforeunload', handleOnBeforeUnload, { capture: true} )
  }, [isUnsavedWork])
  

  return (
    <>
      
    </>
  )
}
```


## Make It Smarter
Make the popup aware of the form data so warnings only trigger when there is leftover data in the form.

```tsx
import { useState, useEffect, FormEvent } from 'react';

export function AreYousureConfirmation(){

  const [isUnsavedWork, setIsUnsavedWork] = useState(false)
  
  function handleOnChange(event: FormEvent){
    const data = new FormData(event.currentTarget as HTMLFormElement)
    const values = Array.from(data.values())
    const changedFields = values.filter(value => value.length || (value as File).size)
    setIsUnsavedWork(Boolean(changedFields.length))
  }

  useEffect(() => {
    if(!isUnsavedWork) return

    function handleOnBeforeUnload(event:BeforeUnloadEvent){
      event.preventDefault()
      return (event.returnValue = '')  
    }

    window.addEventListener('beforeunload', handleOnBeforeUnload, { capture: true} )
    
    return () => window.removeEventListener('beforeunload', handleOnBeforeUnload, { capture: true} )
  }, [isUnsavedWork])
  

  return (
    <>
      <form 
        action="" 
        onChange={handleOnChange}
      ></form>
    </>
  )
}
```

---
## Credits
- [[developer/ReactJS/ReactJS\|ReactJS]]
- [Warn Users When Leaving a Page in React with beforeunload (youtube.com)](https://www.youtube.com/watch?v=K8YShjU5PBQ)