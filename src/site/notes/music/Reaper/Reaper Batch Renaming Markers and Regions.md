---
{"dg-publish":true,"tags":["Reaper","DAW","sound_design","SFX"],"permalink":"/music/reaper/reaper-batch-renaming-markers-and-regions/","dgPassFrontmatter":true,"dg-note-properties":{"tags":["Reaper","DAW","sound_design","SFX"]}}
---

> [!tip] Dynamic Split
> Going to assume you know `D` for dynamic split. When working with 0.2-1s clips make sure to uncheck "At Transients", start with "Threshold" at 0db and keep working your way to - infinity until you see the silence spaces you want removed

## Create Regions Per clip
1. Highlight the clips you want to make regions for
2. Actions > `Markers: Insert seperate regions for each selected item`
## Install Package
1. In the DAW `Extensions > RePack > Browse Packages`
2. search for `batch rename plus` (right click and install)
3. install https://sws-extension.org/download/pre-release/ with your OS. My Win 11 64-bit PC used `sws-2.14.0.7-Windows-x64-9daba634.exe`
4. Run the Action `Batch Rename Plus`
5. You may be asked to install other packages (GUI, etc.)
	1. `reaper_js_ReaScriptAPI64.dll`
	2. `reaper_imgui-x64.dll`
	3. restart Reaper as needed
## Batch Rename Region Names
1. Select clips/regions you wish to target
2. Run the Action `Batch Rename Plus` 
3. `Apply To` target select `Regions / Selected Retions`
4. Click first region in timeline, hold shift and click the last region to select multiple.
5. checkbox `Rename` and fill in text
6. Use `Specifiers` to help append prefix/suffix like numbered indexes.
7. hit `Rename All`

![attachments/Pasted image 20260722224511.png](/img/user/attachments/Pasted%20image%2020260722224511.png)

![attachments/Pasted image 20260722224532.png](/img/user/attachments/Pasted%20image%2020260722224532.png)

---
## Credit
- https://www.youtube.com/watch?v=BEhAUTAh13k
- https://github.com/zaibuyidao/ReaScripts/raw/master/index.xml
- [[music/Reaper/Reaper DAW Knowledge\|Reaper DAW Knowledge]]