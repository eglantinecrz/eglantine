from model.model_pg import get_joueur
from controleurs.includes import generate_grille
from model.model_pg import get_4briques_aleatoires
from model.model_pg import get_brique_aleatoire
import random
from controleurs.includes import add_activity


add_activity(SESSION['HISTORIQUE'], "consultation de la page configurer une partie")

# Initialiser le nombre de parties s'il n'existe pas déjà dans la session
if 'nb_parties' not in SESSION:
    SESSION['nb_parties'] = 0

if 'joueur' not in SESSION:
  
    res = get_joueur(SESSION['CONNEXION'])
    SESSION['joueur'] = res

if POST and "configuration" in POST:
    SESSION['nb_parties'] = SESSION['nb_parties'] + 1
    print("numero partie",SESSION['nb_parties'])
    SESSION['selec-long'] = int(POST['longueur'][0])
    SESSION['selec-hauteur'] = int(POST['largeur'][0])
    SESSION['difficulte'] = POST['difficulte'][0]
    SESSION['selec_joueur'] = POST['joueur'][0]
    """SESSION['id_joueur'] = POST ['joueur'][1]"""
    print(SESSION['selec_joueur'])
    print(SESSION['selec-long'])
    print(SESSION['selec-hauteur'])
    print(SESSION['difficulte'])
    
    SESSION['configuration'] = generate_grille(int(POST['longueur'][0]) , int(POST['largeur'][0]))
    print(SESSION['configuration'])
  

    SESSION['nb-tour'] = 1
    SESSION['nb_tour_max'] = 25
    


    nbcase = int(POST['longueur'][0]) * int(POST['largeur'][0])
    SESSION['aleacible'] = int(random.uniform(nbcase*0.1,nbcase*0.2)) +1 
    print(nbcase)
    print(SESSION['aleacible'])

    REQUEST_VARS['cible-long'] = random.randint(0,int(POST['longueur'][0])-1)
    REQUEST_VARS['cible-hauteur'] = random.randint(0,int(POST['largeur'][0])-1)



    SESSION['configuration'][REQUEST_VARS['cible-hauteur']][REQUEST_VARS['cible-long']] = -1 
    print(SESSION['configuration'])

    Listchoix = [(0,1),(0,-1),(1,0),(-1,0)]
    print(len(Listchoix))


    for _ in range(SESSION['aleacible'] - 1):
        listtemp = [(0,1),(0,-1),(1,0),(-1,0)]
        print(listtemp)
        while len(listtemp) != 0 :

            direction = random.choice(listtemp)

            print(direction)
            listtemp.remove(direction)
            print(listtemp)
            print(REQUEST_VARS['cible-long'])
            print(REQUEST_VARS['cible-hauteur'])


            if((REQUEST_VARS['cible-long'] != 0) or (direction[1] != -1) ):
                print("droit d'aller a gauche")

                if((REQUEST_VARS['cible-long'] != SESSION['selec-long']-1) or (direction[1] != 1)) : 
                    print("droit d'aller a droite")

                    if( (REQUEST_VARS['cible-hauteur'] != 0) or (direction[0] != -1) ) :
                        print("droit d'aller en haut")

                        if((REQUEST_VARS['cible-hauteur'] != SESSION['selec-hauteur']-1) or (direction[0] != 1)) :
                            print("droit d'aller en bas ")

                            if( SESSION['configuration'][REQUEST_VARS['cible-hauteur'] + direction[0] ][REQUEST_VARS['cible-long'] + direction[1]] != -1 ):
                                print("pas deja existant")
                                REQUEST_VARS['cible-long'] += direction[1]
                                REQUEST_VARS['cible-hauteur'] += direction[0]
                                SESSION['configuration'][REQUEST_VARS['cible-hauteur']][ REQUEST_VARS['cible-long']] = -1 
                                break
            if(len(listtemp) ==0):
                print("IMPOSSIBLE")


    print(SESSION['configuration'])
   
