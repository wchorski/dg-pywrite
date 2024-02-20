---
{"dg-publish":true,"permalink":"/music/music-theory/euclidean-rhythms/","noteIcon":""}
---

[[observablehq.com)](https://observablehq.com/@toja/euclidean-rhythms\|Euclidean rhythms / Torben Jansen / Observable (observablehq.com)]]

> [!quote] _"What do African rhythms, spallation neutron source (SNS) accelerators in nuclear physics, string theory (stringology) in computer science, and an ancient algorithm described by Euclid have in common? The short answer is: patterns distributed as evenly as possible"_. *Godfried Toussaint*

```js
presets = [
  {
    name: "Love is in the air (Intro)",
    patterns: [
      { pulses: 1, steps: 8, play: kick },
      { pulses: 2, steps: 8, rotation: 1, play: clap },
      { pulses: 5, steps: 8, rotation: 3, play: hihat },
    ],
    bpm: 122,
    timeDivision: 4
  },
  {
    name: "Disco",
    patterns: [
      { pulses: 2, steps: 8, play: kick },
      { pulses: 1, steps: 8, rotation: 4, play: snare },
      { pulses: 7, steps: 8, rotation: 4, play: hihat },
    ],
    bpm: 120,
    timeDivision: 4
  },
  {
    name: "Custom",
    patterns: [
      { pulses: 1, steps: 6, rotation: 0, play: kick },
      { pulses: 1, steps: 6, rotation: 3, play: snare },
      { pulses: 2, steps: 6, rotation: 2, play: hihat },
      { pulses: 1, steps: 7, rotation: 6, play: clap },
      { pulses: 1, steps: 7, rotation: 4, play: rim },
      { pulses: 1, steps: 4, rotation: 1, play: rim },
    ],
   bpm: 120,
   timeDivision: 3
  }
]
```
