---
{"dg-publish":true,"permalink":"/music/w-wise/intro-into-continuous-loop-with-wwise-music/","tags":["Wwise","interactive","music","dynamic"],"created":"2025-08-06T21:52:31.528-05:00","updated":"2025-08-07T09:40:48.240-05:00"}
---

Clip labeled `A-intro` is a 4 measure lead-in to an 18 measure musical phrase. I only want the intro to play once and have the main `B-loop` play indefinitely until a transition is triggered by player input, moving us into a different song or level.

![attachments/Pasted image 20250806215339.png](/img/user/attachments/Pasted%20image%2020250806215339.png)

note that the first Group has its `Loop Count` set to `1`. Where the second nested group is set to `infinite`