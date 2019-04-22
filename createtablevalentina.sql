/*Create the table for confirmed resistance genes
For the following table "accession" is the primary key since it is assigned to each sequence in UniProtKB. It gives gene name, organism, location and compound.
I tried to create the following FDs:
1: accession -> gene_name, organism, location
2: gene_name, organism -> compound to "make easier" the queries for our project.
Then I decomposed the second FD since it was not in BCFN, but I got the DUPLICATE KEYS error when I uploaded to SQL. It means that the same combination of gene_name and organism can refer to the same compound.
So I decided to upload the whole table and using ACCESSION as primary key.
I used also the "NOT NULL" contraint for gene_name since the gene name is an essential information for our project and queries.
So we want all values to be defined in this column*/
CREATE TABLE  gene_EXP(
gene_name VARCHAR not null, 
accession VARCHAR primary key,
organism VARCHAR, 
location VARCHAR,
compound VARCHAR
);


/*Create table for predicted resistance genes
In this case the GI_number and the gene_name are my primary keys since the 
GI_number does not always report the gene_name*/
CREATE TABLE gene_PRE(
GI_number INTEGER,
gene_ID VARCHAR, 
gene_name VARCHAR,
organism VARCHAR, 
compound VARCHAR, 
ncbi_annotation VARCHAR,
primary key (GI_number, gene_name)
);

/*UPLOAD the tables in SQL*/
COPY gene_EXP(gene_name, accession, organism, location, compound)
FROM '/Users/Valentina/Desktop/Database/DB_project/HW3/BacMet_EXP_small_unique.csv'
WITH (FORMAT CSV, HEADER, DELIMITER "	" );

COPY gene_PRE(GI_number, gene_ID, gene_name, organism, compound, ncbi_annotation)
FROM '/Users/Valentina/Desktop/Database/DB_project/HW3/BacMet2_PRE_unique.csv'
WITH (FORMAT CSV, HEADER, DELIMITER "	");

/*For our project we are interested in Staphylococcous Aureus bacteria. 
As initial queries, will use SELECT ... WHERE organism = "Staphylococcous Aureus"
So I decided to create an index for organism column for both tables:*/
CREATE INDEX organism_EXP_idx
ON gene_EXP (organism);

CREATE INDEX organism_PRE_idx
ON gene_PRE (organism);

