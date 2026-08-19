#!/bin/bash

#SBATCH --job-name=LD_extract_by_scaffold
#SBATCH --partition=batch
#SBATCH --ntasks=2
#SBATCH --mem=120gb
#SBATCH --time=6-20:00:00

################################################################################
# Extract LD results for chromosomes 1-22
################################################################################

for scaff in {1..22}; do

    sed -n "/^Scaffold_${scaff}_/p" \
        LD_calc_50k.wind.geno.ld \
        > LD_chromo${scaff}.geno.ld

done


################################################################################
# Extract LD results for remaining analyzed scaffolds
################################################################################

for scaff in {23..36} 46 92; do

    sed -n "/^Scaffold_${scaff}_/p" \
        LD_calc_50k.wind.geno.ld \
        > LD_scaff${scaff}.geno.ld

done
