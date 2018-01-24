import wrappers.wrapper_sql as wsql
from subprocess import call, Popen
from functions import *


db = wsql.WrapperSQLite('kanar.db')

# Import Genbank
genbank = wsql.WrapperSQLite('sources/genbank.sqlite')

# Genes
genes = genbank.query_select("SELECT * FROM Genes")
gene_names = ('gene_id', 'start', 'end', 'strand', 'nom', 'uniprot_id', 'locus_tag', 'synonym')
genes = tuples_dict(genes, gene_names)
insert_genes = column_subset(genes, ['gene_id', 'nom', 'locus_tag', 'start', 'end', 'uniprot_id'])
insert_tuples(db, 'GENES', insert_genes)

# Protéines & transcrits
transcripts = genbank.query_select("SELECT * FROM Transcripts")
transcripts_names = (
    'CDS_id',
    'start',
    'stop',
    'strand',
    'codon_start',
    'protein_id',
    'product',
    'translation',
    'gene',
    'uniprotKBswissprot',
    'InterPro',
    'GOA',
    'GI',
    'PDB',
    'GeneID',
    'locus_tag',
    'note',
    'UniProtKBTrEMBL',
    'function'
)
transcripts_raw = tuples_dict(transcripts, transcripts_names)
updated_trans = []
for t in transcripts_raw:
    tx = update_transcript_dict(db, t)
    ty = update_prot_dict(db, tx)
    updated_trans.append(ty)

transcripts_real_names = ('CDS_id', 'product', 'idG', 'protein_id')
insert_trans = column_subset(updated_trans, transcripts_real_names)

print(insert_trans)
insert_tuples(db, 'TRANSCRIPTS', insert_trans)

protein_names = ('protein_id', 'product', 'poids', 'longueur', 'uniprotKBswissprot', 'UniProtKBTrEMBL', 'GOA', 'InterPro', 'CDS_id')
insert_prot = column_subset(updated_trans, protein_names)

print(insert_prot)
insert_tuples(db, 'PROTEINES', insert_prot)
