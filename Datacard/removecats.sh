#!/bin/bash

cp Datacard_xsec_orig.txt Datacard_xsec.txt

combineCards.py Datacard_xsec.txt \
--ic="$1" \
> temp

awk '!/pdfindex/ || '"/$1/" temp > Datacard_xsec.txt

sed -i -e 's/ch1_//g' Datacard_xsec.txt
