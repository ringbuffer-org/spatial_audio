.. title: IEM Remote Control with PD 
.. slug: iem-remote-pd
.. date: 2023-12-19 10:00
.. tags:
.. category: spatial_audio:iem-reaper
.. link:
.. description:
.. type: text
.. priority: 2
.. has_math: true
.. author: Henrik von Coler




Controlling the IEM plugins with OSC messages, i.e. sent from another software or expressive interfaces, opens more possibilities than using only DAW automations. Each plugin in the suite comes with a OSC receiver, which can be enabled and listens to a defined set of messages. 

All information for controlling the IEM plugins, including the defined OSC paths are included in the IEM documentation: `<https://plugins.iem.at/docs/osc/>`_
The following example shows how to control the position of a virtual sound source, using the StereoEncoder plugin.

-----

Setting up the Plugin
=====================

Open a UDP port for the plugin to listen on:

.. figure:: /images/spatial/iem-encoder-osc.png
  :width: 50%
  :figwidth: 100%
  :align: center


-----


Sending from PD
===============

All parameters of the StereoEncoder can be controlled through OSC. The corresponding OSC paths and parameter ranges are listed here: `<https://plugins.iem.at/docs/osc/#stereoencoder>`_

To assemble the complete OSC command, each plugin has an individual string: `<https://plugins.iem.at/docs/osc/#osc-messages>`_
The full OSC path for controlling the azimuth is: 

    /StereoEncoder/azimuth 40.0


The following PD patch uses no additional libraries and should work as it is. Both the IEM plugins and PD need to me running on the same machine. It snds to a port via ``netsend`` (click ``connect to localhost`` in the beginning) - it needs to be the same one opened by the plugin.

The OSC path is defined in the ``oscformat`` object. It can be changed, if other paramters should be controlled.

.. figure:: /images/spatial/pd_to_iem.png
  :width: 30%
  :figwidth: 100%
  :align: center

NOTE: 
-----

Since a single encoder plugin opens an individual OSC port, each instance of the encoder plugin needs to open an individual port. The MultiEncoder allows the control of more sources (but in one channel). with a single port.

