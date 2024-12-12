from model.model_pg import insert_joueur
from model.model_pg import get_joueur_by_name
from model.model_pg import count_instances
from datetime import datetime
from time import strftime
from controleurs.includes import add_activity


# Ajout d'une activité dans l'historique de la session (par exemple : consultation de la page ajouter joueur)
add_activity(SESSION['HISTORIQUE'], "consultation de la page ajouter joueur")

# Vérification si le formulaire a été soumis (bouton 'bouton_valider' présent dans les données POST)
if POST and 'bouton_valider' in POST:  
    # Récupération du nom du joueur soumis par le formulaire
    nom_joueur = POST['nom'][0]  # ATTENTION : POST['nom'] retourne une liste, on prend le premier élément (le nom du joueur)
    
    # Comptage du nombre de joueurs dans la base de données (on suppose qu'il y a une table 'joueuse')
    res = count_instances(SESSION['CONNEXION'], 'joueuse') 
    nb_joueurs = res[0][0]  # Récupération du nombre de joueurs
    REQUEST_VARS['nb.j'] = nb_joueurs + 1  # Création d'un identifiant unique pour le joueur (basé sur le nombre actuel de joueurs dans la BD)
    
    print(nom_joueur)  # Affichage du nom du joueur (pour debug)

    # Vérification si le joueur existe déjà dans la base de données avec le même nom
    joueur_existe = get_joueur_by_name(SESSION['CONNEXION'], nom_joueur)
    
    # Récupération de la date actuelle (au format 'YYYY-MM-DD')
    d = datetime.now().strftime('%Y-%m-%d')
    print(d)  # Affichage de la date actuelle (pour debug)
    
    # Si le joueur n'existe pas déjà (joueur_existe est vide), on procède à l'ajout
    if joueur_existe is not None and len(joueur_existe) == 0:  
        # Insertion du nouveau joueur dans la base de données
        joueur_ajout = insert_joueur(SESSION['CONNEXION'], REQUEST_VARS['nb.j'], d, nom_joueur)
        
        print(joueur_ajout)  # Affichage du résultat de l'ajout (pour debug)

        # Si l'insertion du joueur a réussi (joueur_ajout > 0)
        if joueur_ajout and joueur_ajout > 0:
            # Message de succès
            REQUEST_VARS['message'] = f"Le joueur {nom_joueur} a bien été ajouté !"
            REQUEST_VARS['message_class'] = "alert-success"
        else:  # Si l'insertion échoue
            # Message d'erreur
            REQUEST_VARS['message'] = f"Erreur lors de l'insertion du joueur {nom_joueur}."
            REQUEST_VARS['message_class'] = "alert-error"




 



