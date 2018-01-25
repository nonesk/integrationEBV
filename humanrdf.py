import wrappers.wrapper_rdf as wrdf
from functions import *

human = wrdf.WrapperRDF('sources/tp4.ttl')

query = """SELECT ?prot ?access WHERE{
    ?prot a :Protein .
    ?prot :replaces ?access
    }"""

# (rdflib.term.URIRef('http://purl.uniprot.org/uniprot/Q9UHV2'),
#  rdflib.term.URIRef('http://purl.uniprot.org/uniprot/Q9BUE7'))


for x in human.query_sparql(query):
    print(str(x))
    id1 = str(x[0])
    id2 = str(x[1])
    id1 = id1.split('/')[-1]
    id2 = id2.split('/')[-1]
    # print(id1)
    # print(id1)

def insert_human_names(db, table_acc, table_prot, human):
    query = """SELECT ?prot ?access WHERE{
        ?prot a :Protein .
        ?prot :replaces ?access
        }"""
    usage_names_list = []
    for x in human.query_sparql(query):
        id1 = str(x[0])
        id2 = str(x[1])
        id1 = id1.split('/')[-1]
        id2 = id2.split('/')[-1]
        usage_names_list.append(id1)
        insert_tuples()







