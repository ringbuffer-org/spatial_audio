.. title: Spatial Additive in SuperCollider
.. slug: spatial_additive_supercollider
.. date: 2022-05-23 10:00:00
.. tags:
.. category: spatial_audio:synthesis
.. link:
.. description:
.. type: text
.. has_math: true
.. priority: 3

The following example creates a spatially distributed sound through
additive synthesis.
A defined number (40) of partials is routed to individual virtual sound
sources which are rendered to a 3rd order Ambisonics signal.


A Partial SynthDef
==================

A  SynthDef for a single partial with amplitude and frequency as arguments.
In addition, the output bus can be set.
The sample rate is considered to avoid aliasing for high partial frequencies.

.. code:: supercollider

  (
  SynthDef(\spatial_additive,

  	{
  		|outbus = 16, freq=100, amp=1|

  		// anti aliasing safety
  		var gain = amp*(freq<(SampleRate.ir*0.5));

  		var sine = gain*SinOsc.ar(freq);

  		Out.ar(outbus, sine);

  	}
  ).send;
  )


-----

The Partial Synths
==================

Create an array with 40 partial Synths, using integer multiple frequencies of 100 Hz.
Their amplitude decreases towards higher partials.
An audio bus with 40 channels receives all partial signals separately.
All synths are added to a dedicated group to ease control over the node order.

.. code:: supercollider

  ~partial_GROUP = Group(s);

  ~npart         = 40;

  ~partial_BUS   = Bus.audio(s,~npart);

  (
  ~partials = Array.fill(40,
  { arg i;
    Synth(\spatial_additive, [\outbus,~partial_BUS.index+i, \freq, 100*(i+1),\amp, 1/(1+i*~npart*0.1)],~partial_GROUP)
  });
  )

  s.scope(16,~partial_BUS.index);


-----

The Encoder SynthDef
====================

A simple encoder SynthDef with dynamic input bus and the control
parameters azimuth and elevation.

.. code:: supercollider

  ~ambi_BUS      = Bus.audio(s,16);

  (
  SynthDef(\encoder,
  	{
  		|inbus=0, azim=0, elev=0|

  		Out.ar(~ambi_BUS,HOAEncoder.ar(3,In.ar(inbus),azim,elev));
  	}
  ).send;
  )


-----

The Encoder Synths
==================

An array of 16 3rd order decoders is created in a dedicated encoder group.
This group is added after the partial group to ensure the correct order of
the synths.
Each encoder synth receives a single partial from the partial bus.
All 16 encoded signals are sent to a 16-channel audio bus.


.. code:: supercollider

  ~encoder_GROUP = Group(~partial_GROUP,addAction:'addAfter');

  (
  ~encoders = Array.fill(~npart,
  	{arg i;
  		Synth(\encoder,[\inbus,~partial_BUS.index+i,\azim, i*0.1],~encoder_GROUP)
  });
  )

  ~ambi_BUS.scope


-----

The Decoder Synth
=================

A decoder is added after the encoder group and fed with the encoded Ambisonics
signal.
The binaural output is routed to outputs 0,1 - left and right.

.. code:: supercollider

  // load binaural IRs for the decoder
  HOABinaural.loadbinauralIRs(s);

  (
  ~decoder = {
  Out.ar(0, HOABinaural.ar(3, In.ar(~ambi_BUS.index, 16)));
  }.play;
  )


  ~decoder.moveAfter(~encoder_GROUP);


-----

.. admonition:: Exercise I

  Create arrays of LFOs or other modulation signals to implement a varying
  spatial image. Use an individual control rate bus for each parameter to be controlled.

.. admonition:: Exercise II

  Modulate the timbre (relative partial amplitudes) with the modulation signals.
