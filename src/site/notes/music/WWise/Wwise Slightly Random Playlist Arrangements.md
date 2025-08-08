---
{"dg-publish":true,"permalink":"/music/w-wise/wwise-slightly-random-playlist-arrangements/","tags":["music","interactive","dynamic","randomization","Wwise","flstudio","wwise","videogames","gamedev"],"created":"2025-08-06T21:32:59.656-05:00","updated":"2025-08-07T09:39:47.438-05:00"}
---

So you just wrote a banger of a tune for your next video game project. This piece was written in a more traditional sense that it was constructed to be listened to in sequence (such as intro, verse, chorus, verse, bridge, outro). Now how do we introduce some randomization to the arrangement without making it sound like it went through the blender?
## Writing in the DAW
We want to use the power of [[music/WilliaMusic/Wwise\|Wwise]] to break this piece into reusable chunks without completely destroying the flow of the original arrangement. Each section has similarities. I will list them in order of importance

1. 1 to 2 bar pickup (either a drum fill or noise swell)
2. 1 bar end (noise splash or reverb tail) 
3. Each 8 measures long (this is isn't as important to keep similar, but can help with even pacing between sections)

The original arrangement followed this pattern of **A1 - B1 - A2 - C1 - C2 - Bridge1 - Bridge2**. You will note the file names contain their alphanumeric identity

Here are a few of the waveforms for reference. You can see how each pickup can have quite a lot of interest (drum fills or swells) and the cue out is almost always a simple verb or cymbal tail.

![attachments/Pasted image 20250806223929.png](/img/user/attachments/Pasted%20image%2020250806223929.png)

![attachments/Pasted image 20250806224009.png](/img/user/attachments/Pasted%20image%2020250806224009.png)

![attachments/Pasted image 20250806224024.png](/img/user/attachments/Pasted%20image%2020250806224024.png)
## Sequencing in Wwise
don't forget to set your intro and outro cues appropriately 

![attachments/Pasted image 20250806214238.png](/img/user/attachments/Pasted%20image%2020250806214238.png)

### The Playlist
Let's breakdown the playlist logic.

![attachments/Pasted image 20250806213712.png](/img/user/attachments/Pasted%20image%2020250806213712.png)

close up

![attachments/Pasted image 20250806224147.png](/img/user/attachments/Pasted%20image%2020250806224147.png)

1. `Sequence Continuous`: The whole piece is wrapped in a single loop set to `infinite` Loop Count.
	1. `Random Step`: The First nested Group that chooses only one of it's nested children to play
		1. `Sequence Continuous` 
			1. **A1:** Intro Loop that establishes heavy rhythm
			2. **B1:** Strong melody motif with brass
		2. `Sequence Continuous` (may randomly skip rhythmic intro section to get straight to strong melody)
			1. **B1** 
	2. `Sequence Continuous`
		1. **A2:** Counter melody that bridges melody to C section. This clip plays every time in the same place.
	3. `Random Step` - chooses to play only on of the following nested children.
		1. `Sequence Continuous` - weight = `20` to make the longer 16 bar phrase more rare.
			1. **C1:** Lower energy that switches lead brass for harp
			2. **C2:** brass solo with elongated notes
		2. `Sequence Continuous` - weight = `60`
			1. **C1** 
		3. `Sequence Continuous` - weight = `60`
			1. **C2** 
	4. `Random Step`
		1. `Sequence Continuous` - weight = `10` very rare this section plays
			1. **Bridge1:** the most wide sweeping descending arpeggios with dramatic drop outs in volume
			2. **Bridge2:** big ascending runs of arpeggios that build to a climatic transition.
		2. `Sequence Continuous`
			1. **Bridge2**

> [!note] Original Arrangement: **A1 - B1 - A2 - C1 - C2 - Bridge1 - Bridge2**
> The above logic lows for a slightly randomized but very controlled set of new arrangements that include
> - **B1 - A2 - C2 - Bridge2**
> - **A1 - B1 - A2 - C1 - Bridge2**
> - **B1 - A2 - C2 - Bridge1 - Bridge2**
 
If my messy order list with inline notes doesn't explains the concepts well, here is the summary. I have split most sections into 2 parts. I believe the most interesting part is the `Random Step` containing all the **C** sections. 

During a pass the listener may hear 

1. both **C1** and **C2** as a full 16 bar phrase
2. only **C1**
3. or only **C2**

Musically, it does not sound good for **C2** to be played before **C1** so this setup doesn't allow that to happen. It only allows a very consciously designed set of arrangements.