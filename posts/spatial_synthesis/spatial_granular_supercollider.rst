.. title: Spatial Granular in SuperCollider
.. slug: spatial_granular_supercollider
.. date: 2022-05-23 10:00:00
.. tags:
.. category: spatial_audio:synthesis
.. link:
.. description:
.. type: text
.. has_math: true
.. priority: 5


The following example uses 16 granular synths in parallel,
each being rendered as an individual virtual sound source with
azimuth and elevation in the 3rd order Ambisonics domain.
This allows the synthesis of spatially distributed sound textures,
with the possibility of linking grain properties their spatial position.


A Granular SynthDef
===================

The granular SynthDef creates a monophonic granular stream with individual
rate, output bus and grain position.
It receives a trigger signal as argument.

.. code:: supercollider

  // a synthdef for grains
  (
  SynthDef(\spatial_grains,
  	{

  		|buffer = 0,  trigger = 0, pos = 0.25, rate = 1, outbus = 0|

  		var c      =  pos * BufDur.kr(buffer);

  		var grains =  TGrains.ar(1, trigger, buffer, rate, c+Rand(0,0.1), 0.1);

  		Out.ar(outbus, grains);

  	}
  ).send;
  )

-----



A Trigger Synth
===============

The trigger synth creates 16 individual random trigger signals, which are sent to
a 16-channel audio bus.
The density of all trigger streams can be controlled via an argument.

.. code:: supercollider

  ~trigger_BUS = Bus.control(s,16);
  ~trigger     = {|density=1| Out.kr(~trigger_BUS.index,Dust.ar(Array.series(16, density, 1)))}.play;
  ~trigger_BUS.scope;



-----

Read a Wavefile to Buffer
=========================

Load a buffer of your choice and plot it for confirmation.
Suitable mono wavfiles can be found in the `Download Section <http://ringbuffer.org/download/audio/>`_.

.. code:: supercollider

  ~buffer = Buffer.read(s,"/absolute-path-to/wavfile");

  ~buffer.plot


-----

Create 16 Granular Synths
=========================

An array of 16 granular Synths creates 16 individual grain streams, which are sent to
a 16-channel audio bus.
All Synths are kept in a dedicated group to ease the control over the signal flow.


.. code:: supercollider

  ~grain_GROUP = Group(s);

  ~grain_BUS   = Bus.audio(s,16);

  ~grainers = Array.fill(16, {arg i; Synth(\spatial_grains,[\buffer,~buffer, \outbus,~grain_BUS.index+i],~grain_GROUP)});
  ~grainers.do({arg e,i; e.map(\trigger,~trigger_BUS.index+i);});

  ~grain_BUS.scope;


-----

An Encoder SynthDef
===================

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
This group is added after the granular group to ensure the correct order of
the synths.
All 16 encoded signals are sent to a 16-channel audio bus.

.. code:: supercollider

  ~encoder_GROUP = Group(~grain_GROUP,addAction:'addAfter');


  (
  ~encoders = Array.fill(16,
  	{arg i;
  		Synth(\encoder,[\inbus,~grain_BUS.index+i,\azim, i*0.1],~encoder_GROUP)
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

.. admonition:: Exercise

  Use the mouse for a linked control of spatial and granular parameters.
