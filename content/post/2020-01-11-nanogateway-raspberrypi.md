---
title: 'Setting up Chirpstack.io LoRaWAN Nanogateway using LoPy and RPi3'
author: Tushar Semwal
date: '2020-01-11'
slug: nanogateway-rpi3
categories: ["iot"]
tags: ["iot", "lopy", "embedded","rpi"]
header:
  caption: ''
  image: ''
---
LoRa Gateway in a LoRaWAN network is a device/hardware which connects an end sensing/client LoRa node to a wide network such as the internet or your local network. Though the full fledged LoRa gateways available on the market proivide advance features and capabilities, they are costly and and bulky. Today, I will share the steps and my experience in setting up a LoRa gateway using two palm-sized embedded systems - a LoPy and Raspberry Pi 3. 

The already available instructions on manufacturer site are designed to be used for The Things Network. This blog provide a minimum steps to setup a Chirpstack LoRaWAN server to which one have more control and is not connected to the internet. 

Let us first setup the LoPy. I am using a LoPy4.0 with expansion board 3.0 updated to firmware 1.16. **Please update the LoPy before proceeding.** We will use the nano-gateway code provided by pycom. There are a total of 3 files - main.py, config.py, and nanogateway.py.

I am using ATOM editor with a pycom plugin.

1. We need a Gateway ID which is unique to each LoPy device. Just run the following lines of code on the device through REPL command line interface (use ATOM editor).
```
from network import WLAN
import ubinascii
wl = WLAN()
ubinascii.hexlify(wl.mac())[:6] + 'FFFE' + ubinascii.hexlify(wl.mac())[6:]
```
You will get output similar to `b'240ac4FFFE008d88'`. Copy the `240ac4FFFE008d88` part and save somewhere. We will be using it later.

2. Create a project folder and copy these three files - [main.py](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/main.py), [config.py](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/config.py), and [nanogateway.py](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/nanogateway.py) inside the folder.

3. Open the project folder in ATOM and edit the `nanogateway.py` file. Since I am on an eduroam network, it is difficult to setup internet. Thus, we will remove any lines of code in the `nanogateway.py` file which requires internet. Fortunately, there are not many line. Just comment out lines `145--149` which show ntp_sync function calls. 

4. 







