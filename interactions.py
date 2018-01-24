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



interactions = wjson.WrapperJSON("sources/interactions-PMID-17446270.json")

data = interactions.parse()['data']

process_detection_methods(data)
