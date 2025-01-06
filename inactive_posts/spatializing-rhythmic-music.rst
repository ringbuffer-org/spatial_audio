.. title: Spatializing Rhythmic Music
.. slug: spatializing-rhythmic-music
.. date: 2021-06-07 14:00
.. tags:
.. category: _nsmi:spatial
.. link:
.. description:
.. type: text
.. priority: 3
.. author: Henrik von Coler


Spatialization of rhythmic music is quite different from working with experimental content.
Movements need to be synced to the rhythmic rhythmic structure.
For techno and related genres it is even more restrictive, since movements and signal
alteration through rendering algorithms must not degrade the bass structure and the transients.
The music must not lose its energy and spatial effects have to be used carefully.
Kick and bass are usually not spatialized at all, making it as tight as possible.

----

Garbicz 2019
============

Setup
-----

.. figure:: /images/garbicz-speakers.jpg
   :width: 600

   *Res9 during setup.*

.. figure:: /images/garbicz-crowd.jpg
  :width: 600

  *Crowd.*

A surround system with a diameter of ~22 m, featuring 6 *Funktion One Resolution 2* and 4 *Res9* (and many subs), was installed at Garbicz Festival 2019.
Ambisonics rendering was performed with IRCAM's PanoramixApp.


-----

Software
--------

PD was used to perform beat-tracking and real-time feature extraction,
as well as for generating synced source movements. An Ableton Push could be used with the PD patches for controlling the source movements
with a simple, intuitive interface. The patch allows the spatialization of multiple mono sources for live acts
and the treatment of stereo sources through MS processing for DJs.


.. thumbnail:: /images/garbicz-pd.png

   *PD patch for movement generation and control (click to enlarge).*


----


Movement Demo
=============

This video shows beat-aligned source movements and free rotations for a multi track spatialization.
It is created with GEM (Pure Data), which is also used for visualizing the source movements during operation of the system.
This example is only a mockup - the audio is not rendered from these movements but the standard stereo mix is used.

.. raw:: html

     <video width="800" controls src="/videos/pd-rave.mp4"></video>

*Demonstration of source movements with 'Combination 03' by JPLS*
