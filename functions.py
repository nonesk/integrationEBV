import wrappers.wrapper_sql as wsql
from subprocess import call, Popen
import sys

def tuples_dict(tuples_list, names):
    """
    Etant donné une liste de tuples from source, crée une liste de dico avec les nom de names"
    """
    result = []
    for t in tuples_list:
        result.append(dict(zip(names, t)))
    return result

def column_subset(tuples_dict, names):
    """Depuis une liste de dico de resultats,
    crée une liste de liste avec les données correspondant aux names, dans l'ordre
    """
    result=[]
    for t in tuples_dict:
        subset = []
        for k in names:
            if k is None:
                subset.append(k)
            else:
                subset.append(t[k])
        result.append(tuple(subset))
    return result

def make_query(table, tuple_list, col_subset=[]):
    insert_list = ",".join(map(str,tuple_list))
    if col_subset:
        query = "INSERT INTO {table} {col_subset} VALUES {values}".format(
            table=table, values=insert_list, col_subset=str(col_subset).replace("'", ""))
    else:
        query = "INSERT INTO {table} VALUES {values}".format(table=table, values=insert_list)
    query = query.replace('None', 'NULL')
    return query

def insert_tuples(db, table, tuple_list, col_subset=[]):
    print(tuple_list)
    query = make_query(table, tuple_list, col_subset)
    print(query)
    db.query_boolean(query)

def make_insert_script(db, table, insert_list, fhandle=sys.stdout):
    for t in insert_list:
        query = "INSERT INTO {table} VALUES {values}".format(table=table, values=tuple(t))
        query = query.replace('None', 'NULL')
        print(query, file=fhandle)

## GENBANK

# Transcripts BORDEL

def update_transcript_dict(db, transcripts):
    uniprot_id = transcripts['GeneID']
    gene_id = db.query_select("SELECT * FROM GENES WHERE uniprot_id = '{gene}';".format(gene=uniprot_id))
    transcripts['idG'] = gene_id[0][0]
    return transcripts

def update_prot_dict(db, prot):
    prot['poids'] = None
    prot['longueur'] = None
    return prot

def rebuild_db():
    call(['rm', 'kanar.db' ])

    call(['touch', "kanar.db"] )

    call(["sed", "-i", "/^#/d", "model.sql"])
    call(['sed', "-i", 's/autoincrement/AUTO_INCREMENT/g', "model.sql"])
    call(['sed', "-i", 's/idT *INTEGER NOT NULL/idT INTEGER/g', "model.sql"])

    db = wsql.WrapperSQLite('kanar.db')
    db.load_schema_sql('model.sql')


def update_goa(db):
    query = "UPDATE PROTEINS SET GOA=(SELECT UniProtKBTrEMBL FROM PROTEINS p2 WHERE p2.idP = PROTEINS.idP) WHERE PROTEINS.idP = idP AND PROTEINS.UniProtKBSwissProt IS NULL"
    db.query_boolean(query)
    query = "UPDATE PROTEINS SET GOA=(SELECT UniProtKBSwissProt FROM PROTEINS p2 WHERE p2.idP = PROTEINS.idP) WHERE PROTEINS.idP = idP AND PROTEINS.UniProtKBTrEMBL IS NULL"
    db.query_boolean(query)

def map_acc2idp(db, data):
    query = "SELECT idP FROM PROTEINS WHERE GOA IN ('{accesion_list}')".format(accesion_list="','".join(data['accession']))
    print(query)
    res = db.query_select(query)
    return res[0][0] if res else None
