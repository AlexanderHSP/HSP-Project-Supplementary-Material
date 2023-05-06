#!/bin/bash

. ~/.bashrc
load_miga
cd "$(dirname "$0")/../05.miga"

hostname
export MIGA_NODELIST="$(pwd)/hosts.txt"
THR_HERE=$(grep -c "$(hostname)" "$MIGA_NODELIST")

echo "Classifying"
miga classify_wf -o . -v \
  --min-qual 50 --type popgenome \
  --database TypeMat_Lite \
  --threads-project "$THR_HERE" \
  ../03.mags/03.mags/bins/*.fna

echo "Dereplicating"
miga derep_wf -o . -v \
  --min-qual 50 \
  --threads-project "$THR_HERE"

