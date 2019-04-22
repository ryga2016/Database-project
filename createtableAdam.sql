
/* pathway_gene table created with 2 columns. Each pathway could have multiple genes
associated with it, so I needed to make the pathway and gene primary keys. 
Each pathway name + gene id is unique.
*/
CREATE TABLE pathway_gene(
pathway VARCHAR,
gene_id VARCHAR,
PRIMARY KEY(pathway, gene_id)
);


/*The gene id is unique for each row. Not every entry has a swiss prot id.
I can combine this table on the gene id with the other table to find 
common genes that share a pathway. By joining these data sets over gene id or 
swiss prot id with the groups datasets, we hope to provide more information about pathway 
relationships with genes.
*/

CREATE TABLE gene_product(
gene_id VARCHAR PRIMARY KEY,
gene_name VARCHAR,
product_name VARCHAR,
swiss_prot_id VARCHAR
);

\COPY pathway_gene(pathway, gene_id) FROM '/Users/ryga2016/downloads/newpathways.csv' WITH (FORMAT CSV, DELIMITER ',' );

\COPY gene_product(gene_id, gene_name, product_name, swiss_prot_id) FROM '/Users/ryga2016/downloads/genes_trimmed.txt' WITH (FORMAT CSV, DELIMITER ',' );


