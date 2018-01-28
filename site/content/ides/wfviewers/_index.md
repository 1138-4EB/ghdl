---
title: Waveform Viewers
---

[wave viewer page](http://ghdl.free.fr/site/pmwiki.php?n=Main.WaveViewer)

When you want to debug your VHDL design, it is very useful to be able to watch a graphical representation of your signals. GHDL can generate a waveform file which can be read by [GTKWave](http://gtkwave.sourceforge.net/).

GHDL supports two formats, the first format is VCD (Value Change Dump), which is an open format defined by Verilog. The specification of the format is defined by the Verilog LRM. VCD is an ASCII format, so VCD files grow quickly. Most of the waveform viewers support VCD.

You can generate a VCD file from your design by using the --vcd=filename option. Refer to the GHDL [user guide](http://ghdl.free.fr/site/pmwiki.php?n=Main.UserGuide) for more details.

Since VCD is Verilog oriented, it is not possible to dump all the VHDL types with VCD. Furthermore, there is no open waveform file format for VHDL. That is the reason why a GHDL waveform format was created.

Recent versions of GTKWave can read both formats. Do not forget to set hier_max_level to 0 to see the full signal name. Also, vectors are always expanded.

## GtkWave

Tony Bybell is actively supporting [gtkwave](http://gtkwave.sourceforge.net/) on Mac OS X with an SDK-10.6 (x86_64, Lion, Snow Leopard) gtkwave.app currently in pre-release but very stable. It goes very well with the mcode version of GHDL available on the [Download](http://ghdl.free.fr/site/pmwiki.php?n=Main.Download) page (i386, SDK-10.5 Leopard/Snow Leopard/Lion compatible).
