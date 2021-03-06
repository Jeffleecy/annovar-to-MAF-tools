#!/usr/bin/sh
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J vcf2maf         # Job name
#SBATCH -p ngs12G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 3               # 使用的core數 請參考Queue資源設定 
#SBATCH --mem=12G           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o gitout.log          # Path to the standard output file 
#SBATCH -e giterr.log          # Path to the standard error ouput file

ref_genome_dir='/staging/reserve/paylong_ntu/AI_SHARE/reference/GATK_bundle/2.8/b37/'
ref_genome_file='human_g1k_v37_decoy.fasta.gz'
input_vcf='test_github_ANNOVAR_hg38.hg38_multianno.vcf'
output_maf='test_github_ANNOVAR_hg38.hg38_multianno.maf'
work_dir='/staging/biology/peimiao0322/MAF'

# module require samtools/tabix 
export PATH=$PATH:/opt/ohpc/Taiwania3/pkg/biology/SAMTOOLS/SAMTOOLS_v1.13/bin:/opt/ohpc/Taiwania3/pkg/biology/HTSLIB/build/htslib

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# reference genome preprocess, you can download on internet or make by your own.
# reference file required .fa .fai .gzi

file1='Homo_sapiens.GRCh37.dna.toplevel.fa.gz'
file2='Homo_sapiens.GRCh37.dna.toplevel.fa.gz.gzi'
file3='Homo_sapiens.GRCh37.dna.toplevel.fa.gz.fai'
file_path=$HOME/.vep/homo_sapiens/102_GRCh37


if test -f "${file_path}/${file1}";then
	echo "${file_path}/${file1} exist."
else 
	mkdir $HOME/.vep
	mkdir $HOME/.vep/homo_sapiens
	mkdir $HOME/.vep/homo_sapiens/102_GRCh37 
	cd $HOME/.vep/homo_sapiens/102_GRCh37
	rsync ${ref_genome_dir}/${ref_genome_file} -t ./
	mv ${ref_genome_file} Homo_sapiens.GRCh37.dna.toplevel.fa.gz

	gunzip Homo_sapiens.GRCh37.dna.toplevel.fa.gz
	bgzip -i Homo_sapiens.GRCh37.dna.toplevel.fa
	samtools faidx Homo_sapiens.GRCh37.dna.toplevel.fa.gz
fi



# vcf2maf
cd ${work_dir}
perl vcf2maf.pl --input-vcf ${input_vcf} --output-maf ${output_maf} --inhibit-vep














