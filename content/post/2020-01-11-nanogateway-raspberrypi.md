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
[Blog not complete yet. Under construction!!]
LoRa Gateway in a LoRaWAN network is a device/hardware which connects an end sensing/client LoRa node to a wide network such as the internet or your local network. Though the full fledged LoRa gateways available on the market proivide advance features and capabilities, they are costly and and bulky. Today, I will share the steps and my experience in setting up a LoRa gateway using two palm-sized embedded systems - a LoPy and Raspberry Pi 3. 

The already available instructions on manufacturer site are designed to be used for The Things Network. This blog provide a minimum steps to setup a Chirpstack LoRaWAN server to which one have more control and is not connected to the internet. 

The whole process has four major steps:

1. Install Chirpstack LoRaWAN stack on RPi3.
2. Create a wireless access point on the RPi3.
3. Setup the LoPy as nanogateway and adding it to Chirpstack server.
4. Registering the Nanogateway and client LoPy node with Chirpstack server.

_Pre-requisites_

1. RPi3 with Raspbian installed and connected to a monitor. We need the screen at least during all the stages. However, once the whole setup is finished, you can use the system headless.
2. RPi3 connected to internet for update and downloading required packages.
3. Two LoPys with latest firmware. I am using 1.16.
4. Atom editor with pycom plugin to upload code to LoPy.

_Step-1_

1. `sudo apt update` & `sudo apt upgrade` -- first update and then upgrade the Raspbian OS.

2. Follow the steps from [here](https://www.chirpstack.io/guides/debian-ubuntu/) and install the chirpstack.

_Step-2_

The RPi3 has an in-built WiFi chipset which can be converted into an access point to which other WiFi-enabled devices can connect (for e.g., LoPy). Follow the steps in this tutorial: 	

[Setting up a Raspberry Pi as an access point in a standalone network (NAT)](https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md). No need to follow the steps for sharing internet, we dont need it.

_Step-3_

I am using a LoPy4.0 with expansion board 3.0 updated to firmware 1.16. _Please update the LoPy before proceeding._ We will use the nano-gateway code provided by pycom. There are a total of 3 files - main.py, config.py, and nanogateway.py.


1. We need a Gateway ID which is unique to each LoPy device. Just run the following lines of code on the device through REPL command line interface (use ATOM editor with pycom plugin).
```
from network import WLAN
import ubinascii
wl = WLAN()
ubinascii.hexlify(wl.mac())[:6] + 'FFFE' + ubinascii.hexlify(wl.mac())[6:]
```
You will get output similar to `b'240ac4FFFE008d88'`. Copy the `240ac4FFFE008d88` part and save it somewhere for later use.

2. Create a project folder and copy these three files - [main.py](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/main.py), [config.py](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/config.py), and [nanogateway.py](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/nanogateway.py) inside the folder.

3. Open the project folder in ATOM and edit the `nanogateway.py` file. Since I am on an eduroam network, it is difficult to setup internet. Thus, we will remove any lines of code in the `nanogateway.py` file which requires internet. Fortunately, there are not many lines. Specifically, just comment out lines `145--149` which have `ntp_sync` function calls. 

4. `main.py`: Keep the file untouched.

5. `config.py`: Enter the required fields,
	- SERVER = 'IP of RPi access point entered in Step-2'
	- PORT = 1700
	- WIFI_SSID = 'WIFI name created in Step-2'
	- WIFI_PASS = 'WIFI password created in Step-2'
	- I am in Europe region and thus uncomment the lines for EU868 and comment for US915.

6. Upload the project into the LoPy using Atom.

_Step-4_

Now we need to register both the Nanogateway and the client LoPy node on the Chirpstack server. This step is important in order to create and join the LoRaWAN network.

1. Follow this youtube [video](https://youtu.be/mkuS5QUj5Js?t=285tea) from time=04:45.
2. The gateway, service, device and application profiles should be created by now.
3. Now keep the RPi and the LoPy with the nanogateway code together.
4. The nanogateway should now be able to connect to the RPi hotspot and thus they are on the same network. In principle, whatever the data packet nanogateway receives from the client LoPy node, will be forwarded to the Chirpstack server running on the RPi.
5. At the client node side: Upload the code from [here](https://github.com/pycom/pycom-libraries/blob/master/examples/lorawan-nano-gateway/otaa_node.py) into another LoPy which will act as a clinet node.


##Conclusions
If everything is setup fine, you should be able to see the packets received at the RPi side. I hope this tutorial helps any enthusiast and hacker out there.

Thank you.







