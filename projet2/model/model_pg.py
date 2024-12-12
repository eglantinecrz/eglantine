import psycopg
from psycopg import sql
from logzero import logger
from datetime import datetime

def execute_select_query(connexion, query, params=[]):
    """
    Méthode générique pour exécuter une requête SELECT (qui peut retourner plusieurs instances).
    Utilisée par des fonctions plus spécifiques.
    """
    with connexion.cursor() as cursor:
        try:
            cursor.execute(query, params)
            result = cursor.fetchall()
            return result 
        except psycopg.Error as e:
            logger.error(e)
    return None

def execute_other_query(connexion, query, params=[]):
    """
    Méthode générique pour exécuter une requête INSERT, UPDATE, DELETE.
    Utilisée par des fonctions plus spécifiques.
    """
    with connexion.cursor() as cursor:
        try:
            cursor.execute(query, params)
            result = cursor.rowcount
            return result 
        except psycopg.Error as e:
            logger.error(e)
    return None

def get_instances(connexion, nom_table):
    """
    Retourne les instances de la table nom_table
    String nom_table : nom de la table
    """
    query = sql.SQL('SELECT * FROM {table}').format(table=sql.Identifier(nom_table), )
    return execute_select_query(connexion, query)

def count_instances(connexion, nom_table):
    """
    Retourne le nombre d'instances de la table nom_table
    String nom_table : nom de la table
    """
    query = sql.SQL('SELECT COUNT(*) AS nb FROM {table}').format(table=sql.Identifier(nom_table))
    return execute_select_query(connexion, query)

def get_episodes_for_num(connexion, numero):
    """
    Retourne le titre des épisodes numérotés numero
    Integer numero : numéro des épisodes
    """
    query = 'SELECT titre FROM episodes where numéro=%s'
    return execute_select_query(connexion, query, [numero])

def get_serie_by_name(connexion, nom_serie):
    """
    Retourne les informations sur la série nom_serie (utilisé pour vérifier qu'une série existe)
    String nom_serie : nom de la série
    """
    query = 'SELECT * FROM series where nomsérie=%s'
    return execute_select_query(connexion, query, [nom_serie])

def insert_serie(connexion, nom_serie):
    """
    Insère une nouvelle série dans la BD
    String nom_serie : nom de la série
    Retourne le nombre de tuples insérés, ou None
    """
    query = 'INSERT INTO series VALUES(%s)'
    return execute_other_query(connexion, query, [nom_serie])

def get_table_like(connexion, nom_table, like_pattern):
    """
    Retourne les instances de la table nom_table dont le nom correspond au motif like_pattern
    String nom_table : nom de la table
    String like_pattern : motif pour une requête LIKE
    """
    motif = '%' + like_pattern + '%'
    nom_att = 'nomsérie'  # nom attribut dans séries (à éviter)
    if nom_table == 'actrices':  # à éviter
        nom_att = 'nom'  # nom attribut dans actrices (à éviter)
    query = sql.SQL("SELECT * FROM {} WHERE {} ILIKE {}").format(
        sql.Identifier(nom_table),
        sql.Identifier(nom_att),
        sql.Placeholder())
    #    like_pattern=sql.Placeholder(name=like_pattern))
    return execute_select_query(connexion, query, [motif])

def get_5top_couleur(connexion):
    # query = sql.SQL('SELECT couleur, COUNT(*) AS nombre_briques FROM {table} GROUP BY couleur ORDER BY nombre_briques DESC LIMIT 5').format(table=sql.Identifier(nom_table))
    query = 'SELECT couleur, COUNT(*) AS nombre_briques FROM piece GROUP BY couleur ORDER BY nombre_briques DESC LIMIT 5'
    return execute_select_query(connexion, query)

def get_stat_joueur(connexion):
    query = 'select j.id_gagnante, j.prénom, MIN(p.scores) AS score_minimal, MAX(p.scores) AS score_maximal FROM JOUEUSE j JOIN PARTIE p ON j.id_gagnante = p.id_gagnante group by j.id_gagnante, j.prénom'
    return execute_select_query(connexion, query)


def get_4briques_aleatoires(connexion):
    query = 'SELECT Id_brique, longueur, largeur, couleur FROM Brique WHERE longueur <= 2 AND largeur <= 2 ORDER BY RANDOM() LIMIT 4'
    return execute_select_query(connexion,query)

