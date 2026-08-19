#!/bin/bash

################################################################################
# Add header row to LD files for downstream R analyses
################################################################################

header="CHR	POS1	POS2	N_INDV	R^2"

# Chromosomes 1-22: use 1-million-comparison subsamples
for chromo in {1..22}; do

    {
        echo -e "$header"
        cat LD_chromo${chromo}_1mil.geno.ld
    } > LD_chromo${chromo}_data.for.plot.txt

done


# Scaffolds 23-25: use 1-million-comparison subsamples
for scaff in {23..25}; do

    {
        echo -e "$header"
        cat LD_scaff${scaff}_1mil.geno.ld
    } > LD_scaff${scaff}_data.for.plot.txt

done


# Remaining smaller scaffolds: use complete LD files
for scaff in {26..36} 46 92; do

    {
        echo -e "$header"
        cat LD_scaff${scaff}.geno.ld
    } > LD_scaff${scaff}_data.for.plot.txt

done
