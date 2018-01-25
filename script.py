import wrappers.wrapper_sql as wsql
from subprocess import call, Popen
from functions import *
from functions_xml import *

rebuild_db()
# CONNECT
db = wsql.WrapperSQLite('kanar.db')
genbank = wsql.WrapperSQLite('sources/genbank.sqlite')
uniprot = wxml.WrapperXML('sources/niktamere.xml')


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
    ty['seq_id'] = None
    updated_trans.append(ty)

transcripts_real_names = ('CDS_id', 'product', 'idG', 'protein_id')
insert_trans = column_subset(updated_trans, transcripts_real_names)

print(insert_trans)
insert_tuples(db, 'TRANSCRIPTS', insert_trans)

protein_names = ( None, 'product', 'poids', 'longueur', 'uniprotKBswissprot', 'UniProtKBTrEMBL', 'GOA', 'InterPro', 'CDS_id', 'protein_id')
insert_prot = column_subset(updated_trans, protein_names)

print(insert_prot)
insert_tuples(db, 'PROTEINS', insert_prot)
update_goa(db)

sequence_names=(None, 'translation', 'protein_id')
insert_seq = column_subset(updated_trans, sequence_names)
print(insert_seq)
insert_tuples(db, 'SEQUENCES', insert_seq)

###### ! Prendre en compte cas où une protéine n'aurait aucune correspondance !
prot_dict = build_entries_list(uniprot)
print(prot_dict)
uniprot_names = ('accession', 'fullName', 'poids', 'longueur', None, None, None, None, None, None)
insert_data_uniprot = column_subset(prot_dict, uniprot_names)
#print(insert_data_uniprot)
#insert_tuples(db, 'PROTEINS', insert_data_uniprot)
