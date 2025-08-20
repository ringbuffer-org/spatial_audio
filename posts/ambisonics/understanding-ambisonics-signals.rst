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


There are different conventions for the sequence of the individual signals,
as well as for the normalization. 


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

**Gain mapping**

.. math::

   W_{\text{AmbiX}} = \sqrt{2}\,W_{\text{FuMa}},\qquad
   X_{\text{AmbiX}} = X_{\text{FuMa}},\qquad
   Y_{\text{AmbiX}} = Y_{\text{FuMa}},\qquad
   Z_{\text{AmbiX}} = Z_{\text{FuMa}}.

**Channel order**

- FuMa order: :code:`[W, X, Y, Z]`
- AmbiX (ACN/SN3D) order: :code:`[W, Y, Z, X]`  (i.e., ACN indices :code:`[0,1,2,3] -> [W,Y,Z,X]`)



-----


FOA / HOA Encoding from Angular Direction
=========================================

**Conventions**

- Coordinates: :math:`x=\text{front}`, :math:`y=\text{left}`, :math:`z=\text{up}`.
- Angles: azimuth :math:`\varphi \in (-\pi, \pi]` (CCW from +x toward +y),
  elevation :math:`\theta \in [-\pi/2, \pi/2]` (up from horizontal plane).
- Normalisation/order: **AmbiX** (ACN channel order, SN3D normalisation), unless noted.
  ACN index :math:`n=\ell(\ell+1)+m`. For FOA (order :math:`\ell=1`), the mapping is
  :math:`[n]=[0,1,2,3] \leftrightarrow [W,Y,Z,X]`.

.. note::
   If you need legacy **FuMa** B-format instead, the channel order is :math:`[W,X,Y,Z]`
   and :math:`W` carries a :math:`1/\sqrt{2}` scaling factor relative to AmbiX/SN3D.

First-Order Ambisonics (FOA, B-format) — Single Point Source
------------------------------------------------------------

A monophonic source :math:`s(t)` at direction :math:`(\varphi,\theta)` encodes to the FOA vector
:math:`\mathbf a(t)=\begin{bmatrix}W&Y&Z&X\end{bmatrix}^{\mathsf T}` (AmbiX ordering) as:

.. math::

   \begin{aligned}
   W(t) &= s(t)\,Y_0^0(\theta,\varphi),\\
   Y(t) &= s(t)\,Y_1^{-1}(\theta,\varphi),\\
   Z(t) &= s(t)\,Y_1^{0}(\theta,\varphi),\\
   X(t) &= s(t)\,Y_1^{1}(\theta,\varphi),
   \end{aligned}

with the **real SN3D** first-order spherical harmonics:

.. math::

   \boxed{
   \begin{aligned}
   Y_0^0(\theta,\varphi) &= 1,\\
   Y_1^{1}(\theta,\varphi) &= \cos\theta\,\cos\varphi,\\
   Y_1^{-1}(\theta,\varphi) &= \cos\theta\,\sin\varphi,\\
   Y_1^{0}(\theta,\varphi) &= \sin\theta.
   \end{aligned}
   }

Thus, explicitly:

.. math::

   \boxed{
   \begin{aligned}
   W(t) &= s(t),\\
   X(t) &= s(t)\,\cos\theta\,\cos\varphi,\\
   Y(t) &= s(t)\,\cos\theta\,\sin\varphi,\\
   Z(t) &= s(t)\,\sin\theta.
   \end{aligned}
   }

FuMa (legacy) mapping (if required):

.. math::

   \boxed{
   \begin{aligned}
   W_{\mathrm{FuMa}}(t) &= \tfrac{1}{\sqrt{2}}\,s(t),\\
   X_{\mathrm{FuMa}}(t) &= s(t)\,\cos\theta\,\cos\varphi,\\
   Y_{\mathrm{FuMa}}(t) &= s(t)\,\cos\theta\,\sin\varphi,\\
   Z_{\mathrm{FuMa}}(t) &= s(t)\,\sin\theta.
   \end{aligned}
   }

FOA — Multiple Point Sources (Object-Based)
-------------------------------------------

For :math:`N` sources :math:`s_i(t)` at :math:`(\varphi_i,\theta_i)`, FOA channels are a linear sum:

.. math::

   \boxed{
   \mathbf a(t) =
   \sum_{i=1}^{N}
   s_i(t)\,
   \begin{bmatrix}
   1\\[2pt]
   \cos\theta_i\,\sin\varphi_i\\[2pt]
   \sin\theta_i\\[2pt]
   \cos\theta_i\,\cos\varphi_i
   \end{bmatrix}
   \quad \text{(AmbiX/ACN order } [W,Y,Z,X]\text{).}
   }

Higher-Order Ambisonics (General Order :math:`L`)
-------------------------------------------------

Let :math:`Y_{\ell}^{m}(\theta,\varphi)` be the real SN3D spherical harmonics
with :math:`\ell=0..L` and :math:`m=-\ell..\ell`. For a single source:

.. math::

   \boxed{
   a_{\ell m}(t) = s(t)\,Y_{\ell}^{m}(\theta,\varphi),\qquad
   \ell=0..L,\; m=-\ell..\ell.
   }

For :math:`N` sources:

.. math::

   \boxed{
   a_{\ell m}(t) =
   \sum_{i=1}^{N} s_i(t)\,Y_{\ell}^{m}\!\bigl(\theta_i,\varphi_i\bigr).
   }

Real SN3D Spherical Harmonics (Definition)
------------------------------------------

With associated Legendre functions :math:`P_\ell^m(\cdot)` and SN3D factor
:math:`N_{\ell m}=\sqrt{\dfrac{(2-\delta_{m0})(\ell-m)!}{(\ell+m)!}}`:

.. math::

   \boxed{
   Y_\ell^{m}(\theta,\varphi)=
   \begin{cases}
   N_{\ell 0}\,P_\ell(\sin\theta), & m=0,\\[6pt]
   N_{\ell m}\,P_\ell^{m}(\sin\theta)\,\sqrt{2}\,\cos(m\varphi), & m>0,\\[6pt]
   N_{\ell |m|}\,P_\ell^{|m|}(\sin\theta)\,\sqrt{2}\,\sin(|m|\varphi), & m<0.
   \end{cases}
   }

Notes
-----

- Plane-wave (far-field) model assumed; for finite distance, multiply by a radial factor
  :math:`R_\ell(kr)` (e.g., NFC-HOA).
- For head-tracked playback, rotate the Ambisonic channel vector per order using the
  spherical-harmonic rotation matrices :math:`\mathbf D_\ell(\cdot)` before rendering.


----

References
----------

.. publication_list:: ../Spatial_Audio/bibtex/ambisonics-theory.bib
	   :style: unsrt
