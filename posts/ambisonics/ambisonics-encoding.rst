.. title: HOA Encoding
.. slug: ambisonics-encoding
.. date: 2025-08-16 14:00
.. tags:
.. category: spatial_audio:ambisonics
.. link:
.. description:
.. type: text
.. priority: 4
.. has_math: true



This page shows how a monophonic audio signal is rendered to Ambisonics by providing 
angular direction. This procedure is the standard approach for creating virtual sound sources
in object-based spatialisation.
This example assumes a plane-wave (far-field) source model.
-----

Some Conventions
================


- Cartesian coordinates: 
   * :math:`x=\text{front->back}`
   * :math:`y=\text{left->right}`
   * :math:`z=\text{up->down}`

- Angles: 
   * azimuth :math:`\varphi \in (-\pi, \pi]` (CCW from +x toward +y),
   * elevation :math:`\theta \in [-\pi/2, \pi/2]` (up from horizontal plane).

- Normalisation/order: 
   * AmbiX (ACN channel order, SN3D normalisation), unless noted.
   * ACN index :math:`n=\ell(\ell+1)+m`. 
   * For FOA (order :math:`\ell=1`), the mapping is :math:`[n]=[0,1,2,3] \leftrightarrow [W,Y,Z,X]`.


-----

First-Order Ambisonics for a Single Point Source
================================================

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

   \begin{aligned}
   Y_0^0(\theta,\varphi) &= 1,\\
   Y_1^{1}(\theta,\varphi) &= \cos\theta\,\cos\varphi,\\
   Y_1^{-1}(\theta,\varphi) &= \cos\theta\,\sin\varphi,\\
   Y_1^{0}(\theta,\varphi) &= \sin\theta.
   \end{aligned}
   

Thus, explicitly:

.. math::

   \begin{aligned}
   W(t) &= s(t),\\
   X(t) &= s(t)\,\cos\theta\,\cos\varphi,\\
   Y(t) &= s(t)\,\cos\theta\,\sin\varphi,\\
   Z(t) &= s(t)\,\sin\theta.
   \end{aligned}
   


-----

FOA — Multiple Point Sources (Object-Based)
===========================================

For :math:`N` sources :math:`s_i(t)` at :math:`(\varphi_i,\theta_i)`, FOA channels are a linear sum:

.. math::

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
   


-----

Higher-Order Ambisonics (General Order :math:`L`)
=================================================

Let :math:`Y_{\ell}^{m}(\theta,\varphi)` be the real SN3D spherical harmonics
with :math:`\ell=0..L` and :math:`m=-\ell..\ell`. For a single source:

.. math::

   a_{\ell m}(t) = s(t)\,Y_{\ell}^{m}(\theta,\varphi),\qquad
   \ell=0..L,\; m=-\ell..\ell.
   

For :math:`N` sources:

.. math::

   a_{\ell m}(t) =
   \sum_{i=1}^{N} s_i(t)\,Y_{\ell}^{m}\!\bigl(\theta_i,\varphi_i\bigr).
   


-----

Real SN3D Spherical Harmonics (Definition)
==========================================

With associated Legendre functions :math:`P_\ell^m(\cdot)` and SN3D factor
:math:`N_{\ell m}=\sqrt{\dfrac{(2-\delta_{m0})(\ell-m)!}{(\ell+m)!}}`:

.. math::

   Y_\ell^{m}(\theta,\varphi)=
   \begin{cases}
   N_{\ell 0}\,P_\ell(\sin\theta), & m=0,\\[6pt]
   N_{\ell m}\,P_\ell^{m}(\sin\theta)\,\sqrt{2}\,\cos(m\varphi), & m>0,\\[6pt]
   N_{\ell |m|}\,P_\ell^{|m|}(\sin\theta)\,\sqrt{2}\,\sin(|m|\varphi), & m<0.
   \end{cases}
   
 
 

----

References
----------

.. publication_list:: ../Spatial_Audio/bibtex/ambisonics-theory.bib
	   :style: unsrt
