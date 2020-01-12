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

Let us first setup the LoPy. I am using a LoPy1.0 with expansion board 2.0 updated to firmware 1.16. **Please update the LoPy before proceeding.** We will use the nano-gateway code provided by pycom. There are a total of 3 files - main.py, config.py, and nanogateway.py.

1. We need a Gateway ID which is unique to each LoPy device. Just run the following lines of code on the device through REPL command line interface (use ATOM editor).
```
from network import WLAN
import ubinascii
wl = WLAN()
ubinascii.hexlify(wl.mac())[:6] + 'FFFE' + ubinascii.hexlify(wl.mac())[6:]
```
