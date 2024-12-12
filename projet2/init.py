"""
Ficher initialisation (eg, constantes chargées au démarrage dans la session)
"""

from datetime import datetime
from os import path

SESSION['APP'] = "Jeu de briques"
SESSION['BASELINE'] = "Faites votre meilleur score !"
SESSION['DIR_HISTORIQUE'] = path.join(SESSION['DIRECTORY'], "historiques")
SESSION['HISTORIQUE'] = dict()
SESSION['CURRENT_YEAR'] = datetime.now().year
