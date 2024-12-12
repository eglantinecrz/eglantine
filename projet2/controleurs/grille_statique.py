from model.model_pg import get_4briques_aleatoires
from model.model_pg import get_brique_aleatoire
from controleurs.includes import add_activity


add_activity(SESSION['HISTORIQUE'], "consultation de la page jouer")



"""if 'briques_ale' not in SESSION:
    res = get_4briques_aleatoires(SESSION['CONNEXION'])
    SESSION['briques_ale'] = res



if POST and "bouton1" in POST :
    
    brique_selectionne= int(POST['nom'][0])
   
    
    for t in SESSION['briques_ale']:
        print (t[0])
        if t[0] == brique_selectionne:
            SESSION['briques_ale'].remove(t)
            res = get_brique_aleatoire(SESSION['CONNEXION'])
            REQUEST_VARS['brique_unique'] = res 
            SESSION['briques_ale'].append(REQUEST_VARS['brique_unique'])

    print(POST['nom'][0])"""


