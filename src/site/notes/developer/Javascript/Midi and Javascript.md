---
{"dg-publish":true,"permalink":"/developer/Javascript/Midi and Javascript/","dgPassFrontmatter":true}
---

This is the beginning how I learn to input midi into a web browser via #javascript 

### HTML
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Midi Keyboard</title>
  <script src="./keyboard.js" async></script>
</head>
<body>

  <button id="btn-start">start</button>
  
</body>
</html>
```

### JS
```js
console.log('keyboard');

window.AudioContext = window.AudioContext || window.webkitAudioContext
let ctx = null
let oscillators = []

const btnStart = document.getElementById('btn-start')
btnStart.addEventListener('click', () => handleInit())

//? Setup
const handleInit = () => {
  if (!ctx) {
    const newAudioContext = new AudioContext();
    newAudioContext.resume().then(() => {
      ctx = newAudioContext
      setupMidiAccess(newAudioContext);
    });
  }
};

const setupMidiAccess = (audioContext) => {
  navigator.requestMIDIAccess().then(success, failure);
};

function success(midiAccess){
  // midiAccess.onstatechange = updateDevices
  const inputs = midiAccess.inputs

  inputs.forEach((input) => {
    input.onmidimessage = handleInput
  })
  
}

function failure(){
  console.warn('Can not connect MIDI navigator');
}

// function updateDevices(e){
//   // console.log(e);
//   console.table({
//     Name: e.port.name,
//     Brand: e.port.manufacture,
//     State: e.port.state,
//     Type: e.port.type,
//   });
  
// }


//? input control
function handleInput(input) {
  const command   = input.data[0]
  const note      = input.data[1]
  const velocity  = input.data[2]

  // console.table({
  //   command,
  //   note,
  //   velocity,
  // })

  switch (command) {

    case 144: // note on
      (velocity > 0)
        ? noteOn(note, velocity)
        : noteOff(note, velocity)
      break;

    case 128: // note off
      noteOff(note, velocity)
      break;
  
    default:
      break;
  }
  
}

function noteOn(note, velocity) {

  if(!ctx) return console.warn('no audio ctx')

  const osc = ctx.createOscillator()
  const oscGain = ctx.createGain()
  oscGain.gain.value = 0.3

  const VelGainAmt = velocity / 127
  const velGain = ctx.createGain()
  velGain.gain.value = VelGainAmt

  osc.type = 'sine'
  osc.frequency.value = midiToFreq(note)

  osc.connect(oscGain)
  oscGain.connect(velGain)
  velGain.connect(ctx.destination)

  osc.gain = oscGain
  osc.start()

  oscillators = [...oscillators, osc]
  
}

function noteOff(note, velocity) {

  const releaseTime = ctx.currentTime + 0.03
  
  const updatedOscillators = oscillators.filter((oscillator) => {
    const freq = oscillator.frequency.value;
    if (freqToMidi(freq) === note) {

      const oscGain = oscillator.gain

      oscGain.gain.setValueAtTime(oscGain.gain.value, ctx.currentTime)
      oscGain.gain.exponentialRampToValueAtTime(0.0001, releaseTime) // sustain & release
      
      setTimeout(() => {
        oscillator.stop();
        oscillator.disconnect();
      }, releaseTime + 10);

      return false;
    }
    return true;
  });

  oscillators = updatedOscillators
  console.log(oscillators);

}


//? lib calculations
function midiToFreq(num){
  const a = 440
  return (a / 32) * (2 ** ((num - 9) / 12))
}

function freqToMidi(frequency) {
  const midiNote = 12 * Math.log2(frequency / 440) + 69;
  return Math.round(midiNote);
}
```

left in a few comments during my debug journey. The `updateDevices()` function could be useful later when I want to add UI selection for different controllers.

## Troubleshooting

### Encoders / faders cause lag
looks like it was just because I was logging a 6 cell `console.table` very fast




---
## Credits
- [JavaScript MIDI Synth Tutorial - Part 1 | Getting MIDI in the browser - YouTube](https://www.youtube.com/watch?v=KRm_GICiPIQ)

## Backlinks
- [[developer/Javascript/Javascript\|Javascript]]
- [[developer/developer_box📦\|developer_box📦]]