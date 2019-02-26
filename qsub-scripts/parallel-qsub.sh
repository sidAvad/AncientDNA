#$ -S /bin/bash      # Use bash
#$ -N ld-pruning_parallel  # name for job in qstat/output filename prefix
#$ -j y              # output from stdout/err in one file
#$ -l h_vmem=256G     # use 256G of memory instead of the default (4G)
#$ -q regular.q # use the long_term queue (for jobs > 24 hours)
#$ -t 1-22           # Run task numbers 1-22, task variable is $SGE_TASK_ID

##$ -m ae             # send email on abort or exit of job
##$ -cwd              # Run in current working directory
##$ -pe bscb 4        # number of cores to use
##$ -binding linear:1 # use hyperthreading (never hurts) -- set # same as -pe #
##$ -q gpu.q
#### For task arrays:
####$ -tc 5          # number of tasks to run concurrently (if heavy I/O)
##$ -M sna53@cornell.edu   # email address to send to

printf "On host "
host=$(hostname)
echo $host
date

#####
# mount cbsubscb09 storage
/programs/bin/labutils/mount_server cbsubscb09 /storage
cd siddharth/AncientDNA

chr=$SGE_TASK_ID


#To make bed files (can do this with plink ?) 
#vcf2bed --keep-header < Data/founders_1000genomes/chr${chr}.vcf > Data/founders_1000genomes/${chr}.bed

#To do ld pruning ( need ped files for this )
#plink --file Data/founders_1000genomes/chr${chr} --indep-pairwise 1000 25 0.25 --noweb

#To make ped and map files 
vcftools --vcf Data/founders_1000genomes/chr${chr}.vcf --plink --out Data/founders_1000genomes/chr${chr}



