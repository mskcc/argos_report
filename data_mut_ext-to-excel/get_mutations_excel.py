import pandas as pd
import pandas.io.formats.excel
pandas.io.formats.excel.ExcelFormatter.header_style = None


# def format_table(df_name, sheet_name):

clinical_df = pd.read_csv('data_clinical_sample.txt', sep='\t', comment='#')#, usecols=columns_to_read)

# Read the TSV file into a DataFrame
df = pd.read_csv('data_mutations_extended.txt', sep='\t', comment='#')#, usecols=columns_to_read)


df = pd.merge(df, clinical_df, left_on='Tumor_Sample_Barcode', right_on='SAMPLE_ID', how='outer')



#rename columns
df.rename(columns={
    'COLLAB_ID': 'CollabID',
    'ONCOTREE_CODE':'OncoCode',
    'Hugo_Symbol': 'Gene',
    'Tumor_Sample_Barcode': 'Tumor',
    'Matched_Norm_Sample_Barcode': 'Normal',
    'Variant_Classification': 'Variant_class',
    'Variant_Type': 'Variant_type'
    }
    , inplace=True)

#reorder columns
df = df[['CollabID','Tumor', 'Normal', 'Gene','Variant_class','Variant_type','OncoCode']]

# Create an Excel writer object using the XlsxWriter engine
writer = pd.ExcelWriter('data_mutations_extended2.xlsx', engine='xlsxwriter')

# Write the DataFrame to the Excel file
df.to_excel(writer, sheet_name='mutations', index=False)

# Get the workbook and worksheet objects
workbook = writer.book
worksheet = writer.sheets['mutations']

# Create a format for the header without any border
header_format = workbook.add_format({'bold': True, 'border': 0, 'align': 'center', 'valign': 'vcenter'})

# Create a format for all
cell_format = workbook.add_format({
    'align': 'center',        # Horizontal center alignment
    'valign': 'vcenter',      # Vertical center alignment
    'border': 0               # No border
})

# Apply the format to the first row (header)
worksheet.set_row(0, None, header_format)

# Adjust column width based on the content
for idx, col in enumerate(df.columns):
    # Get max length of the column header or the column's content (converted to string)
    max_len = max(df[col].astype(str).map(len).max(), len(col)) + 2  # Add some padding
    worksheet.set_column(idx, idx, max_len, cell_format)

# Close the Excel writer and save the file
writer.close()