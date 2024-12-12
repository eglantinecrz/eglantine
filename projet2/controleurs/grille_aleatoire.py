
import random

from controleurs.includes import generate_grille
from controleurs.includes import add_activity


# Enregistre une activité dans l'historique de la session (consultation de la page configurer grille)
add_activity(SESSION['HISTORIQUE'], "consultation de la page configurer grille")

# Vérifie si un formulaire a été soumis avec les données de la grille
if POST and "grille" in POST :
    # Récupère les dimensions de la grille à partir du formulaire et les stocke dans les variables de session
    REQUEST_VARS['selec-long'] = int(POST['longueur'][0])  # Longueur de la grille (en x)
    REQUEST_VARS['selec-hauteur'] = int(POST['largeur'][0])  # Hauteur de la grille (en y)

    # Génère la grille avec les dimensions spécifiées et l'enregistre dans la session
    SESSION['grille'] = generate_grille(int(POST['longueur'][0]), int(POST['largeur'][0]))
    print(SESSION['grille'])  # Affiche la grille générée pour débogage

    # Calcule le nombre total de cases dans la grille
    nbcase = int(POST['longueur'][0]) * int(POST['largeur'][0])
    # Calcule le nombre cible aléatoire pour la grille (entre 10% et 20% du nombre total de cases)
    aleacible = int(random.uniform(nbcase * 0.1, nbcase * 0.2)) + 1
    print(nbcase)  # Affiche le nombre total de cases
    print(aleacible)  # Affiche le nombre cible aléatoire calculée

    # Génère des coordonnées aléatoires pour la position de la cible dans la grille
    REQUEST_VARS['cible-long'] = random.randint(0, int(POST['longueur'][0]) - 1)
    REQUEST_VARS['cible-hauteur'] = random.randint(0, int(POST['largeur'][0]) - 1)

    # Place la cible dans la grille à la position aléatoire
    SESSION['grille'][REQUEST_VARS['cible-hauteur']][REQUEST_VARS['cible-long']] = -1
    print(SESSION['grille'])  # Affiche la grille après avoir placé la cible

    # Liste des directions possibles pour déplacer la cible (haut, bas, gauche, droite)
    Listchoix = [(0, 1), (0, -1), (1, 0), (-1, 0)]
    print(len(Listchoix))  # Affiche le nombre de directions possibles

    # Crée les positions pour les autres cibles (aleacible - 1 autres cibles)
    for _ in range(aleacible - 1):
        # Crée une nouvelle liste temporaire de directions pour chaque cible
        listtemp = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        print(listtemp)  # Affiche la liste des directions disponibles pour cette cible
        
        # Tant qu'il y a des directions possibles
        while len(listtemp) != 0:
            # Choisit une direction aléatoire parmi les directions restantes
            direction = random.choice(listtemp)
            print(direction)  # Affiche la direction choisie pour débogage
            listtemp.remove(direction)  # Supprime cette direction de la liste des options restantes
            print(listtemp)  # Affiche la liste après suppression

            # Affiche les coordonnées actuelles de la cible pour le débogage
            print(REQUEST_VARS['cible-long'])
            print(REQUEST_VARS['cible-hauteur'])

            # Vérifie si la direction choisie permet de se déplacer sans sortir de la grille
            if((REQUEST_VARS['cible-long'] != 0) or (direction[1] != -1)):
                print("Droit d'aller à gauche")

                if((REQUEST_VARS['cible-long'] != REQUEST_VARS['selec-long'] - 1) or (direction[1] != 1)): 
                    print("Droit d'aller à droite")

                    if((REQUEST_VARS['cible-hauteur'] != 0) or (direction[0] != -1)):
                        print("Droit d'aller en haut")

                        if((REQUEST_VARS['cible-hauteur'] != REQUEST_VARS['selec-hauteur'] - 1) or (direction[0] != 1)):
                            print("Droit d'aller en bas")

                            # Vérifie si la nouvelle position choisie pour la cible n'est pas déjà occupée
                            if(SESSION['grille'][REQUEST_VARS['cible-hauteur'] + direction[0]][REQUEST_VARS['cible-long'] + direction[1]] != -1):
                                print("Pas déjà existant")

                                # Met à jour les coordonnées de la cible et la place dans la nouvelle case
                                REQUEST_VARS['cible-long'] += direction[1]
                                REQUEST_VARS['cible-hauteur'] += direction[0]
                                SESSION['grille'][REQUEST_VARS['cible-hauteur']][REQUEST_VARS['cible-long']] = -1
                                break  # Sort de la boucle while dès qu'une position valide est trouvée

            # Si aucune direction n'est valide (plus de directions possibles)
            if(len(listtemp) == 0):
                print("Impossible")  # Affiche un message d'erreur si aucune direction n'est possible



