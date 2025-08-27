#!/usr/bin/env bash

runs=1000

rm *.log

cmake ..
cmake --build .

for i in $(seq 1 $runs);
do
    echo "Building standard - no pch: run $i"
    
    find . -name "standard" -delete 
    find . -name "standard.exe" -delete 
    find . -name "main*.o" -delete;
    find . -name "main*.obj" -delete;
    (time cmake --build . --target standard)  2>> build_standard.log
#    (time /usr/bin/clang++ -g -std=gnu++20 -fcolor-diagnostics -o CMakeFiles/standard.dir/main.cpp.o -c /home/markus/development/playground/pre_compile_performance_test/main.cpp) 2>> build_standard.log
done
    
for i in $(seq 1 $runs);
do
    echo "Building stardard - pch active: run $i"

    find . -name "precompiled" -delete
    find . -name "precompiled.exe" -delete
    find . -name "main*.o" -delete;
    find . -name "main*.obj" -delete;
    
    (time cmake --build . --target precompiled) 2>> build_precompiled.log  
    #(time /usr/bin/clang++   -g -std=gnu++20 -fcolor-diagnostics -Winvalid-pch -Xclang -include-pch -Xclang /home/markus/development/playground/pre_compile_performance_test/cmake-build-debug/CMakeFiles/pch_provider.dir/cmake_pch.hxx.pch -Xclang -include -Xclang /home/markus/development/playground/pre_compile_performance_test/cmake-build-debug/CMakeFiles/pch_provider.dir/cmake_pch.hxx -o CMakeFiles/precompiled.dir/main.cpp.o -c /home/markus/development/playground/pre_compile_performance_test/main.cpp) 2>> build_precompiled.log  
done

for i in $(seq 1 $runs);
do
    echo "Building freecad style - no pch: run $i"

    find . -name "standard_freecad" -delete
    find . -name "standard_freecad.exe" -delete
    find . -name "main*.o" -delete;
    find . -name "main*.obj" -delete;
    (time cmake --build . --target standard_freecad) 2>> build_freecad.log  
done

for i in $(seq 1 $runs);
do
    echo "Building stardard - pch active: run $i"

    find . -name "precompiled_freecad" -delete
    find . -name "precompiled_freecad.exe" -delete
    find . -name "main*.o" -delete;
    find . -name "main*.obj" -delete;
    (time cmake --build . --target  precompiled_freecad) 2>> build_freecad_precompiled.log  
done
