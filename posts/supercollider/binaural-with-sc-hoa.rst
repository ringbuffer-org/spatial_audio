.. title: Binaural Spatialization with SC-HOA
.. slug: binaural-spatialization-with-sc-hoa
.. date: 2021-06-07 14:00
.. tags:
.. category: spatial_audio:supercollider
.. link:
.. description:
.. type: text
.. priority: 0
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
