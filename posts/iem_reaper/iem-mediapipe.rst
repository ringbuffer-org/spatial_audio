.. title: IEM Control with Mediapipe 
.. slug: iem-mediapipe
.. date: 2025-08-18 10:00
.. tags:
.. category: spatial_audio:iem-reaper
.. link:
.. description:
.. type: text
.. priority: 3
.. has_math: true
.. author: Henrik von Coler


Assignment: Camera-based Tracking with OSC and IEM
===================================================
    
The goal of this assignment is to connect **camera-based tracking** in Python to the
`IEM Plug-in Suite <https://plugins.iem.at/>`_ inside REAPER.
This allows the control of a spatial audio scene through movement and gestures.
At the core of this is a **Python** script tracking head or hands that sends OSC
messages with normalized coordinates via OSC.
These OSC messages will be used to control the IEM plugins.
The signal flow for this looks as follows:

.. figure:: /images/spatial/mediapipe_nopd.png
    :width: 70%
    :figwidth: 100%
    :align: center
 
    *Signal flow without PD.*


The connection can be realized with **Pure Data (Pd)** as additional bridge: Pd receives
tracking data via OSC from Python, parses the messages, and forwards them to
the IEM plug-ins, extending the *remote control* patch from the previous section.
This additional step can make parameter mapping easier during development:

.. figure:: /images/spatial/mediapipe_pd.png
    :width: 70%
    :figwidth: 100%
    :align: center

    *Signal flow with PD.*


----

Provided Material
=================

1. **IEM Remote Control Example in Pd**  
    * Reference patch and explanation: https://ringbuffer.org/spatial_audio/iem_reaper/iem-remote-pd/

2. **OSC Parser Patch (Pd)**  

    * Receives OSC on port 9000
    * Parses the incoming messages from Python
    * Extracts ``/head/pos`` or ``/hand/.../pos`` messages
    * Forwards the coordinates (X, Y) internally in Pd

 
.. figure:: /images/spatial/osc_parse.png
    :width: 70%
    :figwidth: 100%
    :align: center

    *OSC parser patch in PD.*

----

Task
====

The main task is to **design and implement the Python part**:

    * Use a webcam as input.
    * Detect **head** or **hand(s)** in real-time. Use `mediapipe <https://developers.google.com/mediapipe>`_ and OpenCV for hand or face/head detection. 
    * Normalize the coordinates to the range [0, 1].
    * Send OSC messages from the python script, using `python-osc <https://pypi.org/project/python-osc/>`_. Possible OSC messages are:

.. code-block:: python

    /head/pos   [x, y]
    /hand/left/pos  [x, y]
    /hand/right/pos [x, y]



    * X and Y should be relative to the camera image, top-left = (0,0).
    * (Optional) include extra information like bounding box or visibility.

----

Hints
=====

- Use (at least) the following Python modules:

.. code-block:: python

    import cv2
    import numpy 
    import mediapipe 
    from pythonosc.udp_client import SimpleUDPClient

- Start from a minimal working prototype:  

  * open camera → get positions → print them.  
  * then add OSC transmission.  
  * finally, connect to Pd and the IEM plug-ins.

- Test your messages in Pd using the provided parser patch before going into
  REAPER/IEM.


----

Advanced Mode
=============

Advanced students can use any audio software (PD, SuperCollider, Max, ...) and arbitrary tracking solutions to control spatial audio with gestures and movement.
