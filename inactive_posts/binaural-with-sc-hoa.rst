.. title: Binaural Spatialization with SC-HOA
.. slug: binaural-spatialization-with-sc-hoa
.. date: 2021-06-07 14:00
.. tags:
.. category: _nsmi:spatial
.. link:
.. description:
.. type: text
.. priority: 5
.. has_math: true


The SC-HOA library by Florian Grond is a feature-rich toolbox for working with Ambisonics and binaural synthesis in SuperCollider. Once installed, it is well documented inside the SC help files. Additional information and install instructions are part of the `Git repository <https://github.com/florian-grond/SC-HOA>`_. This section gives a brief introduction into the solution used for the SPRAWL server.

Installing SC-HOA
=================

The SC-HOA library is shipped as a so called *Quark* and it can be installed from inside SC. Besides a GUI-based way, a single command is enough to install the complete library with all objects and classes in the system's directories:

.. code-block:: cpp

  Quarks.install("https://github.com/florian-grond/SC-HOA")

----

Make sure to reboot the interpreter after installing the Quark.
The external classes need to be compiled.

To find out where SC has installed your external, run:

  .. code-block:: console

      Platform.userExtensionDir



-----


Encoding a 1st Order Source
===========================

The Ambisonics Bus
------------------

First thing to create is an audio rate bus for the encoded Ambisonics signal. The bus size depends on the Ambisonics order ``M``, following the formula :math:`N = (M+1)^2`. For simplicity, this example uses first order:

.. code-block:: cpp

  s.boot;

  // create the Ambisonics mix bus

  ~order     = 1;
  ~nHOA      = (pow(~order+1,2)).asInteger;
  ~ambi_BUS  = Bus.audio(s,~nHOA);

-----

The channels of this bus correspond to the spherical harmonics. They encode the overall pressure and the distribution along the three basic dimensions:


.. figure:: /images/nsmi/first-order-harmonics.png
   :width: 600



------

The Encoder
-----------

The SC-HOA library includes different encoders. This example uses the ``HOASphericalHarmonics`` class.
This simple encoder can set the angles of incidence (azimuth, elevation) in spherical coordinates. Angles are controlled in radians:

- azimuth=0 with elevation=0 is a signal straight ahead
- azimuth=-pi/2 is hard left
- azimuth=pi/2 is hard right
- azimuth=pi is in the back.
- elevation=pi/2 is on the top
- elevation=-pi/2 is on the bottom

This example  uses a sawtooth signal as mono input and calculates the four Ambisonics channels.

.. code-block:: cpp

  ~encoder_A = {arg azim=0, elev=0;
  	Out.ar(~ambi_BUS,HOASphericalHarmonics.coefN3D(~order,azim,elev)*Saw.ar(140));
  	}.play;

------

The Ambisonics bus can be monitored and the angles of the source can be set, manually:

.. code-block:: cpp

  ~ambi_BUS.scope;

  // set parameters
  ~encoder_A.set(\azim,0)
  ~encoder_A.set(\elev,0)


.. admonition:: Exercise

  Change the angles of the encoder and check whether the Ambisonics buses behave as expected.
  (Use multiples of pi/2.)

-----

The Decoder
-----------

The SC-HOA library features default binaural impulse responses, which need to be loaded first:

.. code-block:: cpp

  // load binaural IRs for the decoder
  HOABinaural.loadbinauralIRs(s);


------

Afterwards, a first order ``HOABinaural`` decoder is fed with the encoded Ambisonics signal. It needs to be placed after the encoder node to get an audible output to the left and right channels. This output is the actual binaural signal for headphone use.

.. code-block:: cpp

  ~decoder = {HOABinaural.ar(~order, In.ar(~ambi_BUS,~nHOA))}.play;
  ~decoder.moveAfter(~encoder_A);

-----


.. admonition:: Exercise

    Listen to the decoded signal and change the angles.


------


Panning Multiple Sources
========================

Working with multiple sources requires a dedicated encoder for each source. All encoded signals are subsequently routed to the same Ambisonics bus and a single decoder is used to create the binaural signal. The angles of all sources can be set, individually.


.. code-block:: cpp

  ~encoder_B = {arg azim=0, elev=0;
	   Out.ar(~ambi_BUS,HOASphericalHarmonics.coefN3D(~order,azim,elev)*Saw.ar(277))}.play;

  ~encoder_B.set(\azim,pi/4)
  ~encoder_B.set(\elev,1)



------


Exercises
=========

.. admonition:: Exercise I

  Use the mouse for a continuous control of a source's angles.


.. admonition:: Exercise II

  Add a control for the source distance to the encoder.


.. admonition:: Exercise III

  Increase the Ambisonics order and compare the results.


.. admonition:: Exercise IV

  Use OSC messages to control the positions of multiple sources.
