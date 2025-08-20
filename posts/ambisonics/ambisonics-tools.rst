.. title: Tools for Live Ambisonics Applications
.. slug: ambisonics-tools
.. date: 2025-08-16 12:00
.. tags:
.. category: spatial_audio:ambisonics
.. link:
.. description:
.. type: text
.. priority: 5
.. has_math: true


The following tables inlcude examples for software that can be used to create real time and interactive
spatial audio systems, mostly using Ambisonics, but also with other rendering approaches,
All examples are able to recieve control data, usually via OSC, to allow object-based spatialisation.

-----

Free & Cross-Platform (all OS)
------------------------------

This is the preferred selection of **free/ open source software**.
All solutions in this catecory run on all major platforms.

.. raw:: html

  <!-- Spatial Audio Tools: HTML tables for Nikola -->

  <table>
    <thead>
      <tr>
        <th>Tool</th>
        <th>Platforms</th>
        <th>License</th>
        <th>Why use this solution?</th>
        <th>Link</th>
      </tr>
    </thead>
    <tbody>

      <tr>
        <td>Reaper + IEM Plug‑in Suite</td>
        <td>Windows / macOS / Linux (Reaper via WINE on Linux)</td>
        <td>Reaper: low‑cost (unlimited evaluation); IEM: Free, Open Source</td>
        <td>Complete Ambisonics toolchain (encode/rotate/decode); fast to learn; robust for live; widely used; allows automation in DAW trajectories.</td>
        <td><a href="https://plugins.iem.at/">IEM Plugins</a></td>
      </tr>

      <tr>
        <td>SuperCollider + ATK / SC-HOA</td>
        <td>Windows / macOS / Linux</td>
        <td>Free, Open Source</td>
        <td>Live coding; flexible real-time control; strong research/edu community; scalable for large projects.</td>
        <td><a href="http://www.ambisonictoolkit.net/">Ambisonic Toolkit</a></td>
      </tr>

      <tr>
        <td>Pure Data (with HOA library)</td>
        <td>Windows / macOS / Linux</td>
        <td>Free, Open Source</td>
        <td>Patch-based; lightweight; great for teaching signal flow and rapid prototyping; Ambisonics externals available.</td>
        <td><a href="https://github.com/pd-ambisonics">pd-ambisonics</a></td>
      </tr>

      <tr>
        <td>SoundScape Renderer (SSR)</td>
        <td>Windows / macOS / Linux</td>
        <td>Free, Open Source</td>
        <td> Supports a wide range of formats (HOA, VBAP, WFS); offers OSC and GUI control; helpful visualization of audio scenes.</td>
        <td><a href="https://spatialaudio.net/ssr/">SSR</a></td>
      </tr>

      <tr>
        <td>SPARTA Plug‑ins</td>
        <td>Windows / macOS / Linux</td>
        <td>Free, Open Source</td>
        <td>Ambisonics, VBAP, beamforming; complements IEM.</td>
        <td><a href="https://research.spa.aalto.fi/projects/sparta_vsts/">SPARTA</a></td>
      </tr>

      </tbody>
  </table>


------


Creative Standards
------------------

While not free or open source, the following table contains the standards used in (experimental) music and media art.
Solutions based on Max and Ableton Live benefit from the huge popularity of these platforms.
Support on Linux systems is not provided. The code is colsed source.

.. raw:: html

  <table>
    <thead>
      <tr>
        <th>Tool</th>
        <th>Platforms</th>
        <th>License</th>
        <th>Why use this solution?</th>
        <th>Link</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>IRCAM Spat~ (Max)</td>
        <td>Windows / macOS (Max required)</td>
        <td>Commercial</td>
        <td>Classic real‑time spatialisation in Max; widely used in electroacoustic works; OSC/MIDI.</td>
        <td><a href="https://forumnet.ircam.fr/product/spat-en/">Spat~</a></td>
      </tr>
      <tr>
        <td>SPAT Revolution (FLUX + IRCAM)</td>
        <td>Windows / macOS</td>
        <td>Commercial (edu available)</td>
        <td>De‑facto standard for creative spatial audio; Ambisonics/VBAP/binaural; powerful routing; OSC.</td>
        <td><a href="https://www.flux.audio/project/spat-revolution/">SPAT Revolution</a></td>
      </tr>

      <tr>
        <td>Ableton Live + Envelop for Live (E4L)</td>
        <td>Windows / macOS</td>
        <td>Free (E4L), Ableton Live + Max for Live required</td>
        <td>Spatial audio toolkit inside Ableton Live. Includes Ambisonics encoder/decoder, spatial FX, and binaural render. Ideal for electronic music and live performance workflows. Integrates with VR/immersive setups; can export Ambisonics mixes for YouTube 360 or external renderers.</td>
        <td><a href="https://www.envelop.us/tools">Envelop for Live</a></td>
      </tr>

      <tr>
        <td>Zirkonium MK3</td>
        <td>macOS (Linux experimental)</td>
        <td>Free (closed source)</td>
        <td>Trajectory‑based spatialisation; friendly for performances; OSC/MIDI.</td>
        <td><a href="https://zkm.de/en/zirkonium">Zirkonium</a></td>
      </tr>
    </tbody>
  </table>

-----


Proprietary / Commercial (Industry Standards)
---------------------------------------------

Tools in this category are industry standards in content creation and music production.
While not free or open source, they are widely used to create consumer-ready content, 
inlcuding Apple 3D and cinema formats.

.. raw:: html

  <table>
    <thead>
      <tr>
        <th>Tool</th>
        <th>Platforms</th>
        <th>License</th>
        <th>Why use this solution?</th>
        <th>Link</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Dolby Atmos (Renderer, plugins) </td>
        <td>Windows / macOS</td>
        <td>Commercial (subscription/bundle)</td>
        <td>Film/game/streaming standard; binaural + speaker workflows; deep DAW integration; emerging home entertainment standard; Dolby Atmos = Apple Music 3D, Amazon Music & TIDAL</td>
        <td><a href="https://professional.dolby.com/music/dolby-atmos-music/">Dolby Atmos</a></td>
      </tr>
      <tr>
        <td>Nuendo (Steinberg)</td>
        <td>Windows / macOS</td>
        <td>Commercial DAW</td>
        <td>Built‑in Ambisonics/immersive tools; post/game pipelines; integrates Atmos.</td>
        <td><a href="https://www.steinberg.net/nuendo/">Nuendo</a></td>
      </tr>
      <tr>
        <td>Pro Tools Ultimate</td>
        <td>Windows / macOS</td>
        <td>Commercial DAW</td>
        <td>Post‑production standard; Atmos/immersive tooling; widely adopted in studios.</td>
        <td><a href="https://www.avid.com/pro-tools">Pro Tools</a></td>
      </tr>
    </tbody>
  </table>

  <!-- Minimal optional styling (safe for most themes); remove if you prefer theme defaults -->
  <style>
    table { border-collapse: collapse; width: 100%; margin: 0 0 1.5rem 0; }
    th, td { border: 1px solid #ddd; padding: 0.5rem; vertical-align: top; }
    th { background: rgba(0,0,0,0.04); text-align: left; }
    tbody tr:nth-child(even) { background: rgba(0,0,0,0.02); }
  </style>
