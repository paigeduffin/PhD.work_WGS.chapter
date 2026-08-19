#!/bin/bash

# Prepare the version 2 Pisaster ochraceus reference genome for mapping.

gzip pisaster.ochraceus_v2_06.07.2022_final.assembly.fna

ml BWA/0.7.17-GCC-8.3.0

bwa index pisaster.ochraceus_v2_06.07.2022_final.assembly.fna.gz


# Generate one BWA mapping SLURM script per sample.

for x in *_A_val_1.fq.gz; do
    name=$(echo $x | cut -d'_' -f 1)

    echo "#!/bin/bash" > ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "#SBATCH --job-name=map2genome_P.ochra.v2.mapping_serial" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "#SBATCH --partition=batch" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "#SBATCH --ntasks=8" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "#SBATCH --mem=30gb" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "#SBATCH --time=80:00:00" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "ml BWA/0.7.17-GCC-8.3.0" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
    echo "bwa mem -t 8 pisaster.ochraceus_v2_06.07.2022_final.assembly.fna.gz ${name}_A_val_1.fq.gz ${name}_B_val_2.fq.gz > ${name}.sam" >> ${name}_map2genome_P.ochra.v2.map_10.25.22.sh
done


# Submit generated mapping scripts.

for x in *_map2genome_P.ochra.v2.map_10.25.22.sh; do
    sbatch ${x}
done
