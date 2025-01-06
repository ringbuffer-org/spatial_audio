.. title: Using Ambisonics Recordings
.. slug: ambisonics-recordings
.. date: 2022-04-28 14:00
.. tags:
.. category: spatial_audio:supercollider
.. link:
.. description:
.. type: text
.. priority: 1
.. has_math: true

The following example uses a first order Ambisonics recording, and converts it to
a binaural signal, using the SC-HOA tools. The file can be downloaded here:

http://ringbuffer.org/download/audio/210321_011_Raven.wav

-----

The Recording
=============

A Format
--------

The file is a first order Ambisonics recording, shot outdoors with a *Zoom H3-VR*.
The original raw material is the so called A Format. It features one channel for each microphone.

B Format
--------

The file in the download is a first order Ambisonics B format recording.
This is a standardized format, encoding the sound field in spherical harmonics.

-----


Load HOA Stuff
==============

.. code-block:: supercollider

  // load HOA stuff for binaural:
  (
  HOABinaural.loadbinauralIRs(s);
  HOABinaural.loadHeadphoneCorrections(s);
  HOABinaural.binauralIRs;
  HOABinaural.headPhoneIRs;
  )


-----

Load Ambisonics File into Buffer
================================

The following code works with the file located in the same directory as the working script.
A buffer is used to read the four channel file:


.. code-block:: supercollider

  (
  var str = "210321_011_Raven.WAV";
  ~buf    = Buffer.read(s,str,0,-1);
  )


  // plot the audio data (may take some time):
  ~buf.plot();

-----

Create a Playback Node
======================

The buffer can be used with a ``PlayBuf`` UGen, to create a node which plays the
sample in a continuous loop.
An extra 4-channel audio bus is created for the Ambisonics signal.
It can be monitored to check whether the signal is playing properly:


.. code-block:: supercollider

    // create a 4-channel audio bus for the Ambisonics signal
    ~ambi_BUS =Bus.audio(s,4);

    // create a playback node (looped)
    (
    ~playback = {

    	var signal  = 	PlayBuf.ar(4, ~buf, 1, loop:1);

    	Out.ar(~ambi_BUS,signal*5);

    }.play;

    )

    // monitor all 4 Ambisonics channel
    ~ambi_BUS.scope();


-----

Create Binaural Decoder
=======================

An second node is created for decoding the Ambisonics signal,
allowing an additional rotation of the sound image.
It has three arguments for setting pitch, roll and yaw.
Make sure to move the new node after the playback node to get an
audible result:


.. code-block:: supercollider

    // create a decoder with angles as arguments:
    (

    ~decoder = {

    	arg pitch=0, roll=0, yaw=0;

    	var input    = In.ar(~ambi_BUS.index, 4);

    	var rotated  = HOATransRotateXYZ.ar(1, input, pitch, roll, yaw);

    	var binaural = HOABinaural.ar(1,rotated);

    	Out.ar(0, binaural);

    }.play;

    )

    // move after playback node
    ~decoder.moveAfter(~playback);

-----

Exercises
=========

.. admonition:: Exercise I

  Use the mouse for a continuous control of the angles.
