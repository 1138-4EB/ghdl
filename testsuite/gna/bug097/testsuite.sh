#! /bin/sh

. ../../testenv.sh

if ! c_compiler_is_available; then
  echo "Test skipped without C compiler"
  exit 0
fi

if [ -z $CC ]; then
  CC="gcc"
fi

$CC -c -fPIC getrand.c
$CC -o getrand.so --shared getrand.o

analyze tb.vhdl
elab_simulate tb

rm -f getrand.o getrand.so

clean

echo "Test successful"
