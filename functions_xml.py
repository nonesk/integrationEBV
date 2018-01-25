import wrappers.wrapper_xml as wxml
from functions import *

def build_entries_list(db):
    """Construit une liste de dictionnaire contenant les informations
    d'une entrée de la base de donnée xml.
    """
    entries = db.query_xpath('.//entry')
    entries_list=[] # Liste des dictionnaires d'entrée

    for entry in entries:
        entry_dict={} # Dictionnaire d'une entrée
        entry_dict["accession"] = []

        # Récupération de la liste d'accession
        # La première accession correspond à la plus récente
        for accession in entry.findall('accession'):
            entry_dict["accession"].append(accession.text)

        # Récupération de la taille et de la mass
        sequence = entry.findall('sequence')[0]
        entry_dict["longueur"]=sequence.attrib['length']
        entry_dict["poids"]=sequence.attrib['mass']

        # Récupération des noms
        protein_name = entry.findall('protein/recommendedName')[0]
        if len(protein_name.findall('fullName')) > 0 :
            fullName = protein_name.findall('fullName')[0].text
            entry_dict["fullName"] = fullName
        if len(protein_name.findall('shortName')) > 0 :
            shortName = protein_name.findall('shortName')[0].text
            entry_dict["shortName"] = shortName

        # Ajout de l'entrée à la liste.
        entries_list.append(entry_dict)
    return entries_list


def update_prot_xml(db, prot_dict):
    for entry in prot_dict:
        idP = map_acc2idp(db, entry)
        query = 'UPDATE PROTEINS SET fullName="{fname}", poids={poids}, longueur={longueur} WHERE idP={idp}'.format(
            fname=entry['fullName'], poids=float(entry['poids']), longueur=int(entry['longueur']), idp=idP)
        print(query)
        query=query.replace('None', 'NULL')
        db.query_boolean(query)
def insert_acc(db, table_acc, table_prot, uniprot_dict):
    tuples_set = set()
    for entry in uniprot_dict:
        idP = map_acc2idp(db, entry)
        for accession in entry['accession']:
            tuples = (accession, idP)
            tuples_set.add(tuples)
        print(tuples)
    tuples_list = list(tuples_set)
    insert_tuples(db, table_acc, tuple(tuples_list))
