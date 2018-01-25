import wrappers.wrapper_sql as wsql
from subprocess import call, Popen
from functions import *
from functions_xml import *


# CONNECT
db = wsql.WrapperSQLite('kanar.db')
genbank = wsql.WrapperSQLite('sources/genbank.sqlite')
uniprot = wxml.WrapperXML('sources/niktamere.xml')

prot_dict = build_entries_list(uniprot)

print(map_acc2idp(db, prot_dict[38]))
