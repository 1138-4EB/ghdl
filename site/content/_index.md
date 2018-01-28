---
features:
  - heading: Wide language standard support
    image_path: /images/icon-fast.svg
    tagline: Fully 1987, 1993 and 2002; partially 2008
    copy: 'Full support for the [1987](http://ieeexplore.ieee.org/document/26487/), [1993](http://ieeexplore.ieee.org/document/392561/), [2002](http://ieeexplore.ieee.org/document/1003477/) versions of the [IEEE](www.ieee.org) [1076](http://standards.ieee.org/develop/wg/P1076.html) VHDL standard, and [partial](https://github.com/ghdl/ghdl/issues?utf8=%E2%9C%93&q=label%3A%22FeaReq%3A%20VHDL-2008%22%20) for the latest [2008](http://ieeexplore.ieee.org/document/4772740/) revision. A specific VHDL version can be selected with a command line option.'
  - heading: "Get an executable binary from your design"
    image_path: ""
    tagline: "Multiple backend support: [LLVM](http://llvm.org/), [GCC](http://gcc.gnu.org/) or, [x86_64](https://en.wikipedia.org/wiki/X86-64)/[i386](https://en.wikipedia.org/wiki/Intel_80386) only, a built-in one."
    copy: 'A code generator (backend), is used to create binaries or executable images for the input design. This is the best form for test units (i.e. autonomous self-checking VHDL designs which use assert).'
  - heading: "Blistering Speed"
    image_path:
    tagline: "An executable binary is much faster than any interpreted simulator."
    copy: 'Since the design is compiled to an executable binary, GHDL is much faster than any interpreted simulator. It has been successfully employed for compiling and simulating very large designs such as [DLX](https://en.wikipedia.org/wiki/DLX) processor and the [leon3/grlib](http://www.gaisler.com/index.php/downloads/leongrlib) processor. See section [performance](/performance).'
  - heading: "Available on multiple platforms"
    image_path: ""
    tagline: "Has been successfully built on [GNU/Linux](http://en.wikipedia.org/wiki/Linux_distribution), [Windows](http://en.wikipedia.org/wiki/Microsoft_Windows)™, [macOS](http://en.wikipedia.org/wiki/MacOS)™ and [FreeBSD](https://en.wikipedia.org/wiki/FreeBSD), on `x86`, `x86_64` and `PowerPC`."
    copy: 'You can freely download a binary distribution for your OS or try to build it on your own machine. You can also use or extend any of the ready-to-use [Docker](https://hub.docker.com/u/ghdl) images. See section [Getting GHDL](/getting).'
  - heading: "Write waveforms to multiple formats"
    image_path: ""
    tagline: "[GHW](http://ghdl.readthedocs.io/en/latest/using/Simulation.html?highlight=GHW#cmdoption-wave), [VCD](https://en.wikipedia.org/wiki/Value_change_dump) or FST files can be exported for visual inspection with a waveform viewer."
    copy: 'See the [IDEs/Waveform viewers](/ides/#waveform-viewers) for more details.'
  - heading: "Explore your design"
    image_path: ""
    tagline: "GHDL can be used to pretty print or to generate cross references in HTML."
    copy: 'See the [IDEs/Parser applications](/ides/#parser-applications).'
  - heading: "Call a foreign language"
    image_path: ""
    tagline: "Since GHDL is a compiler, you can call functions or procedures written in a foreign language, such as C, C++ or Ada95."
    copy: 'See [guides/Call functions or proc...](/guides/#call-functions-or-procedures-written-in-a-foreign-language).'
  - heading: "Support of extension specifications and interfaces."
    image_path: ""
    tagline: "Partial support of [PSL](https://en.wikipedia.org/wiki/Property_Specification_Language), [VPI interface](https://en.wikipedia.org/wiki/Verilog_Procedural_Interface) and annotation of designs by means of a SDF file."
    copy: ''
  - heading: "Support of third party projects"
    image_path: ""
    tagline: "[VUnit](https://vunit.github.io), [OSVVM](http://osvvm.org), [cocotb](https://github.com/potentialventures/cocotb) (through the [VPI interface](https://en.wikipedia.org/wiki/Verilog_Procedural_Interface)), ..."
    copy: ''
notes:
  - text: 'GHDL can be used, modified and re-distributed. If you are interested in getting involved in current GHDL development, do not hesitate to contact us!'
    link: 'Contribute!'
    target: 'contribute/'
  - text: 'VHDL standards are carefully implemented. Indeed, GHDL has been reported to have a better implementation of standards than some commercial simulators. Yet, there might be bugs.'
    link: 'Send a bug report'
    target: 'contribute/#bug-report'
---

GHDL is the most popular [free and open-source](/licenses) compiler and simulator for the [VHDL](https://en.wikipedia.org/wiki/VHDL) language, i.e., it allows you to analyse, elaborate and execute VHDL code directly in a CPU-based computer. With its wide language standard support and amazing speed, GHDL makes designing and testing hardware systems available to everyone.
