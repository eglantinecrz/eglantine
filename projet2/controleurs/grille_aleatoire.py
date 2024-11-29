import random
from controleurs.includes import generate_grille

if POST and 'grille' in POST:
    REQUEST_VARS['longueur_g']= int(POST['longueur'][0])
    REQUEST_VARS['hauteur_g']= int(POST['largeur'][0])
    REQUEST_VARS['colonne_aleatoire']  = random.randint(0,  REQUEST_VARS['longueur_g']-1)
    REQUEST_VARS['ligne_aleatoire']= random.randint(0, REQUEST_VARS['hauteur_g']-1)
    L= REQUEST_VARS['colonne_aleatoire']
    C = REQUEST_VARS['ligne_aleatoire']
    #print(REQUEST_VARS['hauteur_g'])
    REQUEST_VARS['nb_cases'] = REQUEST_VARS['longueur_g']*REQUEST_VARS['hauteur_g']
    print(REQUEST_VARS['nb_cases'])
    cibles_10 = int(0.1*REQUEST_VARS['nb_cases'])+1
    #print(cibles_10)
    cibles_20 = int(0.2*REQUEST_VARS['nb_cases'])+1
    #print(cibles_20)
    REQUEST_VARS['cibles'] = random.randint(cibles_10,cibles_20)
    print(REQUEST_VARS['cibles'])
    SESSION['grille']=generate_grille(REQUEST_VARS['longueur_g'],REQUEST_VARS['hauteur_g'])
    print(SESSION['grille'])
    

    SESSION['grille'][C][L] = -1
    print(SESSION['grille'][C][L])
    print(SESSION['grille'])
    print("ligne",C)
    print("colonne",L)
    direction = ['haut','bas','gauche','droite']
    
    while REQUEST_VARS['cibles'] >0 :
        r = random.choice(direction)
        
        if r=='haut':
            
            if L+1 >= REQUEST_VARS['hauteur_g']:
                
                direction1 = ['bas','gauche','droite']
                r = random.choice(direction1)
            
            if SESSION['grille'][C][L+1] == 0 :
                
                SESSION['grille'][C][L+1] = -1
                L=L+1
                REQUEST_VARS['cibles']=REQUEST_VARS['cibles']-1
            
            direction1 = ['bas','gauche','droite']
            r = random.choice(direction1)
        
        if r=='bas':
            
            if L-1 < 0:
                
                direction2 = ['haut','gauche','droite']
                r = random.choice(direction2)
            
            if SESSION['grille'][C][L-1] == 0 :
                SESSION['grille'][C][L-1] = -1
                L=L-1
                REQUEST_VARS['cibles']=REQUEST_VARS['cibles']-1
            
            direction2 = ['haut','gauche','droite']
            r = random.choice(direction2)
        
        if r=='gauche':
            
            if C-1 <0:
                
                direction3 = ['bas','haut','droite']
                r = random.choice(direction3)
            
            if SESSION['grille'][C-1][L] == 0 :
                
                SESSION['grille'][C-1][L] = -1
                C=C-1
                REQUEST_VARS['cibles']=REQUEST_VARS['cibles']-1
            
            direction3 = ['bas','haut','droite']
            r = random.choice(direction3)
        
        if r=='droite':
            
            if C+1 >= REQUEST_VARS['longueur_g']:
                
                direction4 = ['bas','gauche','haut']
                r = random.choice(direction4)
            
            if SESSION['grille'][C+1][L] == 0 :
               
                SESSION['grille'][C+1][L] = -1
                C=C+1
                REQUEST_VARS['cibles']=REQUEST_VARS['cibles']-1
            
            direction4 = ['bas','gauche','haut']
            r = random.choice(direction4)


    


