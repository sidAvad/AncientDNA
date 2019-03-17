#$ -S /bin/bash      # Use bash
#$ -N extract-pairs_run-phibd  # name for job in qstat/output filename prefix
#$ -o /fs/cbsubscb09/storage/siddharth/AncientDNA/extract-pairs_run-phibd.$JOB_ID #Send output to working directory
#$ -j y              # output from stdout/err in one file
#$ -m ae             # send email on abort or exit of job
#$ -l h_vmem=256G     # use 256G of memory instead of the default (4G)
#$ -q regular.q # use the long_term queue (for jobs > 24 hours)

##$ -cwd              # Run in current working directory
##$ -pe bscb 4        # number of cores to use
##$ -binding linear:1 # use hyperthreading (never hurts) -- set # same as -pe #
##$ -q gpu.q
#### For task arrays:
##$ -t 1-40           # Run task numbers 1-8, task variable is $SGE_TASK_ID
####$ -tc 5          # number of tasks to run concurrently (if heavy I/O)
##$ -M sna53@cornell.edu   # email address to send to

/programs/bin/labutils/mount_server cbsubscb09 /storage
cd siddharth/AncientDNA

source activate py27
#sh extract-pairs_run-phibd.sh
#plink --vcf Data/founders_1000genomes/allchrom --make-bed --out allchrom --noweb
#vcf2bed --keep-header < Data/founders_1000genomes/allchrom.vcf > Data/founders_1000genomes/allchrom.bed
#plink2 --vcf Data/founders_1000genomes/allchrom.vcf --indep-pairwise 1000 25 0.25 
sh extract-pairs_run-phibd.sh 
#sh ped-sim.sh
