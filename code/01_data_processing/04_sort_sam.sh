#!/bin/bash

# Generate one SAMtools sorting SLURM script per sample.

for x in *_RG.sam; do
    name=$(echo $x | cut -d'.' -f 1)

    echo "#!/bin/bash" > ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
    echo "#SBATCH --partition=batch" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
    echo "#SBATCH --ntasks=1" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
    echo "#SBATCH --time=80:00:00" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
    echo "#SBATCH --mem=10G" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
    echo "#SBATCH --job-name=${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh

    echo "ml SAMtools" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
    echo "samtools sort ${x} > ${x}_sort.sam" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh
done


# Submit generated scripts.

for x in *_prcss.rds.GATK_P.ochra.v2.map_sort.sam.sh; do
    sbatch ${x}
done
