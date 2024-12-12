
import random


from model.model_pg import get_4briques_aleatoires
from model.model_pg import get_brique_aleatoire
from model.model_pg import get_4briques_aleatoires_difficile
from model.model_pg import get_brique_aleatoire_difficle
from model.model_pg import insert_tour
from controleurs.includes import ajouter_partie_dans_session
from datetime import datetime
from time import strftime

# Si l'utilisateur a cliqué sur le bouton "abandonner"
if POST and "abandon" in POST:
    # Réinitialise les variables liées au nombre de tours
    SESSION['nb_tour_max'] = 0
    SESSION['nb-tour'] = 999
    


    
# Début du traitement pour la difficulté "facile"
if SESSION['difficulte'] == "facile":
    if SESSION['aleacible'] > 0:
        if SESSION['nb_tour_max']>0 :
            # Si les briques aléatoires n'ont pas encore été générées, on les récupère
            if 'briques_ale' not in SESSION:
                res = get_4briques_aleatoires(SESSION['CONNEXION'])
                SESSION['briques_ale'] = res

            # Traitement lorsque le bouton1 est cliqué
            if POST and "bouton1" in POST:
                brique_selectionne = int(POST['nom'][0])

                # Recherche et remplacement de la brique sélectionnée dans la liste
                for t in SESSION['briques_ale']:
                    if t[0] == brique_selectionne:
                        SESSION['briques_ale'].remove(t)
                        res = get_brique_aleatoire(SESSION['CONNEXION'])
                        REQUEST_VARS['brique_unique'] = res
                        SESSION['briques_ale'].append(REQUEST_VARS['brique_unique'][0])

                # Mise à jour du nombre de tours
                SESSION['nb-tour'] += 1
                SESSION['nb_tour_max'] -= 1
                print(POST['nom'][0])
                print(POST)

            # Traitement lorsque le bouton "place" est cliqué
            if POST and "place" in POST:
                brique_selectionne = int(POST['nom'][0])
                
                # Recherche et placement de la brique sélectionnée
                for t in SESSION['briques_ale']:
                    if t[0] == brique_selectionne:
                        SESSION['brique-selec'] = t
                        SESSION['briques_ale'].remove(t)
                        res = get_brique_aleatoire(SESSION['CONNEXION'])
                        REQUEST_VARS['brique_unique'] = res
                        SESSION['briques_ale'].append(REQUEST_VARS['brique_unique'][0])

                # Mise à jour du nombre de tours
                SESSION['nb-tour'] += 1
                SESSION['nb_tour_max'] -= 1
                print(POST)
                print(SESSION['brique-selec'])

                # Vérification du nombre de cases de la brique et des cases hachurées
                nb_cases_brique = SESSION['brique-selec'][1] * SESSION['brique-selec'][2]
                print(nb_cases_brique)
                nb_cases_hachurees = len(POST["cases"])
                print(nb_cases_hachurees)
                print(POST["cases"])

                # Trie et préparation des cases à placer
                liste_triee = sorted(POST["cases"])

                if nb_cases_brique == nb_cases_hachurees:
                    print('ok')
                    liste_tuples = [tuple(map(int, case.split(','))) for case in liste_triee]
                    print(liste_tuples)

                    # Calcul de la longueur et largeur uniques des cases à placer
                    longueur = {coord[0] for coord in liste_tuples}
                    largeur = {coord[1] for coord in liste_tuples}
                    print(longueur)
                    print(largeur)

                    longueur_cases = len(longueur)
                    largeur_cases = len(largeur)
                    print(longueur_cases)
                    print(largeur_cases)

                    # Vérifie si la brique correspond bien aux cases sélectionnées
                    if longueur_cases == SESSION['brique-selec'][1] and largeur_cases == SESSION['brique-selec'][2]:
                        for i in liste_tuples:
                            print(i)
                            print(i[0])
                            print(i[1])
                            # Mise à jour de la configuration avec la brique placée
                            SESSION['configuration'][i[1]][i[0]] = (SESSION['brique-selec'][0],SESSION['brique-selec'][3])
                            print(SESSION['configuration'])

                        SESSION['aleacible'] =  SESSION['aleacible'] - nb_cases_hachurees
                        # Vérification si toutes les cases aléatoires ont été utilisées
        else :
            SESSION['nb-tour'] = 999
            print(SESSION['nb-tour'])

