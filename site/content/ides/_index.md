---
title: Integrated Development Environments
linktitle: IDEs
weight: 80
tags: ["install", "shell", "interactive", "batch", "exec", "X11", "xserver", "sock", "socket", "play-with-docker", "package", "release"]
---

Combined with a [GUI](http://en.wikipedia.org/wiki/Graphical_user_interface)-based [waveform viewer](https://en.wikipedia.org/wiki/Waveform_viewer) and a good text editor, GHDL is a very powerful tool for writing, testing and simulating your code. Existing solutions, such as example configurations or useful plugins for well-known editors are summarized here. On top of that, it is the hub for on-going efforts to offer a ready-to-use, free (libre), multiplatform, lightweight and customizable framework in order to let users create their own (standalone) work environment.

## External resource lists

There are some other sites that try to list multiple VHDL-related resources. We try not to duplicate content, in order to make it easier for the user. Therefore, you should check these references if you don't find the content you are looking for here:

- [Universität Hamburg | VHDL-Tools](https://tams.informatik.uni-hamburg.de/vhdl/index.php?content=07-tools)
- [FPGALibre](http://fpgalibre.sourceforge.net/ingles.html)
- [paebbels.github.io](https://paebbels.github.io/)

## Standalone IDEs

- [sf:umhdl](https://sourceforge.net/projects/umhdl/), *an educational Integrated Development Environment (IDE) intended for learning digital designing with programmable logic devices using Hardware Description Languages (HDL) through simulation. (...) acts as a front-end that allows writing code (with syntax highlighting), invokes an external VHDL compiler and simulator (such as GHDL), and displays the result of the simulation graphically as waveforms (invoking to GTKWave)*. [GPLv3] [last updated 2016-10-18]
- [sf:ivi](https://sourceforge.net/projects/ivi/), *a graphical, interactive user-interface to various Open-Source HDL simulators. IVI is transitioning to using the Eclipse application framework.* [GPLv2] [last updated 2013-06-04]
- [Eclipse Verilog editor](https://sourceforge.net/projects/veditor/), * a plugin for the Eclipse IDE. It provides Verilog(IEEE-1364) and VHDL language specific code viewer, contents outline, code assist etc*. [GPLv2] [last updated 2017-01-31]

## Web-based IDEs

## ELIDE

[gh:hacdias/filemanager](https://github.com/hacdias/filemanager) is a single 5.5MB (zipped, 17MB after extraction) binary written in golang (backend); and [Vue.js](https://vuejs.org/) with [gh:codemirror/CodeMirror](https://github.com/codemirror/CodeMirror/) (frontend). It allows to explore, edit, move... files and folders from the browser. It can optionally handle authorization. Because it fits all of the requirements it is used as a base for the customizable framework. See [gh:1138-4EB/elide/wiki/IDE-in-browser](https://github.com/1138-4EB/elide/wiki/IDE-in-browser).

Missing features:

- Frontend:
  - dirtree
  - right-button/context menu (openbox alike)
  - Wavedrom (extended, i.e., interactive vertical/horizontal scroll, zoom, select, cursor, measure, etc...)
  - (real-time) diagram generation
  - multiwindow/multiscreen support?
- Backend
  - task handlers / ghdl runner
  - vcd/ghw to wavedrom converter and/or SVG generator (replacement for wavedrom)
  - diagram generator: file hierarchy, black-box structure...

You can try the official (vanilla) either natively or inside a docker container. The following command will serve the folder it is executed from:

```
$(command -v winpty) docker run --rm -itv /$(pwd):/srv -p 127.0.0.1:2000:80 hacdias/filemanager -p 80 --no-auth
```