def get_brique_aleatoire(connexion):
    query = 'SELECT Id_brique, longueur, largeur, couleur FROM Brique WHERE longueur <= 2 AND largeur <= 2 ORDER BY RANDOM() LIMIT 1'
    return execute_select_query(connexion,query)

def get_moyenne_mois_annee(connexion):
    query = 'SELECT EXTRACT(YEAR FROM p.DateDeb) AS annee, EXTRACT(MONTH FROM p.DateDeb) AS mois, COUNT(t.Numéro) / COUNT(DISTINCT p.Id_partie) AS nb_moyen_tours FROM PARTIE p JOIN TOUR t ON t.Id_partie = p.Id_partie GROUP BY EXTRACT(YEAR FROM p.DateDeb), EXTRACT(MONTH FROM p.DateDeb) ORDER BY annee, mois'
    return execute_select_query(connexion,query)

def get_top3_parties(connexion):
    query = 'SELECT p.Id_partie, SUM(b.longueur * b.largeur) AS surface_briques, COUNT(DISTINCT h.Id_brique) AS nb_briques_utilisees FROM PARTIE p JOIN TOUR t ON t.Id_partie = p.Id_partie JOIN Historiser h ON h.Id_partie = t.Id_partie AND h.Numéro = t.Numéro JOIN Brique b ON b.Id_brique = h.Id_brique GROUP BY p.Id_partie ORDER BY surface_briques DESC, nb_briques_utilisees DESC LIMIT 3'
    return execute_select_query(connexion,query)

def get_plus_petit_defausse(connexion):
    query = 'SELECT Id_partie, COUNT(*) AS nb_defaussées FROM legos.Historiser WHERE action = \'défaussée\' GROUP BY Id_partie ORDER BY nb_defaussées ASC LIMIT 1'
    return execute_select_query(connexion,query)

def get_plus_grand_defausse(connexion):
    query = 'SELECT Id_partie, COUNT(*) AS nb_defaussées FROM legos.Historiser WHERE action = \'défaussée\' GROUP BY Id_partie ORDER BY nb_defaussées DESC LIMIT 1'
    return execute_select_query(connexion,query)

def get_plus_grand_pioche(connexion):
    query = 'SELECT Id_partie, COUNT(*) AS nb_piochées FROM legos.Historiser WHERE action = \'piochée\' GROUP BY Id_partie ORDER BY nb_piochées DESC LIMIT 1'
    return execute_select_query(connexion,query)

def get_plus_petit_pioche(connexion):
    query = 'SELECT Id_partie, COUNT(*) AS nb_piochées FROM legos.Historiser WHERE action = \'piochée\' GROUP BY Id_partie ORDER BY nb_piochées ASC LIMIT 1'
    return execute_select_query(connexion,query)

def get_joueur(connexion,):
    query='select prénom, id_gagnante from joueuse'
    return execute_select_query(connexion,query)

def get_4briques_aleatoires_difficile(connexion):
    query = 'SELECT Id_brique, longueur, largeur, couleur FROM Brique  ORDER BY RANDOM() LIMIT 4'
    return execute_select_query(connexion,query)

def get_brique_aleatoire_difficle(connexion):
    query = 'SELECT Id_brique, longueur, largeur, couleur FROM Brique ORDER BY RANDOM() LIMIT 1'
    return execute_select_query(connexion,query)

def insert_joueur(connexion,id_gagnante,d, nom_joueur):
    
    """date=str(datetime.now())
    print(date)"""
    query = 'INSERT INTO legos.joueuse VALUES (%s,%s,%s,%s)'

    # Exécuter la requête
    return execute_other_query(connexion, query, [id_gagnante,d,nom_joueur,None])
    

def insert_tour(connexion,Id_partie,numero,id_gagnante):
    query = 'INSERT INTO legos.tour VALUES(%s,%s,%s)'
    return execute_other_query(connexion, query,[Id_partie, numero, id_gagnante])

def get_joueur_by_name(connexion,nom_joueur):
    query = 'SELECT * FROM joueuse where prénom=%s'
    return execute_select_query(connexion, query, [nom_joueur])