# Début du traitement pour la difficulté "difficile"
if SESSION['difficulte'] == "difficile":
    if SESSION['nb_tour_max'] > 0:
        if SESSION['aleacible']>0 :
            # Si les briques aléatoires n'ont pas encore été générées, on les récupère
            if 'briques_ale' not in SESSION:
                res = get_4briques_aleatoires_difficile(SESSION['CONNEXION'])
                SESSION['briques_ale'] = res

            # Traitement lorsque le bouton1 est cliqué
            if POST and "bouton1" in POST:
                brique_selectionne = int(POST['nom'][0])

                # Recherche et remplacement de la brique sélectionnée dans la liste
                for t in SESSION['briques_ale']:
                    if t[0] == brique_selectionne:
                        SESSION['briques_ale'].remove(t)
                        res = get_brique_aleatoire_difficle(SESSION['CONNEXION'])
                        REQUEST_VARS['brique_unique'] = res
                        SESSION['briques_ale'].append(REQUEST_VARS['brique_unique'][0])

                # Mise à jour du nombre de tours
                SESSION['nb-tour'] += 1
                SESSION['nb_tour_max'] -= 1
                print(POST['nom'][0])
                print(POST)

            # Traitement lorsque le bouton "place" est cliqué
            if POST and "place" in POST:
                brique_selectionne = int(POST['nom'][0])

                # Recherche et placement de la brique sélectionnée
                for t in SESSION['briques_ale']:
                    if t[0] == brique_selectionne:
                        SESSION['brique-selec'] = t
                        SESSION['briques_ale'].remove(t)
                        res = get_brique_aleatoire_difficle(SESSION['CONNEXION'])
                        REQUEST_VARS['brique_unique'] = res
                        SESSION['briques_ale'].append(REQUEST_VARS['brique_unique'][0])

                # Mise à jour du nombre de tours
                SESSION['nb-tour'] += 1
                SESSION['nb_tour_max'] -= 1
                print(POST)
                print(SESSION['brique-selec'])

                # Vérification du nombre de cases de la brique et des cases hachurées
                nb_cases_brique = SESSION['brique-selec'][1] * SESSION['brique-selec'][2]
                print(nb_cases_brique)
                nb_cases_hachurees = len(POST["cases"])
                print(nb_cases_hachurees)
                print(POST["cases"])

                # Trie et préparation des cases à placer
                liste_triee = sorted(POST["cases"])

                if nb_cases_brique == nb_cases_hachurees:
                    print('ok')
                    liste_tuples = [tuple(map(int, case.split(','))) for case in liste_triee]
                    print(liste_tuples)

                    # Calcul de la longueur et largeur uniques des cases à placer
                    longueur = {coord[0] for coord in liste_tuples}
                    largeur = {coord[1] for coord in liste_tuples}
                    print(longueur)
                    print(largeur)

                    longueur_cases = len(longueur)
                    largeur_cases = len(largeur)
                    print(longueur_cases)
                    print(largeur_cases)

                    # Vérifie si la brique correspond bien aux cases sélectionnées
                    if longueur_cases == SESSION['brique-selec'][1] and largeur_cases == SESSION['brique-selec'][2]:
                        for i in liste_tuples:
                            print(i)
                            print(i[0])
                            print(i[1])
                            # Mise à jour de la configuration avec la brique placée
                            SESSION['configuration'][i[1]][i[0]] =(SESSION['brique-selec'][0],SESSION['brique-selec'][3])
                            print(SESSION['configuration'])

                        SESSION['aleacible'] =  SESSION['aleacible'] - nb_cases_hachurees
    else :# Réinitialisation du nombre de tours après chaque action
        SESSION['nb-tour'] = 999

            


         



    
