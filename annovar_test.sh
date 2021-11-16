#!/usr/bin/sh
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J vcf2maf         # Job name
#SBATCH -p ngs7G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2               # 使用的core數 請參考Queue資源設定 
#SBATCH --mem=7G           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o anout.log          # Path to the standard output file 
#SBATCH -e anerr.log          # Path to the standard error ouput file

table_annovar='/opt/ohpc/Taiwania3/pkg/biology/ANNOVAR/annovar_20210819/table_annovar.pl'
input_vcf='DF_Fid.vqsr_SNP_INDEL.hc.recaled.vcf.gz'
para="test_github_ANNOVAR_hg38"

humandb="/staging/reserve/paylong_ntu/AI_SHARE/reference/annovar_2016Feb01/humandb/"



perl ${table_annovar} ${input_vcf} ${humandb} -buildver hg38 -out ${para} -remove -protocol refGene,cytoBand,knownGene,ensGene,gnomad30_genome,avsnp150,gnomad211_exome,intervar_20180118,clinvar_20210501,dbnsfp41a,icgc28,revel -vcfinput -operation gx,r,gx,gx,f,f,f,f,f,f,f,f  
