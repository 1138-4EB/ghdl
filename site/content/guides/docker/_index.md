---
title: Docker Primer
weight: 1
---

### docker primer

- Portainer
- `run`, `--rm`, `-i` (winpty), `-t`
- bind/volumes
- ports
- envvars
- `-d`, exec

#### How-to: from a single script to a dockerized execution

These are some examples about how to go from a single script to compile and test GHDL with LLVM, to a dockerized solution.

##### Single-script non-docker solution

{{< note title="Note" >}}
I am going to use Fedora as an example, but adapting it to [other](https://hub.docker.com/explore/) distros is straightforward.
{{< /note >}}

The following script, `script.sh`, is enough to compile GHDL with LLVM and run the test suite:

```
dnf -y install gcc-gnat llvm-devel gcc-c++ clang ncurses-devel zlib-devel git

git clone --branch=master http://github.com/tgingold/ghdl.git tmpRepo
cd tmpRepo

deployto="$(pwd)/deploy"
export GHDL=$deployto/bin/ghdl
./configure --with-llvm-config --prefix=$deployto
make
make install
cd testsuite
./testsuite.sh
```

##### Same script in a docker container

If docker is installed, and the engine is running, the same result can be achieved with:

```
chmod u+w+x script.sh
docker run --name ghdl -itv $(pwd):/tmpDir:Z fedora bash -c 'cd /tmpDir && sh script.sh && exit'
```

##### Create the most simple Dockerfile

On top of that, a Dockerfile can be used to create an image on top of `fedora` which will have all the required packages installed already. This is a tradeoff between size and time.

```
FROM fedora:latest

RUN dnf -y install gcc-gnat llvm-devel gcc-c++ clang ncurses-devel zlib-devel git
```

Then, we save the image to `fedora:ghdl`. Therefore, `script.sh` can be modified to `docompile.sh`:

```
git clone --branch=master http://github.com/tgingold/ghdl.git tmpRepo
cd tmpRepo

deployto="$(pwd)/deploy"
export GHDL=$deployto/bin/ghdl
./configure --with-llvm-config --prefix=$deployto
make
make install
cd testsuite
./testsuite.sh
```

And it is run:

```
chmod u+w+x docompile.sh
docker run --name ghdl -itv $(pwd):/tmpDir:Z fedora:ghdl bash -c 'cd /tmpDir && sh docompile.sh && exit'
```

###### Use a volume in the Dockerfile

The call can be simplified by:

```
FROM fedora:latest

ADD /path/to/script /tmpDIR

RUN dnf -y install gcc-gnat llvm-devel gcc-c++ clang ncurses-devel zlib-devel git
RUN cd /tmpDir
RUN script.sh
```

```
chmod u+w+x docompile.sh
docker build .
```

###### Put everything in a Dockerfile

Alternatively, the commands in the script can be put directly in the Dockerfile:

```
FROM fedora:latest

RUN dnf -y install gcc-gnat llvm-devel gcc-c++ clang ncurses-devel zlib-devel git
RUN git clone --branch=master http://github.com/tgingold/ghdl.git tmpRepo
RUN cd tmpRepo
RUN deployto="$(pwd)/deploy"
RUN export GHDL=$deployto/bin/ghdl
RUN ./configure --with-llvm-config --prefix=$deployto
RUN make
RUN make install
RUN cd testsuite
RUN ./testsuite.sh
```

Or, even better:

```
FROM fedora:latest

RUN dnf -y install gcc-gnat llvm-devel gcc-c++ clang ncurses-devel zlib-devel git
 && git clone --branch=master http://github.com/tgingold/ghdl.git tmpRepo
 && cd tmpRepo
 && deployto="$(pwd)/deploy"
 && export GHDL=$deployto/bin/ghdl
 && ./configure --with-llvm-config --prefix=$deployto
 && make
 && make install
 && cd testsuite
 && ./testsuite.sh
```

And:

```
docker build .
```

Conclusion: there are many alternatives to execute the same bunch of commands. But all of them are nearly the same. The main difference is the feedback you have while it is being executed.
