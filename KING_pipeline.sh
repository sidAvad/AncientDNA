#!/bin/bash
set +o posix 

#Subset vcf to population of interest (EUR in this case) 
#bcftools view -S Data/integrated_call_samples_v3.20130502.EUR.ids Data/founders_1000genomes/allchrom.vcf.gz --force-samples -o Data/founders_1000genomes/allchrom_EUR.vcf

#Generate plink.prune.in and plink.prune.out 
plink2 --vcf Data/founders_1000genomes/allchrom_EUR.vcf --indep-pairwise 2000 50 0.25

#Filter vcfs based on pruning 
vcftools --vcf Data/founders_1000genomes/allchrom_EUR.vcf --snps Output/plink.prune.in --recode --recode-INFO-all --out Data/founders_1000genomes/allchrom_EUR_LDpruned

#zip vcf
bgzip -c Data/founders_1000genomes/allchrom_EUR_LDpruned.recode.vcf > Data/founders_1000genomes/allchrom_EUR_LDpruned.recode.vcf.gz

#Convert to .bed format using plink 2 
plink2 --vcf Data/founders_1000genomes/allchrom_EUR_LDpruned.recode.vcf.gz --make-bed --out Data/founders_1000genomes/allchrom_EUR_LDpruned

#Run KING inference to remove up to second degree relatives 
king -b Data/founders_1000genomes/allchrom_EUR_LDpruned.bed --unrelated --degree 3 

#Columns are duplicated so pull one out 
awk '{print $1}' kingunrelated.txt > kingunrelated_col1.txt
wc -l kingunrelated_col1.txt #Count number of individuals 

#Create filtered founder set 
bcftools view Data/founders_1000genomes/allchrom_EUR_LDpruned.recode.vcf.gz -S kingunrelated_col1.txt -o allchrom_EUR_KING-filtered.second-degree.vcf 

#Confirm pipeline by counting number of retained individuals 
bcftools query -l allchrom_EUR_KING-filtered.second-degree.vcf | wc -l
