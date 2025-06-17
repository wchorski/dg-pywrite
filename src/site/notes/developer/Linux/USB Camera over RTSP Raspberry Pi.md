---
{"dg-publish":true,"permalink":"/developer/linux/usb-camera-over-rtsp-raspberry-pi/","dgPassFrontmatter":true}
---

https://github.com/bluenviron/mediamtx?tab=readme-ov-file#standalone-binary

```shell
# Create a directory for MediaMTX
mkdir -p ~/mediamtx
cd ~/mediamtx

# Download the latest version for ARM (Raspberry Pi)
wget https://github.com/bluenviron/mediamtx/releases/latest/download/YOUR_PC_PLATFORM

# Extract it
tar -xzvf mediamtx_YOUR_PC_PLATFORM.tar.gz

rm -r mediamtx_YOUR_PC_PLATFORM.tar.gz

# Make it executable
chmod +x mediamtx
```

`mediamtx.yml`

```yml
# MediaMTX configuration for USB camera streaming

# Log level
logLevel: info

# RTSP server settings
rtsp: yes
rtspTransports: [udp, multicast, tcp]
rtspEncryption: "no"
rtspAddress: :8554

# RTMP server settings (disable if not needed)
rtmp: no

# HLS server settings (disable if not needed)
hls: no

# Path settings
paths:
  camera:
    # This makes the stream available at rtsp://YOUR_PC_IP:8554/camera
    source: publisher
    sourceOnDemand: yes
    # Optional: record the stream
    record: no
```

```shell
sudo apt-get update
sudo apt-get install -y ffmpeg
```

```shell
ls /dev/video*

## output
/dev/video0   /dev/video12  /dev/video16  /dev/video20  /dev/video31
/dev/video1   /dev/video13  /dev/video18  /dev/video21
/dev/video10  /dev/video14  /dev/video19  /dev/video22
/dev/video11  /dev/video15  /dev/video2   /dev/video23

v4l2-ctl --list-devices

## output
...

rpivid (platform:rpivid):
        /dev/video19
        /dev/media1

USB Camera-B4.04.27.1 (usb-0000:01:00.0-1.2):
        /dev/video2

USB3.0 HD Video: USB3.0 HD Vide (usb-0000:01:00.0-1.4):
        /dev/video0
        /dev/video1
        /dev/media4
```

the second `v4l2-ctl --list-devices` lists a much more descriptive list. Here you can see my HDMI capture device as well as the usb camera. we want `/dev/video2`

`start_camera_stream.sh`

```shell
#!/bin/bash

# Install FFmpeg if not already installed
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y ffmpeg
fi

# Camera device
# Change this to your identified camera device
CAMERA_DEV="/dev/video0"

# Check if camera exists
if [ ! -e "$CAMERA_DEV" ]; then
    echo "Error: Camera $CAMERA_DEV not found!"
    echo "Available video devices:"
    ls -l /dev/video*
    exit 1
fi

# MediaMTX URL
RTSP_URL="rtsp://localhost:8554/camera"

# Camera settings
RESOLUTION="640x480"
FRAMERATE="30"

echo "Starting camera stream from $CAMERA_DEV to $RTSP_URL"
echo "Press Ctrl+C to stop streaming"

# Start the stream
ffmpeg -f v4l2 -input_format yuyv422 -i "$CAMERA_DEV" \
    -video_size "$RESOLUTION" -framerate "$FRAMERATE" \
    -c:v libx264 -preset ultrafast -tune zerolatency \
    -f rtsp -rtsp_transport tcp "$RTSP_URL"
```

```shell
chmod +x start_camera_stream.sh
```


`mediamtx.service`

```service
[Unit]
Description=MediaMTX RTSP Server
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi/mediamtx
ExecStart=/home/pi/mediamtx/mediamtx
Restart=on-failure
RestartSec=5
StandardOutput=inherit
StandardError=inherit

[Install]
WantedBy=multi-user.target
```

```shell
sudo cp mediamtx.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable mediamtx.service
sudo systemctl start mediamtx.service
```


`camera-stream.service`

```service
[Unit]
Description=USB Camera RTSP Stream
After=network.target mediamtx.service
Requires=mediamtx.service

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi/mediamtx
ExecStart=/home/pi/mediamtx/start_camera_stream.sh
Restart=on-failure
RestartSec=5
StandardOutput=inherit
StandardError=inherit

[Install]
WantedBy=multi-user.target
```

```shell
sudo cp camera-stream.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable camera-stream.service
sudo systemctl start camera-stream.service
```

## NVR
[[developer/Home Lab/Frigate NVR\|Frigate NVR]]
