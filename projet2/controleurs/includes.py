def generate_grille(longueur,hauteur):
    grille = []
    for i in range(hauteur):
        Ligne = []
        for j in range(longueur):
            Ligne.append(0)
        grille.append(Ligne)
    return grille



