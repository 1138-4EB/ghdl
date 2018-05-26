---
title: Documentation generation
---

https://www.adacore.com/gnatpro/toolsuite/gps
https://github.com/AdaCore/gps

http://docs.adacore.com/gnatdoc-docs/users_guide/_build/html/gnatdoc.html

docker run --rm -t ghdl/build:stretch-mcode sh -c "apt-get update && apt-get install -y gnat-gps git && git clone http://github.com/tgingold/ghdl && cd ghdl && ./dist/linux/buildtest.sh -b mcode && cd build-mcode && gnatdoc -Pghdl"
