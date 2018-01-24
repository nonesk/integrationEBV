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
            subset.append(t[k])
        result.append(tuple(subset))
    return result


## GENBANK

# Genes preprocess
