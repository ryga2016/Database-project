#!/bin/bash
### Olga Better HW 3 Prepare.sh File
### Using curl to read in file 
fileid="1HlgOv2phJnEF6a6ew3OL6kjNuG9GFxNE"
filename="ExpressionTable.text.tab"
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}

#### Confirmed Expression Information Dataset ####
### Check to see if file is already a tab delimited file
### less -S ./ExpressionTable.text.tab


#### To trim the data and get the columns we need for table GENEinfo ###

### Column 1,3,4,8,10 (Accession, Protein_name, Gene_name, Gene_ID, and Go_ID)
### Column 1(Accession), 4(Gene_name), and 8(Gene_ID) are needed to connect to Valentina's Database and filter the data we need to find 
### the list of resistant genes.
### Column 10(go_id) will be needed to connect to Adam's database
#### Fix the cut command to extract the correct column for go_id, from 9 to 10
cut -f 1,3,4,8,10 ExpressionTable.text.tab| sort -u > pro_gene_table.txt 
### To place 0 in bank spaces in GENEinfo table 
### Changes nulls to 0 so I could upload the data into my database. With the spaces being null it gave me a ton of error messages.
### The only way to get my data in the database was to place 0's in the null spaces.
awk 'BEGIN { FS = OFS = "\t" } { for(i=1; i<=NF; i++) if($i ~ /^ *$/) $i = 0 }; 1' pro_gene_table.txt > pro_gene_table_no.txt 
###count the lines for identical rows
wc -l ./pro_gene_table_no.txt 
###remove identical rows
uniq ./pro_gene_table_no.txt> ./pro_gene_table_uniq.txt


####To trim the data and get the columns we need for table OntologyInfo ###

### Column 1,9,10,11,12 (Accession, Bio_Onto, Cell_Onto, Expression, Genevisible)
### Column 1 (Accession), Column 9(Bio_onto), Column 10(Cell_Onto) are needed to connect to Adam's Database to determine pathway information
### Of the resistant genes.
cut -f 1,9,10,11,12 ExpressionTable.text.tab| sort -u > pro_ontology_table.txt
###To place 0 in bank spaces in OntologyInfo table
### Changes nulls to 0 so I could upload the data into my database. With the spaces being null it gave me a ton of error messages.
### The only way to get my data in the database was to place 0's in the null spaces.
awk 'BEGIN { FS = OFS = "\t" } { for(i=1; i<=NF; i++) if($i ~ /^ *$/) $i = 0 }; 1' pro_ontology_table.txt > pro_ontology_table_no.txt 
###count the lines for identical rows
wc -l ./pro_ontology_table_no.txt 
###remove identical rows
uniq ./pro_ontology_table_no.txt  > ./pro_ontology_table_no_uniq.txt


### Normalization of tables ####
### Both tables are normalized to BCNF....Only Accession number can be the primary key



