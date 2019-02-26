#!/bin/bash
cd forAmy

#Remove lines that begin with ## and concatenate the chromosome vcf files into one
#Required for ped-sim

for i in `ls -v *.vcf`; do grep "^[^##]" $i >> allchrom.vcf; done;



