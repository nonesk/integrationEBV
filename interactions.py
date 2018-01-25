import wrappers.wrapper_json as wjson
from subprocess import call, Popen
from functions import *
import re

db = wsql.WrapperSQLite('kanar.db')

def parse_psimi(pm):
    match = re.match(r"psi-mi:(?P<id>MI:\d+)\((?P<label>[^\)]+).*", pm)
    return match.groups()

def process_detection_methods(data,db=db):
    detection = set()
    for d in data: 
        for meth in d['interactionDetectionMethod']:
            detection.add(parse_psimi(meth))
    
    insert_list = []
    for d in detection:
        insert_list.append(tuple([None]) + d + tuple([None]))
    print(insert_list)
    insert_tuples(db, 'DETECTION_METHODS', tuple(insert_list))

def process_interaction_types(data, db=db):
    types = set()
    for d in data:
        for t in d['interactionTypes']:
            types.add(parse_psimi(t))
    insert_list = []
    for t in types:
        insert_list.append(tuple([None]) + t)
    insert_tuples(db, 'INTERACTION_TYPES', insert_list)

def parse_identifiers(datum):
    ret = dict()
    ids = datum['interactionIdentifiers']
    for ident in ids:
        print(ident.split(":"))
        ret.update([ident.split(":")])
    return ret



def process_interaction(data, db=db):
    tuples_list = []
    for d in data:
        insert_dict = dict()
        insert_dict.update(parse_identifiers(d))
        
        #placeholders
        insert_dict.update({
            'ida' : d["idA"][0].split(':')[1],
            'idb' : d['idB'][0].split(':')[1],
            'psimitype' : parse_psimi(d["interactionTypes"][0])[1]
        })

        insert_dict.update({
            'idP':"<<<SELECT idP FROM PROTEINS WHERE UniProtKBTrEMBL='{ida}'>>>".format(
                ida=insert_dict['ida']),
            'idP_PROTEINS': "<<<SELECT idP FROM PROTEINS WHERE UniProtKBTrEMBL='{idb}'>>>".format(
                idb=insert_dict['idb']),
            'idTI' : "<<<SELECT idTI FROM INTERACTION_TYPES WHERE psimi = '{psimi}'>>>".format(
                psimi = insert_dict['psimitype'])
            
        })

        tuples_list.append(insert_dict)

    
    interaction_insert=column_subset(tuples_list, (None, 'intact', 'imex', 'idP', 'idP_PROTEINS', 'idTI'))
    query = make_query('INTERACTIONS', interaction_insert)
    query=query.replace('"<<<', "(")
    query=query.replace('>>>"', ")")
    print(query)
    db.query_boolean(query)
    #insert_tuples(db, 'INTERACTIONS', tuples_list)

def diff_prot_ids(data):
    ids = set()
    for d in data:
        ids.add(d['idA'][0].split(':')[1])
        ids.add(d['idB'][0].split(':')[1])
    dbids = db.query_select("SELECT DISTINCT UniProtKBTrEMBL FROM PROTEINS")
    dbids = tuple(map(lambda a:a[0], dbids))
    print(dbids)
    return ids - set(dbids)

def insert_missing(ids):
    insert_list = []
    for i in ids:
        insert_list.append("('{i}')".format(i=i))
    insert_list= ",".join(insert_list)
    query = "INSERT INTO PROTEINS (UniProtKBTrEMBL) VALUES {insert}".format(insert=insert_list)
    print(query)
    db.query_boolean(query)

interactions = wjson.WrapperJSON("sources/interactions-PMID-17446270.json")

data = interactions.parse()['data']

process_detection_methods(data)
process_interaction_types(data)
#process_interaction(data)

insert_missing(diff_prot_ids(data))
