#!/bin/bash
set +o posix

awk '{print $2}' <(grep $'0\t0\t0\t0\t0' Data/integrated_call_samples.20130502.ALL.ped) > Data/integrated_call_samples.20130502.UNRELATED.ids

bcftools view -S Data/integrated_call_samples.20130502.UNRELATED.ids Data/founders_1000genomes/allchrom.vcf.gz --force-samples > Data/founders_1000genomes/allchrom_unrelated.vcf
