---
{"dg-publish":true,"permalink":"/developer/ReactJS/Mixing Style Objects Inline/","noteIcon":""}
---



```jsx
// App.js

import React from 'react';

const box = {
    color: "green",
    fontSize: '23px'
}

const shadow = {
    background: "orange",
    boxShadow: "1px 1px 1px 1px #cccd"
}

export default function App(){
    return (
      <div style={{...box, ...shadow}}>         <h1>Hello react</h1>
      </div>
      <div style={{...box, color: 'blue'}}>         <h1>Hello react</h1>
      </div>
    )
}
```

---
## Credits
-  [[https://reactgo.com/react-multiple-inline-styles/#:~:text=In React%2C we can add a inline styles,a single style object using the spread operator.\|https://reactgo.com/react-multiple-inline-styles/#:~:text=In React%2C we can add a inline styles,a single style object using the spread operator.]]