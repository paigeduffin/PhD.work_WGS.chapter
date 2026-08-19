#!/bin/bash

# Generate one SLURM script per sample to run Picard
# FixMateInformation followed by MarkDuplicates.

for x in *_sort.sam; do
    name=$(echo $x | cut -d'_' -f 1)

    echo "#!/bin/bash" > ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh
    echo "#SBATCH --partition=batch" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh
    echo "#SBATCH --ntasks=1" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh
    echo "#SBATCH --time=80:00:00" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh
    echo "#SBATCH --mem=10G" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh
    echo "#SBATCH --job-name=${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh

    echo "ml picard/2.21.6-Java-11" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh

    echo "java -jar /apps/eb/picard/2.21.6-Java-11/picard.jar FixMateInformation \
        I=${x} \
        O=${name}_fix.mates.bam" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh

    echo "java -Xmx4g -jar /apps/eb/picard/2.21.6-Java-11/picard.jar MarkDuplicates \
        I=${name}_fix.mates.bam \
        O=${name}_mark.dups.bam \
        M=${name}_metrics.txt" >> ${name}_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh
done


# Submit generated scripts.

for x in *_prcss.rds.GATK_P.ochra.v2.map_fix.mates_mark.dups.sh; do
    sbatch ${x}
done
