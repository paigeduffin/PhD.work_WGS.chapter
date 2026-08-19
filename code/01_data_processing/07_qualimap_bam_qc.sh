#!/bin/bash

# Generate one Qualimap BAM QC SLURM script per sample.

for x in *_mark.dups.bam; do
    name=$(echo $x | cut -d'_' -f 1)

    echo "#!/bin/bash" > ${name}_qualimap.reports.sh
    echo "#SBATCH --partition=batch" >> ${name}_qualimap.reports.sh
    echo "#SBATCH --ntasks=4" >> ${name}_qualimap.reports.sh
    echo "#SBATCH --time=80:00:00" >> ${name}_qualimap.reports.sh
    echo "#SBATCH --mem=10G" >> ${name}_qualimap.reports.sh
    echo "#SBATCH --job-name=${name}_qualimap.reports" >> ${name}_qualimap.reports.sh

    echo "ml Qualimap/2.2.1-foss-2019b-R-3.6.2" >> ${name}_qualimap.reports.sh
    echo "qualimap bamqc -bam ${x}" >> ${name}_qualimap.reports.sh
done


# Submit generated scripts.

for x in *_qualimap.reports.sh; do
    sbatch ${x}
done
