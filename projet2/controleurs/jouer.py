# from model.model_pg import get_instances, get_episodes_for_num
# from controleurs.includes import add_activity
from model.model_pg import get_4briques_aleatoires
from model.model_pg import get_brique_aleatoire
#from tabulate import tabulate
nb_line = 8
nb_column = 9
tableau = []

for i in range(nb_line):
    tableau.insert(i, [])
    for j in range(nb_column):
        tableau[i].insert(j," ")


res = get_4briques_aleatoires(SESSION['CONNEXION'])
SESSION['briques_ale'] = res


res = get_brique_aleatoire(SESSION['CONNEXION'])
REQUEST_VARS['brique_unique'] = res


#if 'briques_ale' not in SESSION :
 #   SESSION['briques_ale'] = get_4briques_aleatoires(SESSION['CONNEXION'])

#if POST and 



