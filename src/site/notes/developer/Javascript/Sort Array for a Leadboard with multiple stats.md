---
{"dg-publish":true,"permalink":"/developer/Javascript/Sort Array for a Leadboard with multiple stats/","created":"2024-02-29T22:19:56.021-06:00","updated":"2024-06-04T15:44:23.000-05:00"}
---

for my typing game [[developer/Projects/Keyboard Warrior\|Keyboard Warrior]] I wanted to create a leaderboard that ranks player scores by `words per minute`. Sometimes a player will have the same score as another, so I needed to use a second stat that compares the `accuracy` of the keystrokes.

```jsx
{stats && stats.sort((prev, curr) =>{
            if(!prev.wpm || !curr.wpm) return
            if(prev.wpm === curr.wpm){
              if(prev.accuracy > curr.accuracy) return -1
              if(prev.accuracy < curr.accuracy) return 1
            } 
            if (prev.wpm >   curr.wpm ) return -1
            if (prev.wpm <   curr.wpm ) return 1
            return 0

          }).map((stat, i) => (
            <tr key={i+1}>  
              <td>{handleTrophy(i+1)}</td>
              <td><img src={stat.image} alt='profile picture' className='img-thumbnail'/></td>
              <td>{stat.email}</td>
              <td>{stat.wpm}</td>
              <td>{stat.accuracy}%</td>
              <td>{stat.correctCount}</td>
              <td>{stat.apm}</td>
            </tr>
          ))}
```

---
## Credits
- 