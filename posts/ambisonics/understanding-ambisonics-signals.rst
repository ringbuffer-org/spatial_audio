.. title: Understanding Ambisonics
.. slug: understanding-ambisonics
.. date: 2022-04-28 14:00
.. tags:
.. category: spatial_audio:ambisonics
.. link:
.. description:
.. type: text
.. priority: 2
.. has_math: true




A vs B Format
=============

**A-format** refers to the raw microphone capsule signals (e.g., tetrahedral mic outputs) when capturing 3D sound fields.
This format is mic-specific and not interchangeable. To further process it, it usually needs to be converted to B-format.
A→B conversion matrices are microphone-model-specific, considering capsule geometry and calibration.
Microphone vendors need to supply the decoder.

.. figure:: /images/spatial/ambisonics/ambisonics_capsule.png
  :width: 30%
  :figwidth: 100%
  :align: center

**B-format** is made up of the spherical-harmonic components of the sound field.
This is the standard Ambisonics format with defined channel order and normalization.
B-format is portable and can be reproduced on any rendering system (loudspeaker setups, binaural), following standardized decoding algorithms.

----




Spherical Harmonics
===================

Basic Ambisonics does not define a sound filed through positions, but through angles of incedence.
Ambisonics is based on a decomposition of a sound field into *spherical harmonics* and dates back to Gerzon's theory of Peryphony (Gerzon, 1973).
These spherical harmonics encode a sound field into to different axes,
The number of Ambisonics channels $N$ is equal to the number of spherical harmonics.
It can be calculated for a given order $M$ with the following formula:
 
.. math::

  N = (M+1)^2

Figure 1 shows the first 16 spherical harmonics. The first row ($N=1$) is the omnidirectional sound pressure
for the order $M=0$.

- Rows 1-2 together represent the $N=4$ spherical harmonics of the first order Ambisonics signal.
- Rows 1-3 correspond to $M=2$, respectively $N=9$.
- Rows 1-4 to the third order Ambisonics signal with $N=16$ spherical harmonics.

First order ambisonics is sufficient to encode a threedimensional sound field.
The higher the Ambisonics order, the more precise the directional encoding and the better the localization of virtual sound sources.


.. figure:: /images/spatial/ambisonics/third-order-ambisonics.png
  :width: 600px
  :figwidth: 100%
  :align: center

  Fig. 1: Spherical harmonics up to order 3 [#]_.


.. [#] https://commons.wikimedia.org/wiki/Category:Spherical_harmonics#/media/File:Spherical_Harmonics_deg3.png

-----


Common B-format Conventions
===========================

B-format conventions define the relation between Ambisonic channel order and spherical harmonics.
There are different conventions for the sequence of the individual signals,
as well as for the normalization. 

.. raw:: html

  <table>
    <caption>Ambisonics conventions (Common B-format variants)</caption>
    <thead>
      <tr>
        <th>Convention</th>
        <th>Type</th>
        <th>Channel order (1st&nbsp;order)</th>
        <th>Normalization</th>
        <th>Notes / Where used</th>
      </tr>
    </thead>
    <tbody>
     
      <tr>
        <td><strong>FuMa</strong> (Furse–Malham)</td>
        <td>B-format (FOA)</td>
        <td><code>W, X, Y, Z</code></td>
        <td>FuMa (“maxN” style; <code>W</code> is scaled by <code>1/√2</code>)</td>
        <td>Legacy 1st-order B-format used in older DAWs and toolchains; awkward for higher orders (≥2).</td>
      </tr>
      <tr>
        <td><strong>AmbiX</strong></td>
        <td>B-format (FOA/HOA)</td>
        <td><code>ACN</code> order → <code>[0:W, 1:Y, 2:Z, 3:X]</code></td>
        <td><strong>SN3D</strong></td>
        <td>De-facto modern production standard (Reaper+AmbiX, many VR/AR SDKs, YouTube VR). Portable and HOA-friendly.</td>
      </tr>
      <tr>
        <td><strong>ACN/N3D</strong></td>
        <td>B-format (FOA/HOA)</td>
        <td><code>ACN</code> order → <code>[0:W, 1:Y, 2:Z, 3:X]</code></td>
        <td><strong>N3D</strong> (orthonormal)</td>
        <td>Common in research and HOA libraries; convenient for math/analysis and per-order processing.</td>
      </tr>
    </tbody>
  </table>

  <!-- Handy mappings (not part of the table, keep if useful):
  - FuMa ↔ AmbiX (FOA):
    • Gain: W_AmbiX = √2 · W_FuMa; X,Y,Z identical.
    • Order: FuMa [W,X,Y,Z] vs. AmbiX [W,Y,Z,X].
  - SN3D ↔ N3D (any order ℓ): Yℓm|N3D = √(2ℓ+1) · Yℓm|SN3D.
  -->




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



.. figure:: /images/spatial/ambisonics/first-order-harmonics.png
  :width: 50%
  :figwidth: 100%
  :align: center

  Fig. 2: Spherical harmonics of a first order Ambisonics signal.



-----



ACN, Normalizations, and 1st-Order Mappings
===========================================

**ACN (Ambisonic Channel Numbering)**

The channel index :math:`n` is

.. math::

   n = \ell(\ell+1) + m, \qquad \ell = 0..L,\ \ m = -\ell..\ell.

For **1st order** (:math:`\ell = 0,1`), the ACN indices map to channels as

.. math::

   [\,0:\ Y_0^0 = W,\quad 1:\ Y_1^{-1} = Y,\quad 2:\ Y_1^{0} = Z,\quad 3:\ Y_1^{1} = X\,].

Normalizations
--------------

- **SN3D** (“semi-normalized”): :math:`Y_0^0 = 1`.  Widely used in production (AmbiX).
- **N3D** (orthonormal over the sphere): convenient for HOA math/analysis.
- **FuMa** (legacy): distinct scaling; notably :math:`W_{\text{FuMa}} = \tfrac{1}{\sqrt{2}}\,W_{\text{SN3D}}`.

1st-Order Mappings (FuMa ↔ AmbiX/ACN–SN3D)
-------------------------------------------



**Channel order**

- FuMa order: :code:`[W, X, Y, Z]`
- AmbiX (ACN/SN3D) order: :code:`[W, Y, Z, X]`  (i.e., ACN indices :code:`[0,1,2,3] -> [W,Y,Z,X]`)


----

References
----------

.. publication_list:: ../Spatial_Audio/bibtex/ambisonics-theory.bib
	   :style: unsrt
