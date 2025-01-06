.. title: Understanding Ambisonics Signals
.. slug: understanding-ambisonics-signals
.. date: 2022-04-28 14:00
.. tags:
.. category: spatial_audio:ambisonics
.. link:
.. description:
.. type: text
.. priority: 1
.. has_math: true



Spherical Harmonics
===================

Ambisonics is based on a decomposition of a sound field into *spherical harmonics*.
These spherical harmonics encode the sound field according to different axes,
respectively angles of incidence.
The number of Ambisonics channels $N$ is equal to the number of spherical harmonics.
It can be calculated for a given order $M$ with the following formula:

.. math::

  N = (M+1)^2

Figure 1 shows the first 16 spherical harmonics. The first row ($N=1$) is the omnidirectional sound pressure
for the order $M=0$.
Rows 1-2 together represent the $N=4$ spherical harmonics of the first order Ambisonics signal,
rows 1-3 correspond to $M=2$, respectively $N=9$ and
rows 1-4 to the third order Ambisonics signal with $N=16$ spherical harmonics.
First order ambisonics is sufficient to encode a threedimensional sound field.
The higher the Ambisonics order, the more precise the directional encoding.


.. figure:: /images/spatial/ambisonics/third-order-ambisonics.png
  :width: 600px
  :figwidth: 100%
  :align: center

  Fig. 1: Spherical harmonics up to order 3 [#]_.


.. [#] https://commons.wikimedia.org/wiki/Category:Spherical_harmonics#/media/File:Spherical_Harmonics_deg3.png

-----


Ambisonic Formats
=================

An Ambisonics B Format file or signal carries all $N$ spherical harmonics.
Figure 2 shows a first order B Format signal.

.. figure:: /images/spatial/ambisonics/first-order-signal.png
  :width: 100%
  :figwidth: 100%
  :align: center

  Fig. 2: Four channels of a first order Ambisonics signal.


There are different conventions for the sequence of the individual signals,
as well as for the normalization. 

-----


References
----------

.. publication_list:: ../Spatial_Audio/bibtex/ambisonics-theory.bib
	   :style: unsrt
