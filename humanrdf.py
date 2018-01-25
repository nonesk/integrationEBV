import wrappers.wrapper_rdf as wrdf
from functions import *

human = wrdf.WrapperRDF('sources/tp4.ttl')

query = """SELECT ?prot ?access WHERE{
    ?prot a :Protein .
    ?prot :replaces ?access
    }"""

for x in human.query_sparql(query):
    t = list(map())
