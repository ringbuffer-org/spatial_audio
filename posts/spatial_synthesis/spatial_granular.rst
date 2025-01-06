.. title: Spatial Granular Synthesis
.. slug: spatial_granular_synthesis
.. date: 2022-04-16 12:00:00
.. tags:
.. category: spatial_audio:synthesis
.. link:
.. description:
.. type: text
.. has_math: true
.. priority: 4


Granular synthesis - introduced in detail in the `Sound Synthesis Introduction </sound_synthesis_introduction/Processed_Recording/granular-introduction/>`_ -
is particularly well suited for extensions in the spatial domain.
Each grain can be assigned an individual position, thus creating spatially extended textures.
Granularity also increases the localization of the single events,
this emphasizing the spread.
Hence, various approaches have been proposed in the past and present,
implemented in all common audio programming environments.


-----

Various Approaches
==================

Curtis Roads' book *Microsound* features several examples of spatial
granular synthesis (Roads, 2004).
*Scattering* - a stochastic panning of single grains -
is introduced by McLeran et al. (McLeran, 2008).
The approach is designed to work with stereo and 2D loudspeaker setups.
The *BMSwarmGranulator* (Wilson, 2008) uses the Boids algorithm for spatial granular
sound textures.
Designed for the *BEAST*, the approach aims at a 'diffuse but localized sound', rather
then individually perceivable grains.


-----

Crowd Noise Synthesis
=====================

A project at TU Berlin aimed at the parametric synthesis of crown noise,
more precisely the indistinct chatter (babbling) of large groups of people (Grimaldi, 2017).
The project is best described on the corresponding paper or the
`master thesis <https://www.atiam.ircam.fr/Archives/Stages1516/GRIMALDI_Vincent_Rapport_Stage.pdf>`_.


-----

References
==========

.. publication_list:: ../Spatial_Audio/bibtex/spatial_sound_synthesis.bib
	   :style: unsrt
