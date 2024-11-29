"""
ce fichier est vide, il faudra y mettre du code (question TP5)
"""
from model.model_pg import count_instances
from model.model_pg import get_5top_couleur
from model.model_pg import get_stat_joueur
from model.model_pg import get_moyenne_mois_annee
from model.model_pg import get_top3_parties


res = count_instances(SESSION['CONNEXION'], 'joueuse')
nb_joueurs = res[0][0] # result is a list of tuples with attributes
REQUEST_VARS['nb.j'] = nb_joueurs

res = count_instances(SESSION['CONNEXION'], 'tour')
nb_tours = res[0][0] # result is a list of tuples with attributes
REQUEST_VARS['nb.t'] = nb_tours

res = count_instances(SESSION['CONNEXION'], 'partie')
nb_parties = res[0][0] # result is a list of tuples with attributes
REQUEST_VARS['nb.p'] = nb_parties

res = get_5top_couleur(SESSION['CONNEXION'])
REQUEST_VARS['top_couleurs'] = res

res = get_stat_joueur(SESSION['CONNEXION'])
REQUEST_VARS['stats_joueur'] = res

res = get_moyenne_mois_annee(SESSION['CONNEXION'])
REQUEST_VARS['stat_m_a'] = res

res = get_top3_parties(SESSION['CONNEXION'])
REQUEST_VARS['stat_parties'] = res

