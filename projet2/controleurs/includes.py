def generate_grille(longueur,hauteur):
    grille = []
    for i in range(hauteur):
        Ligne = []
        for j in range(longueur):
            Ligne.append(0)
        grille.append(Ligne)
    return grille


def add_activity(session_histo, activity):
    """
    Ajoute l'activité activity dans l'historique de session avec la date courante (comme clé)
    """
    from datetime import datetime
    d = datetime.now()
    session_histo[d] = activity

def ajouter_partie_dans_session(session_partie, id_partie, score, id_gagnant):
    if 'HISTORIQUE' not in SESSION:
        SESSION['HISTORIQUE'] = {}
    
    # Ajouter la partie à l'historique de la session
    SESSION['HISTORIQUE'][id_partie] = {
        'score': score,
        'id_gagnant': id_gagnant,
        'date': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }
