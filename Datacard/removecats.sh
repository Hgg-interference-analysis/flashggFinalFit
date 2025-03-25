#!/bin/bash

cp Datacard_${2}_xsec_orig.txt Datacard_${2}_xsec.txt

combineCards.py Datacard_${2}_xsec.txt \
--ic="$1" \
> temp

awk '!/pdfindex/ || '"/$1/" temp > Datacard_${2}_xsec.txt

sed -i -e 's/ch1_//g' Datacard_${2}_xsec.txt
