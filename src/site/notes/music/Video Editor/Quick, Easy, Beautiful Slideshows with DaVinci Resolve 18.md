---
{"dg-publish":true,"permalink":"/music/Video Editor/Quick, Easy, Beautiful Slideshows with DaVinci Resolve 18/","tags":["video","filmeditor","pictures","DaVinci_Resolve"],"created":"2024-03-23T10:17:01.929-05:00","updated":"2024-03-24T21:03:56.000-05:00"}
---

Here's a [[music/Video Editor/Video Editor\|Video Editor]] tip to making... *just read the title of this note again*
### Default Image Length
How long each still image will play when dragged into the editor timeline. For slideshows, `4 seconds` is a good sweet spot for picture viewing.

`DaVinci Resolve > Preferences > User Tab > Editing > Standard still duration`

Go for a bit longer than you need for the default time duration. It's easier to cut back time then add time for all images
### Image Scaling
Tweak all images for more consistent aspect ratio's. 
1. Double click any one image in your media pool. 
2. Then Highlight all images 
3. Check bottom of **Inspector** window for **Scaling** select dropdown
4. Choose an option that fits your needs
5. OR you can mess with **Transform** if you want a more custom look
### Change Clip Length on Timeline
If you've already plopped down the images in the timeline but need to shorten all the clip lengths, fear not. Highlight desired clips in the timeline and...

Context Menu ->`Change Clip Duration` or shortcut `ctrl + D`
### Background
You can generate a background with `Effects > Generators`
- Texture
- Solid Color
- Gradient Color
- Or just drop in a Static Image as a background layer
#### Effects
- Blur
- Drop Shadow
- Blanking Fill (blurred image of current image)

You can `ctrl + c` & `alt + v` these effects to other clips in the timeline by only checking the **Plugins** box
#### Picture Boarder
1. Context -> `Open in Fusion Page`
2. Make sure you see `Clips` tab as highlighted
3. Effects `Templates > Color Boarder`
4. Select The clips that also want this effect
5. Context `Apply Composition`
### Transitions
Add a transition to multiple clips 
1. Select desired clips in timeline 
2. Find Transition in **Effects** pane
3. Context -> `Add to selected edit points and clips`
#### Zooms
1. Effects `Adjustment Clip`
2. Inspector `Dynamic Zoom` on
## Credit
- [Slideshow MASTERCLASS for Davinci Resolve 18 - Everything you need to know! (youtube.com)](https://www.youtube.com/watch?v=eHj6Ed6fk7s)