#!/bin/bash

#SBATCH --job-name=LD_1mil_subsampling
#SBATCH --partition=batch
#SBATCH --ntasks=2
#SBATCH --mem=120gb
#SBATCH --time=6-20:00:00

################################################################################
# Randomly subsample 1,000,000 LD comparisons from chromosomes 1-22
################################################################################

for chromo in {1..22}; do

    shuf -n 1000000 \
        LD_chromo${chromo}.geno.ld \
        > LD_chromo${chromo}_1mil.geno.ld

done


################################################################################
# Randomly subsample 1,000,000 LD comparisons from scaffolds 23-25
################################################################################

for scaff in {23..25}; do

    shuf -n 1000000 \
        LD_scaff${scaff}.geno.ld \
        > LD_scaff${scaff}_1mil.geno.ld

done
