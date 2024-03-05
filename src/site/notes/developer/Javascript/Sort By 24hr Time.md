---
{"dg-publish":true,"permalink":"/developer/Javascript/Sort By 24hr Time/"}
---

I have an Array of objects each with a 24 hour `time` attribute. I want to simply sort the array so earlier times `00:00` are put in the front and later times `23:55` are put at the end of the array before I map over 

```jsx
{doc.sections
    .sort((prev, curr) =>{
      if(!prev.timeStart || !curr.timeStart) return

      if (prev.timeStart > curr.timeStart) return 1

      if (prev.timeStart < curr.timeStart) return -1

      return 0

    })
    .map((sec, i) => {

      if(!sec) return 

      console.log('sorted → ', sec.header, ' - ', sec.timeStart);

      return (

          <MyComponent 
            key={i}
            section={sec} 
          />
      )
    })}
```

---
## Credits 
- [Easily Sort Before Displaying Records in React JS | SUPER USEFUL - YouTube](https://www.youtube.com/watch?v=zZzcnmU_LoU)