import pandas as pd
import sys

# get data
df = pd.read_csv('test_github_ANNOVAR_hg38.hg38_multianno.txt', sep='\t')
new_df = df.iloc[:, 0:10]
sample_df = df.loc[:,'Otherinfo13':]
del df

# merge
df = pd.concat([new_df, sample_df], axis=1)
del new_df, sample_df
sample_list = df.columns[10:]

def judge(n):
    gene_type = n.split(':')[0]
    if gene_type == './.' or gene_type == '0/0':
        return 0
    else:
        return 1
output = pd.DataFrame()
for sample in sample_list:
    data = df[sample]
    for var in range(len(data)):
        result = judge(data[var])
        if result == 1:
            output_data = df.iloc[var, 0:10]
            output_data['Tumor_Sample_Barcode'] = sample
            output = output.append(output_data)

output.to_csv('output.txt', sep='\t', header=True, index=False)