import wrappers.wrapper_sql as wsql
from subprocess import call, Popen
from functions import *

call(['rm', 'kanar.db' ])

call(['touch', "kanar.db"] )

call(["sed", "-i", "/^#/d", "model.sql"])
call(['sed', "-i", 's/autoincrement/AUTO_INCREMENT/g', "model.sql"])

db = wsql.WrapperSQLite('kanar.db')
db.load_schema_sql('model.sql')

# Import Genbank
genbank = wsql.WrapperSQLite('sources/genbank.sqlite')
genes = genbank.query_select("SELECT * FROM Genes")
gene_names = ('gene_id', 'start', 'end', 'strand', 'nom', 'uniprot_id', 'locus_tag', 'synonym')
genes = tuples_dict(genes, gene_names)
insert_genes = column_subset(genes, ['gene_id', 'nom', 'locus_tag', 'start', 'end', 'uniprot_id'])

for gene in insert_genes:
    query = "INSERT INTO Gene VALUES {values}".format(values=tuple(gene))
    query = query.replace('None', 'NULL')
    #print(query)
    db.query_boolean(query)




