.. title: Decoding to Loudspeaker Setups
.. slug: decoding-loudspeaker-iem
.. date: 2022-05-06 14:00
.. tags:
.. category: spatial_audio:iem-reaper
.. link:
.. description:
.. type: text
.. priority: 6
.. has_math: true
.. author: psch


Creating a Decoder
==================
Decoder can be created using the allrad decoder. In there the coordinats for each speaker can be set. The decoder requires a "body" meaning that a purely two dimensional speaker setup will not work. For that Imaginary speaker can be placed. Audio that is rendered on it is send to all connected speakers. To avoid this a gain factor can be applied.

Using a Decoder
===============
Route an ambisonics signal into the decoder channel. Make sure to send all channels (and not just 1/2).

Allrad Decoder itself can already process and decode ambisonics. But you can also export the created decoder and speakerlayouts for use in other IEM-Plugins.

The "SimpleDecoder" can import decoder files. With this plugin you are able to use a discrete subwoofer without extra signal splitting and processing and also a so called virtual subwoofer which sends the low frequency audio to all speakers. 

Distance Compensator
===================
A normal ambisonics decoder does only decode the direction of the incoming soundfield. So this would only work cleanly on a perfect sphere or circle. In realworld scenario this is barely the case, the distance from the speaker to the listener might diverge leading to different level and delays of the signal at the listeners position. To compensate for that effect the "DistanceCompensator" can be used. You can load the speaker layout file into it or adjust the distance manually. 