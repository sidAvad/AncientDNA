#!/bin/bash
set +o posix

#poplist.txt is a newline seperated list of population identifiers
while read p; do
    echo "$p"
    bcftools view -S Data/integrated_call_samples_v3.20130502.${p}.ids Data/founders_1000genomes/allchrom_unrelated.vcf.gz --force-samples  > Data/founders_1000genomes/allchrom_unrelated_${p}.vcf
done < poplist.txt

