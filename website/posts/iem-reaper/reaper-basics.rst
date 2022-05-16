.. title: REAPER as DAW
.. slug: iem-plugins
.. date: 2022-05-06 14:00
.. tags:
.. category: spatial_audio:iem-reaper
.. link:
.. description:
.. type: text
.. priority: 1
.. has_math: true
.. author: psch


`REAPER <https://www.reaper.fm>` is a Digital Audio Workstation (DAW) made by Cockos. It is a feature-rich DAW offering many tools and a high flexibility in use and configuration. Besides it is also highly extendable through an extensive `API <https://www.extremraym.com/cloud/reascript-doc/#CSurf_OnRecvPanChange>` which can be used to write custom extensions and scripts written in LUA, EEL or Python. 

Tracks in REAPER
================

In most DAWs you differentiate between Audio-tracks, MIDI-tracks, Mixbus-tracks, ...
In contrast Tracks in Reaper can be used for everything and just the routing defines which role a track might have in project. 

Per default a track is a stereo track (there are no mono tracks) and all tracks are route to the Master- or Parenttrack. (*keep that in mind!*)

Routing
=======

Every track can be configured to have two or up to 64 channels.
*to configure channel number press the Route button*

Every track can send its audiochannels to
* Master-/Parenttrack
* Hardwareoutput
* Any other track

Any channel and any number of it can be send.
*in the route window choose new send to track or new hardware output*
*the number of channel is set after the creation of the send*

