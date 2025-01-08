---
{"dg-publish":true,"permalink":"/music/WilliaMusic/P4V Perforce Push Pull Walktrough/","tags":["stepBystep","walkthrough"],"created":"2025-01-07T22:47:18.467-06:00","updated":"2025-01-08T00:17:37.016-06:00"}
---


### P4V Get Latest
To **pull** in the latest updates first

1. highlight folder you wish to sync (go farther into the nested structure to single out what parts you need to avoid extra downloads)
2. hit the **Get Latest** button and wait for **Log** box to complete

![attachments/p4v-push_pull-walkthrough (2).png](/img/user/attachments/p4v-push_pull-walkthrough%20(2).png)

### Wwise Project

1. Open Wwise project `WwiseProject.wproj` through AudioKinetic Launcher **With Proper Version**
	1. Do not upgrade version
2. Find the "Work Unit" you will be editing.
	1. Make sure it has a free green dot (no one has it checked out)

![attachments/p4v-push_pull-walkthrough (3).png](/img/user/attachments/p4v-push_pull-walkthrough%20(3).png)

#### Check out Unit
1. Editing and saving (ctrl + s) a Work Unit will automatically check out (turn green dot to red !)
	1. You an also manually check out a Unit with the context menu
![attachments/p4v-push_pull-walkthrough (4).png](/img/user/attachments/p4v-push_pull-walkthrough%20(4).png)

#### Saving a Change
Here I've edited the switch container `MusicSwitchAlien` to `MusicSwitchAlien_CHANGE` and am about to save. 

![attachments/p4v-push_pull-walkthrough (6).png](/img/user/attachments/p4v-push_pull-walkthrough%20(6).png)

After I save the Unit gets checked out (red !)
![attachments/p4v-push_pull-walkthrough (7).png](/img/user/attachments/p4v-push_pull-walkthrough%20(7).png)

### Back over to P4V
After your done with your edits check back to the P4v (you didn't close it did you?) and you'll notice a parallel updates under the **Pending** tab in P4V

![attachments/p4v-push_pull-walkthrough (8).png](/img/user/attachments/p4v-push_pull-walkthrough%20(8).png)

> [!tip] Revert Changes
> Above I accidently checked out a file that I did not make changes to. You're able to context menu and "Revert if Unchanged" these in P4V. Check out below

![attachments/p4v-push_pull-walkthrough (12).png](/img/user/attachments/p4v-push_pull-walkthrough%20(12).png)

#### Submit Changes
You now ready to **push** the new changes. Hit the big juicy **Submit** button to start

> [!note] HOLD UP
> You must make a **commit message** in the pop up dialogue box. Here is an example

```txt
[Music - Will] BC-119
- Name change "MusicSwitchAlien_CHANGE"
- 3 New Assets
- beefed up weapon oneshot randomizer
- new RTPC for camera proximity
```

The first bit `[Music - Will]` represents the what has been done and by who. the `BC-224` is the Jira ticket # (screenshot from Jira below)

![attachments/Pasted image 20250107235241.png](/img/user/attachments/Pasted%20image%2020250107235241.png)

The rest is really up to you, the more detail the better. I'll say `Name change "MusicSwitchAlien_CHANGE` is a bit overkill, but the other 3 (phony changes) listed are more inline with what should be noted. This is to help both you and the team remember each commit in case we need to roll back the project. Be descriptive enough that you'd remember the commit in a month or 2 down the road.

![attachments/p4v-push_pull-walkthrough (11).png](/img/user/attachments/p4v-push_pull-walkthrough%20(11).png)

Now you may hit the **Submit** button in the pop up to finish the job
### Double Check Wwise
Back in Wwise the **red !** should now have turned back to a **green dot**. Sometimes it doesn't update right away. You have 2 options.
1. Close and reopen Wwise
2. Hit "Source Control > Refresh All" in the context menu (screenshot below)

![attachments/p4v-push_pull-walkthrough (1).png](/img/user/attachments/p4v-push_pull-walkthrough%20(1).png)

> [!tip] If that doesn't work
> Look back to P4V and see if you need to **Revert Unchanged** 

## Generate Soundbanks
Note, that when adding new assets you must generate new sound banks before you commit any changes. 

I'd recommend just getting in the habit of always generating sound banks every time your down with a session of work.

![attachments/Pasted image 20250108000236.png](/img/user/attachments/Pasted%20image%2020250108000236.png)

This will "Completed with fatal errors". That is normal and expected. Just close the window and don't ask too many questons.

![attachments/Pasted image 20250108000538.png](/img/user/attachments/Pasted%20image%2020250108000538.png)

### Unlock File
Sometimes you may get a permission error when trying to save preventing you from modifying the file

Try these 2 options in your file browser (Explorer for Windows or Finder for MacOS)

1.  =="***_WwiseProject"==  uncheck `'read-only'`
2. uncheck `read-only` for file **Wwise_IDs.h** in ==" I:\SA\***\Dev\***Unity\Assets\StreamingAssets\Audio\GeneratedSoundBanks"==