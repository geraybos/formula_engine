#!/bin/sh

export num_cores=`grep -c processor /proc/cpuinfo`
export FEL_DIR=$PWD
export LD_LIBRARY_PATH=$PWD/lib:$PWD/lib/libpqxx/linux/lib:$LD_LIBRARY_PATH

cd libpqxx
./configure --disable-documentation --prefix=$FEL_DIR/lib/libpqxx/linux
make
make install
cd ..

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$FEL_DIR ..
make clean
make -j${num_cores}
make install

cd ..
bin/test_suite
