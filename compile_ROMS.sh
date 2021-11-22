#!/bin/bash
# Compile script from ROMS on Gadi

module purge
module purge
module load intel-compiler/2019.5.281
module load netcdf/4.7.1
module load openmpi/4.0.1

cp makefile /g/data/e14/rmh561/ROMS/ROMS/
cd /g/data/e14/rmh561/ROMS/ROMS/

make

