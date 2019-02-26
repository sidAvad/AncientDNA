#!/bin/bash

MAP=/fs/cbsubscb09/storage/resources/genetic_maps/refined_mf.simmap #mapfile for ped-sim run 

#Run pedsim for a range of psuedohaploidity values 
for i in 0.2 0.3 0.5 0.7 1
do
    echo "$i"
    /home/sna53/siddharth/ped-sim_pseudo-haploid/ped-sim -d Params/1st-3rd_deg.def -m $MAP -i Data/founders_1000genomes/allchrom_unrelated_TSI.vcf --pseudo_hap "$i" --intf ~/siddharth/ped-sim_pseudo-haploid/interfere/nu_p_campbell.tsv -o 1st-3rd_degree_TSI-$i --founder_ids 
done 

