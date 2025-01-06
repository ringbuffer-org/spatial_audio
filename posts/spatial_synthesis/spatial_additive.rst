.. title: Spatial Additive Synthesis
.. slug: spatial_additive_synthesis
.. date: 2022-04-16 12:00:00
.. tags:
.. category: spatial_audio:synthesis
.. link:
.. description:
.. type: text
.. has_math: true
.. priority: 2


Additive Synthesis and Spectral Modeling are in detail introduced in the
corresponding sections of the
`Sound Synthesis Introduction </teaching/sound-synthesis-introduction/>`_.
Since sounds are created by combining large numbers of spectral components, such as harmonics
or noise bands, spatialization at synthesis stage is an obvious method.
Listeners can thereby be spatially enveloped by a single sound,
with spectral components being perceived from all angles.
The continuous character, however, blurs the localization.

-----

SOS
===

*Spatio-operational spectral (SOS) synthesis* (Topper, 2002) is an attempt towards a
dynamic spatial additive synthesis, implemented in MAX/MSP and RTcmix.
Partials are rotated independently within a 2D 8 channel speaker setup.
A first experiment used a varying rate circular spatial path of
the first eight partials of a square wave, as shown in Figure 1.



.. figure:: /images/spatial/spatial_synthesis/sos_1.png
  :width: 60%
  :figwidth: 100%
  :align: center

  Figure 1: First SOS experiment (Topper, 2002).


Figure 2 shows the second experiment with  one partial moving against the
others.


.. figure:: /images/spatial/spatial_synthesis/sos_2.png
	:width: 60%
	:figwidth: 100%
	:align: center

	Figure 2: Second SOS experiment (Topper, 2002).



-----

GLOOO
=====

GLOOO is a system for real-time expressive spatial synthesis with spectral
models.
A haptic interface allows the dynamic distribution of 100 spectral components,
allowing a control over the spread and position of the resulting violin sound.
The project is best documented on the corresponding websites:

- `GLOOO <http://hvc.berlin/research/glooo/>`_

- `NIME 2020 paper <http://hvc.berlin/research/nime-2020/>`_



-----

References
==========

.. publication_list:: ../Spatial_Audio/bibtex/spatial_sound_synthesis.bib
	   :style: unsrt
