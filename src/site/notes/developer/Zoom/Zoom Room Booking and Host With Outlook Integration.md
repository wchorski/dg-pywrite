---
{"dg-publish":true,"permalink":"/developer/zoom/zoom-room-booking-and-host-with-outlook-integration/","tags":["walkthrough","tutorial","Zoom","calendar","meetings"],"noteIcon":"","created":"2026-10-01T17:42:54.000-05:00","updated":"2026-10-01T17:42:54.000-05:00","dg-note-properties":{"tags":["walkthrough","tutorial","Zoom","calendar","meetings"]}}
---

Before we get started, you must have the [Zoom plugin for Outlook](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0062420) installed
## Create an Event in Outlook
To start, we making a good old Outlook Calendar Event. We will need 2 things
1. Meeting Title: *test Meeting for chit-Chat Committee*
2. Meeting start and end times: *4:30 PM to 5:00 PM*

Setting an end time is important as it makes sure there is no overlap with double bookings of the room

![[attachments/zoomroom-event-1.png\|attachments/zoomroom-event-1.png]]

### Add On a Zoom Link
After you have added the [Zoom for Outlook Add-in](https://appsource.microsoft.com/en-us/product/office/WA104381712?src=office&corrid=cd258da5-f6dd-35f4-3cd9-383fd4e1fdc9&omexanonuid=&referralurl=), you should see a **Zoom** button in your toolbar

![[attachments/zoomroom-event-2.png\|attachments/zoomroom-event-2.png]]

Clicking "Add a Zoom Meeting" will do 2 things

1. Add a zoom link `https://moeits.zoom.us/...` to the **Location** field (this becomes a one click Join button for all invitees)
2. Adds a written instructions to connect to the Zoom in the description of the Event
### Book a Room
Now it's time to book the room you will be using for your event. In the **Location** field, we can add another entry next to the link. 

> [!tip] If you don't know your meeting room's name
> If you don't know the exact name of the meeting room you may type `room` and let the drop down suggest all available rooms to book. From their you can click on your choice

![[attachments/zoomroom-event-3.png\|attachments/zoomroom-event-3.png]]

In this example we are booking the **MOEITS Conference Room**. This also automatically adds the room as a *Required participant* in the persons field. 

![[attachments/zoomroom-event-4.png\|attachments/zoomroom-event-4.png]]

### Double Bookings
> [!error] What Just Happened?
> If there is a conflicting event that overlaps your event, the room will reply with an email stating the conflict. 
> 
> This *does not* remove/block your calendar event, but does serve as a warning you may have a room mate for this meeting. You will need to resolve the conflict peer-to-peer.
> 
> ![[attachments/zoomroom-event-5.png\|attachments/zoomroom-event-5.png]]

> [!success] All Good
> Once you resolve the booking overlap and submit the updated start/end times you will receive an email from the Room resource that everything checks out
![[attachments/zoomroom-event-6.png\|attachments/zoomroom-event-6.png]]

---
## Add Online Meeting to All Events
For those who always want a virtual option added onto their meetings, you have an option in outlook to do just that. Follow [Microsofts docs](https://support.microsoft.com/en-gb/office/make-every-meeting-online-70f9bda0-fd29-498b-9757-6709cc1c73f0#os_type=windows) to find where to find these settings.

> [!note] Still Need to Book the Room
> You will still need to add the room to your **Location** field upon event creation

![[attachments/zoomroom-event-7.png\|attachments/zoomroom-event-7.png]]

## Think of a Zoom Room as Its Own Person
It's best to imagine a Zoom Room as if they are another employee or peer when creating calendar events and deciding permissions. Here are some things to consider and the benefits and drawbacks they come with. 

Moving over to the iPad (referred to as "the kiosk") You will see the scheduled meetings and controls Zoom.

![[attachments/Pasted image 20251113110954.png\|attachments/Pasted image 20251113110954.png]]

### Zoom Room as Participant
Setting the Location to the Zoom Room invites them as any other participant. The kiosk's schedule will populate with your meeting. Joining the meeting from the kiosk will have some caveats. 

- **Host Baton Pass:** Upon joining it will show "Waiting for host to join". You *must* start the meeting from your own account (from your work laptop or phone) for the kiosk to join.
- You will also *not* be able to moderate other participants (admit, mute, kick) from the kiosk.
- Meeting title will be overwritten with `<USER'S NAME> Meeting`. This is a privacy feature.
### Zoom Room as a Co-Host
You can give the Zoom Room host permissions under **Advanced Options**. This comes with many benefits and ease of use. Mainly skipping the **Host Baton Pass**

![[attachments/zoomroom-event-host.png\|attachments/zoomroom-event-host.png]]
 
- **Pro:** The Zoom Room now has permission to mediate other participants from the kiosk (admit, mute, kick, etc).
- **Con:** Anyone with access to the room may start or cancel the meeting from the kiosk. 

> [!tip] Pro Tip
> Mark `Mute participants upon entry`. For meetings that have more than 3 callins, this is a very nice feature that keeps the background chatter down. 

#### Touchscreen Kiosk
Here is 2 example meetings. 
- "test Conference Room" was setup with Host permissions given to the Zoom Room.
- "William Chorski" was a meeting setup without an alternative host.

The 2nd "William Chorski" Option is also clickable, but will show "waiting for host to start meeting".

![[attachments/Pasted image 20251113111319.png\|attachments/Pasted image 20251113111319.png]]

#### Host Baton Pass
There will be times where host permissions need to change during the meeting. Once the host starts the meeting you will be able 
- Join and admit Zoom Room into the meeting
- left click Zoom Room participant
- give "Co-Host" permissions

You've completed the host baton pass
#### Current Zoom Room [user accounts](https://zoom.us/account/user#/?searchKey=room)

| Room                          | email                         | Zoom ID                                   |
| ----------------------------- | ----------------------------- | ----------------------------------------- |
| **MOE Admin Boardroom AV**    |                               | `rooms_V6uShUf5SMSP4OH6Blwtnw@moeits.com` |
| **MOEITS Conference Room**    | `moeitsconfroom@moeits.com`   | `rooms_Xm1OgrHjRdulFrAYAi3PgA@moeits.com` |
| **FFC Large Conference Room** | `FFcConfroomLARGE@IIIFFC.ORG` | `rooms_d9SxWg6-RdCWzeCzzetutA@moeits.com` |
| **ASIP Conference Room**      |                               | `rooms_e_6OW_gOTv2OIoy9lyhfzA@moeits.com` |

Reason why emails have random letters `rooms_***@moeits.com`

> [!note] From Zoom Virtual Agent
> Thanks for your question! When you create a Zoom Room, Zoom automatically generates a unique email address for that room (like rooms_V6uShUf5SMSP4OH6Blwtnw@moeits.com). This email is used for calendar integration and to assign the room as an alternative host or invitee.
>
Currently, Zoom does not allow you to customize or change the auto-generated Zoom Room email address to match your organization's room resource email (such as boardroom@yourdomain.com). The random string is required by Zoom to uniquely identify each room within its system.
>
What you can do:
>
You can add the Zoom Room as an alternative host by using the auto-generated email address.
If you want to make it easier for users, consider sharing a list of your Zoom Room names and their corresponding Zoom-generated emails with your team.
Alternatively, you can create a contact in your organization's address book with the Zoom Room name and the Zoom-generated email, so users can easily find and add the room as an alternative host.
If you’d like more details on managing Zoom Rooms or alternative hosts, let me know!
