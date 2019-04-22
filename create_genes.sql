/* ###Olga Better HW 3 Create.sql File### */

/* Creates homework 3 database */

/* Create a database hw3 for my project tables*/

create database hw3;

/* Creates my first table GENEinfo for my project.
With columns Accession, Protein_name, Gene_name, Gene_ID, and Go_ID */

create table GENEinfo (
    Accession varchar not null primary key,
    Protein_name varchar,
    Gene_name varchar,
    Gene_ID  varchar,
    Go_ID varchar
);
/* All of my datatypes are VARCHAR due to the fact they are a combination of both numbers and letters, using  integer throws an error*/

/* Copies in the information from my Database to fill in the columns I need,
I have also made sure all identical rows are removes, to see justification for the columns I picked please see BashPrepare.sh */
/* Table is normalized to BCNF*/

COPY GENEinfo(Accession, Protein_name, Gene_name, Gene_ID, Go_ID)
from '/Users/ryga2016/desktop/Database***/Database_project/pro_gene_table_uniq.txt'
with (FORMAT CSV, header, delimiter '	');

/* Index*/
/* Index for my GENEinfo table*/

CREATE INDEX Accession_idx
ON GENEinfo (Accession);

/* Creates my second table OntologyInfo for my project.
With columns Accession, Bio_Onto, and Cell_Onto */

create table OntologyInfo (
	Accession varchar not null primary key,
	Bio_Onto varchar,
	Cell_Onto varchar,
	Expression varchar,
	Genevisible varchar
);
/* All of my datatypes are VARCHAR due to the fact they are a combination of both numbers and letters*/

/* Copies in the information from my Database to fill in the columns I need,
I have also made sure all identical rows are removes, to see justification for the columns I picked please see BashPrepare.sh */
/* Table is normalized to BCNF*/

COPY OntologyInfo(Accession, Bio_Onto, Cell_Onto, Expression, Genevisible)
from '/Users/ryga2016/desktop/Database***/Database_project/pro_ontology_table_no_uniq.txt'
with (FORMAT CSV, header, delimiter '	');

/* Index*/
/* Index for my OntologyInfo table*/
CREATE INDEX Accession2_idx
ON OntologyInfo (Accession);


