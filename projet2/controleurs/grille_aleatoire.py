
import random

from controleurs.includes import generate_grille

if POST and "grille" in POST :
    REQUEST_VARS['selec-long'] = int(POST['longueur'][0])
    REQUEST_VARS['selec-hauteur'] = int(POST['largeur'][0])
    SESSION['grille'] = generate_grille(int(POST['longueur'][0]) , int(POST['largeur'][0]))
    print(SESSION['grille'])



    nbcase = int(POST['longueur'][0]) * int(POST['largeur'][0])
    aleacible = int(random.uniform(nbcase*0.1,nbcase*0.2)) +1 

    REQUEST_VARS['cible-long'] = random.randint(0,int(POST['longueur'][0])-1)
    REQUEST_VARS['cible-hauteur'] = random.randint(0,int(POST['largeur'][0])-1)



    SESSION['grille'][REQUEST_VARS['cible-hauteur']][REQUEST_VARS['cible-long']] = -1 
    print(SESSION['grille'])

    Listchoix = [(0,1),(0,-1),(1,0),(-1,0)]
    print(len(Listchoix))


    for _ in range(aleacible - 1):
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

                if((REQUEST_VARS['cible-long'] != REQUEST_VARS['selec-long']-1) or (direction[1] != 1)) : 
                    print("droit d'aller a droite")

                    if( (REQUEST_VARS['cible-hauteur'] != 0) or (direction[0] != -1) ) :
                        print("droit d'aller en haut")

                        if((REQUEST_VARS['cible-hauteur'] != REQUEST_VARS['selec-hauteur']-1) or (direction[0] != 1)) :
                            print("droit d'aller en bas ")

                            if( SESSION['grille'][REQUEST_VARS['cible-hauteur'] + direction[0] ][REQUEST_VARS['cible-long'] + direction[1]] != -1 ):
                                print("pas deja existant")
                                REQUEST_VARS['cible-long'] += direction[1]
                                REQUEST_VARS['cible-hauteur'] += direction[0]
                                SESSION['grille'][REQUEST_VARS['cible-hauteur']][ REQUEST_VARS['cible-long']] = -1 
                                break
            if(len(listtemp) ==0):
                print("IMPOSSIBLE")


