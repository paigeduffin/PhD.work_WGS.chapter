#!/bin/bash

# Generate one Picard AddOrReplaceReadGroups SLURM script per sample.

for x in *.sam; do
    name=$(echo $x | cut -d'.' -f 1)

    echo "#!/bin/bash" > ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
    echo "#SBATCH --partition=batch" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
    echo "#SBATCH --ntasks=1" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
    echo "#SBATCH --time=8:00:00" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
    echo "#SBATCH --mem=10G" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
    echo "#SBATCH --job-name=${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh

    echo "ml picard/2.27.4-Java-13.0.2" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
    echo "java -jar /apps/eb/picard/2.27.4-Java-13.0.2/picard.jar AddOrReplaceReadGroups \
        I=${x} \
        O=${name}_RG.sam \
        RGID=${name} \
        RGLB=lib1 \
        RGPL=ILLUMINA \
        RGPU=unit1 \
        RGSM=${name}" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh
done


# Submit generated scripts.

for x in *_prcss.rds.GATK_P.ochra.v2.map_rd.grps.sh; do
    sbatch ${x}
done
