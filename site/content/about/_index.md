---
title: About GHDL
weight: 100
---

## What is VHDL?

[VHDL](https://en.wikipedia.org/wiki/VHDL) is an acronym for Very High Speed Integrated Circuit ([VHSIC](https://en.wikipedia.org/wiki/VHSIC)) Hardware Description Language ([HDL](https://en.wikipedia.org/wiki/HDL)), which is a programming language used to describe a logic circuit by function, data flow behaviour, or structure.

Although VHDL was not designed for writing general purpose programs, VHDL is a programming language, and you can write any algorithm with it. If you are able to write programs, you will find in VHDL features similar to those found in procedural languages such as *C*, *Python*, or *Ada*. Indeed, VHDL derives most of its syntax and semantics from *Ada*. Knowing *Ada* is an advantage for learning VHDL (it is an advantage in general as well).

However, VHDL was not designed as a general purpose language but as an HDL. As the name implies, VHDL aims at modeling or documenting electronics systems. Due to the nature of hardware components which are always running, VHDL is a highly concurrent language, built upon an event-based timing model.

Like a program written in any other language, a VHDL program can be executed. Since VHDL is used to model designs, the term *simulation* is often used instead of *execution*, with the same meaning. At the same time, like a design written in another HDL, a set of VHDL sources can be transformed with a *synthesis tool* into a netlist, that is, a detailed gate-level implementation.

The development of VHDL started in 1983 and the standard is named [IEEE](https://www.ieee.org/) 1076. Four revisions exist: [1987](http://ieeexplore.ieee.org/document/26487/), [1993](http://ieeexplore.ieee.org/document/392561/), [2002](http://ieeexplore.ieee.org/document/1003477/) and [2008](http://ieeexplore.ieee.org/document/4772740/). The standardization is handled by the VHDL Analysis and Standardization Group ([VASG/P1076](http://www.eda-twiki.org/vasg/)).

## What is GHDL?

GHDL is a shorthand for *G Hardware Design Language* (currently, G has no meaning). It is a VHDL compiler that can execute (nearly) any VHDL program. GHDL is not a synthesis tool: you cannot create a netlist with GHDL (yet).

Unlike some other simulators, GHDL is a compiler: it directly translates a VHDL file to machine code, without using an intermediary language such as *C* or *C++*. Therefore, the compiled code should be faster and the analysis time should be shorter than with a compiler using an intermediary language.

GHDL can use multiple back-ends, i.e. code generators, ([GCC](http://gcc.gnu.org/), [LLVM](http://llvm.org/) or [x86](https://en.wikipedia.org/wiki/X86-64)/[i386](https://en.wikipedia.org/wiki/Intel_80386) only, a built-in one) and runs on [GNU/Linux](https://en.wikipedia.org/wiki/Linux_distribution), [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows)™, [macOS](https://en.wikipedia.org/wiki/MacOS)™ and [FreeBSD](https://en.wikipedia.org/wiki/FreeBSD), on x86 and on x86_64 and PowerPC.

The current version of GHDL does not contain any graphical viewer: you cannot see signal waves. You can still check the behavior of your design with a test bench. Moreover, the current version can produce a [GHW](http://ghdl.readthedocs.io/en/latest/using/Simulation.html?highlight=GHW#cmdoption-wave), [VCD](https://en.wikipedia.org/wiki/Value_change_dump) or FST files which can be viewed with a [waveform viewer](https://en.wikipedia.org/wiki/Waveform_viewer), such as [GtkWave](http://gtkwave.sourceforge.net/).

GHDL aims at implementing VHDL as defined by [IEEE 1076](http://ieeexplore.ieee.org/document/4772740/). It supports the  [1987](http://ieeexplore.ieee.org/document/26487/), [1993](http://ieeexplore.ieee.org/document/392561/) and [2002](http://ieeexplore.ieee.org/document/1003477/) revisions and, [partially](https://github.com/ghdl/ghdl/issues?utf8=%E2%9C%93&q=label%3A%22FeaReq%3A%20VHDL-2008%22%20), the latest, [2008](http://ieeexplore.ieee.org/document/4772740/). PSL is also partially supported.

Several third party projects are supported: [VUnit](https://vunit.github.io/), [OSVVM](http://osvvm.org/), [cocotb](https://github.com/potentialventures/cocotb) (through the [VPI](https://en.wikipedia.org/wiki/Verilog_Procedural_Interface) interface), …
