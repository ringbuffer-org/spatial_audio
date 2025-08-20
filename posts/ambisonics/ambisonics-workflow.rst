.. title: The Ambisonics Workflow
.. slug: ambisonics-workflow
.. date: 2022-04-30 14:00
.. tags:
.. category: spatial_audio:ambisonics
.. link:
.. description:
.. type: text
.. priority: 1
.. has_math: true

Basic Workflow
==============

A basic Ambisonics production workflow can be split into three stages, as shown in Figure 1.
The advantage of this procedure ist that the production is independent of the output format,
since the intermediate format is in the Ambisonics domain.
A sound field produced in this way can subsequently be rendered or decoded to any desired
loudspeaker setup or headphones.

-----

.. figure:: /images/spatial/ambisonics/ambi-workflow.png
  :width: 50%
  :figwidth: 100%
  :align: center

  Figure 1: Basic Ambisonics production workflow.


-----

Stages
======

1: Encoding Stage
-----------------

In the encoding stage, Ambisonics signals are generated. This can happen via recording with an
Ambisonics microphone or through encoding of mono sources with individual angles (azimuth, elevation).
A plain Ambisonics encoding does not include distance information - altough it can be added through attenuation.
All encoded signals have the same amount of $N$ ambisonics channels.



2: Summation Stage
------------------

All individual Ambisonics signals can be summed up to create one scene,
respectively one sound field.


3: Decoding Stage
-----------------

In the decoding stage, individual output signals can be calculated. This requires either
head-related transfer functions or loudspeaker coordinates.

------

*More advanced workflows may feaure additional stages for manipulating encoded Ambisonics signals,
inlcuding directional filtering or rotation of the audio scene.*

------

References
==========

.. publication_list:: ../Spatial_Audio/bibtex/ambisonics-theory.bib
	   :style: unsrt
