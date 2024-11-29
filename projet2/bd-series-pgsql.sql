


DROP SCHEMA IF EXISTS legos CASCADE;
CREATE SCHEMA IF NOT EXISTS legos;
SET search_path TO legos;


CREATE TABLE piece(
   id serial primary key,
   longueur integer,
   largeur integer,
   hauteur float,
   couleur varchar(20)
);

/*INSERT INTO legos.Brique (Nom_brique, longueur, largeur, hauteur, forme, couleur, Mots_clefs)
SELECT 
    id::TEXT AS Nom_brique, -- Utilise l'id comme Nom_brique
    longueur AS longueur,
    largeur AS largeur,
    hauteur AS hauteur,
    NULL AS forme, -- Définit forme à NULL
    couleur AS couleur,
    NULL AS Mots_clefs -- Définit Mots_clefs à NULL
FROM piece.piece;*/



CREATE TABLE JOUEUSE(
   id_gagnante serial,
   Date_inscription date,
   Prénom VARCHAR(50),
   Avatar VARCHAR(50),
   PRIMARY KEY(id_gagnante)
);


CREATE TABLE Brique(
   Id_brique serial,
   Nom_brique VARCHAR(50),
   longueur integer,
   largeur integer,
   hauteur float,
   forme VARCHAR(50),
   couleur VARCHAR(20),
   Mots_clefs VARCHAR(50),
   PRIMARY KEY(Id_brique)
);



CREATE TABLE Usine(
   IdUsine VARCHAR(50),
   Ville VARCHAR(50),
   Pays VARCHAR(50),
   PRIMARY KEY(IdUsine)
);

CREATE TABLE Construction(
   id_construction VARCHAR(50),
   NomConst VARCHAR(50),
   themeconst VARCHAR(50),
   description VARCHAR(50),
   anneesortie VARCHAR(50),
   dim1 VARCHAR(50),
   dim2 VARCHAR(50),
   dim3 VARCHAR(50),
   PRIMARY KEY(id_construction)
);

CREATE TABLE OFFICIELLES(
   id_construction VARCHAR(50),
   agerecomm VARCHAR(50),
   PRIMARY KEY(id_construction),
   FOREIGN KEY(id_construction) REFERENCES Construction(id_construction)
);

CREATE TABLE AMATEUR(
   id_construction VARCHAR(50),
   Createur VARCHAR(50),
   licence VARCHAR(50),
   PRIMARY KEY(id_construction),
   FOREIGN KEY(id_construction) REFERENCES Construction(id_construction)
);

CREATE TABLE ETAPE(
   id_construction VARCHAR(50),
   id_etape VARCHAR(50),
   numeroetape VARCHAR(50) NOT NULL,
   image VARCHAR(50),
   instructions VARCHAR(50),
   PRIMARY KEY(id_construction, id_etape),
   FOREIGN KEY(id_construction) REFERENCES Construction(id_construction)
);

CREATE TABLE Boites(
   idBoite VARCHAR(50),
   Nom VARCHAR(50),
   Prix VARCHAR(50),
   PRIMARY KEY(idBoite)
);

CREATE TABLE PHOTO(
   Path VARCHAR(50),
   Titre VARCHAR(50),
   DesciptPhoto VARCHAR(50),
   PRIMARY KEY(Path)
);

CREATE TABLE Configuration(
   id_config integer,
   PRIMARY KEY(id_config)
);

CREATE TABLE PARAMETRE(
   id_parametre VARCHAR(50),
   Propriété VARCHAR(50),
   Valeur VARCHAR(50),
   PRIMARY KEY(id_parametre)
);

CREATE TABLE SUBSITUTION(
   IdS VARCHAR(50),
   Nom VARCHAR(50),
   Commentaire VARCHAR(50),
   PRIMARY KEY(IdS)
);

CREATE TABLE PARTIE(
   Id_partie serial,
   DateDeb date,
   DateFin date,
   scores integer,
   id_gagnante serial,
   id_config integer NOT NULL,
   PRIMARY KEY(Id_partie),
   FOREIGN KEY(id_config) REFERENCES Configuration(id_config)
);

CREATE TABLE TOUR(
   Id_partie serial,
   Numéro integer,
   id_gagnante serial NOT NULL,
   PRIMARY KEY(Id_partie, Numéro),
   FOREIGN KEY(Id_partie) REFERENCES PARTIE(Id_partie),
   FOREIGN KEY(id_gagnante) REFERENCES JOUEUSE(id_gagnante)
);

CREATE TABLE déroule_entre(
   Id_partie serial,
   id_gagnante serial,
   PRIMARY KEY(Id_partie, id_gagnante),
   FOREIGN KEY(Id_partie) REFERENCES PARTIE(Id_partie),
   FOREIGN KEY(id_gagnante) REFERENCES JOUEUSE(id_gagnante)
);

CREATE TABLE est_fabriquée(
   Id_brique serial,
   DateFab VARCHAR(50),
   Quantité VARCHAR(50),
   IdUsine VARCHAR(50) NOT NULL,
   PRIMARY KEY(Id_brique),
   FOREIGN KEY(Id_brique) REFERENCES Brique(Id_brique),
   FOREIGN KEY(IdUsine) REFERENCES Usine(IdUsine)
);

CREATE TABLE vendue(
   id_construction VARCHAR(50),
   idBoite VARCHAR(50),
   PRIMARY KEY(id_construction, idBoite),
   FOREIGN KEY(id_construction) REFERENCES OFFICIELLES(id_construction),
   FOREIGN KEY(idBoite) REFERENCES Boites(idBoite)
);

CREATE TABLE Bri_accompagnée_de(
   Id_brique serial,
   Path VARCHAR(50),
   PRIMARY KEY(Id_brique, Path),
   FOREIGN KEY(Id_brique) REFERENCES Brique(Id_brique),
   FOREIGN KEY(Path) REFERENCES PHOTO(Path)
);

CREATE TABLE Const_accompagnée_de(
   id_construction VARCHAR(50),
   Path VARCHAR(50),
   PRIMARY KEY(id_construction, Path),
   FOREIGN KEY(id_construction) REFERENCES Construction(id_construction),
   FOREIGN KEY(Path) REFERENCES PHOTO(Path)
);

CREATE TABLE assembler(
   Id_brique serial,
   id_construction VARCHAR(50),
   PRIMARY KEY(Id_brique, id_construction),
   FOREIGN KEY(Id_brique) REFERENCES Brique(Id_brique),
   FOREIGN KEY(id_construction) REFERENCES Construction(id_construction)
);

CREATE TABLE Historiser(
   Id_partie serial,
   Numéro integer,
   action VARCHAR(50),
   Id_brique serial NOT NULL,
   PRIMARY KEY(Id_partie, Numéro),
   FOREIGN KEY(Id_partie, Numéro) REFERENCES TOUR(Id_partie, Numéro),
   FOREIGN KEY(Id_brique) REFERENCES Brique(Id_brique)
);

CREATE TABLE a_pour(
   id_config integer,
   id_parametre VARCHAR(50),
   PRIMARY KEY(id_config, id_parametre),
   FOREIGN KEY(id_config) REFERENCES Configuration(id_config),
   FOREIGN KEY(id_parametre) REFERENCES PARAMETRE(id_parametre)
);

CREATE TABLE remplacer(
   Id_brique serial,
   IdS VARCHAR(50),
   PRIMARY KEY(Id_brique, IdS),
   FOREIGN KEY(Id_brique) REFERENCES Brique(Id_brique),
   FOREIGN KEY(IdS) REFERENCES SUBSITUTION(IdS)
);

INSERT INTO legos.JOUEUSE VALUES(1,'2024-11-12','alexandre','alex');
INSERT INTO legos.JOUEUSE VALUES (2,'2024-11-20','anae','an');

INSERT INTO legos.brique VALUES(1, 'brique1', 2, 2, 2, 'carré', 'violet', 'rect');
INSERT INTO legos.brique VALUES(2, 'brique2', 1, 2, 3, 'pavé', 'rose', 'rect');
INSERT INTO legos.brique VALUES(3, 'brique3', 2, 1, 3, 'pavé', 'rouge', 'rect');
INSERT INTO legos.brique VALUES(4, 'brique4', 1, 1, 1, 'carré', 'jaune', 'rect');
INSERT INTO legos.brique VALUES(5, 'brique5', 2, 2, 3, 'pavé', 'vert', 'rect');
INSERT INTO legos.brique VALUES(6, 'brique6', 1, 2, 3, 'pavé', 'bleu', 'rect');

INSERT INTO legos.Configuration VALUES (1);
INSERT INTO legos.Configuration VALUES (2);
INSERT INTO legos.Configuration VALUES (3);
INSERT INTO legos.Configuration VALUES (4);

INSERT INTO legos.PARTIE VALUES(6, '2024-11-20','2024-11-20', 12, 1, 1);
INSERT INTO legos.PARTIE VALUES(7, '2024-11-21','2024-11-23', 11, 1, 1);
INSERT INTO legos.PARTIE VALUES(1, '2024-11-20','2024-11-20', 10, 1, 1);
INSERT INTO legos.PARTIE VALUES(2, '2024-11-21','2024-11-23', 3, 1, 1);
INSERT INTO legos.PARTIE VALUES(3, '2024-11-20','2024-11-20', 12, 2, 1);
INSERT INTO legos.PARTIE VALUES(4, '2024-11-21','2024-11-23', 11, 2, 1);
INSERT INTO legos.PARTIE VALUES(8, '2024-12-20','2024-11-20', 12, 1, 1);
INSERT INTO legos.PARTIE VALUES(9, '2024-11-21','2024-11-23', 11, 1, 1);
INSERT INTO legos.PARTIE VALUES(10, '2024-12-20','2024-11-20', 10, 1, 1);
INSERT INTO legos.PARTIE VALUES(11, '2024-11-21','2024-11-23', 3, 1, 1);
INSERT INTO legos.PARTIE VALUES(12, '2023-09-20','2024-11-20', 12, 2, 1);
INSERT INTO legos.PARTIE VALUES(13, '2023-11-21','2024-11-23', 11, 2, 1);



insert into legos.tour values (3,1,1);
insert into legos.tour values (4,1,2);
insert into legos.tour values (6,1,2);
insert into legos.tour values (7,2,1);
-- Tour 1 de la Partie 1
INSERT INTO legos.TOUR  VALUES(1, 1, 1);
-- Tour 2 de la Partie 1
INSERT INTO legos.TOUR VALUES(1, 2, 1);
-- Tour 3 de la Partie 1
INSERT INTO legos.TOUR  VALUES(1, 3, 1);*/


/*-- Tour 1 de la Partie 2
INSERT INTO legos.TOUR  VALUES(2, 1, 1);
-- Tour 2 de la Partie 2
INSERT INTO legos.TOUR  VALUES(2, 2, 1);
-- Tour 3 de la Partie 2
INSERT INTO legos.TOUR  VALUES(2, 3, 1);


-- Tour 2 de la Partie 3
INSERT INTO legos.TOUR  VALUES (3, 2, 2);
-- Tour 3 de la Partie 3
INSERT INTO legos.TOUR VALUES (3, 3, 2);



-- Tour 2 de la Partie 4
INSERT INTO legos.TOUR  VALUES (4, 2, 2);
-- Tour 3 de la Partie 4
INSERT INTO legos.TOUR  VALUES (4, 3, 2);






-- Tour 2 de la Partie 6
INSERT INTO legos.TOUR VALUES (6, 2, 2);
-- Tour 3 de la Partie 6
INSERT INTO legos.TOUR  VALUES (6, 3, 2);


-- Tour 1 de la Partie 7
INSERT INTO legos.TOUR  VALUES (7, 1, 1);

-- Tour 3 de la Partie 7
INSERT INTO legos.TOUR  VALUES (7, 3, 1);


-- Tour 1 de la Partie 8
INSERT INTO legos.TOUR  VALUES (8, 1, 1);
-- Tour 2 de la Partie 8
INSERT INTO legos.TOUR  VALUES (8, 2, 1);
-- Tour 3 de la Partie 8
INSERT INTO legos.TOUR  VALUES (8, 3, 1);


-- Tour 1 de la Partie 9
INSERT INTO legos.TOUR  VALUES(9, 1, 1);
-- Tour 2 de la Partie 9
INSERT INTO legos.TOUR  VALUES(9, 2, 1);
-- Tour 3 de la Partie 9
INSERT INTO legos.TOUR VALUES (9, 3, 1);


-- Tour 1 de la Partie 10
INSERT INTO legos.TOUR  VALUES (10, 1, 1);
-- Tour 2 de la Partie 10
INSERT INTO legos.TOUR  VALUES (10, 2, 1);
-- Tour 3 de la Partie 10
INSERT INTO legos.TOUR  VALUES (10, 3, 1);


-- Tour 1 de la Partie 11
INSERT INTO legos.TOUR  VALUES (11, 1, 2);
-- Tour 2 de la Partie 11
INSERT INTO legos.TOUR  VALUES (11, 2, 2);
-- Tour 3 de la Partie 11
INSERT INTO legos.TOUR  VALUES (11, 3, 2);


-- Tour 1 de la Partie 12
INSERT INTO legos.TOUR  VALUES (12, 1, 2);
-- Tour 2 de la Partie 12
INSERT INTO legos.TOUR  VALUES (12, 2, 2);
-- Tour 3 de la Partie 12
INSERT INTO legos.TOUR  VALUES (12, 3, 2);


-- Tour 1 de la Partie 13
INSERT INTO legos.TOUR  VALUES (13, 1, 2);
-- Tour 2 de la Partie 13
INSERT INTO legos.TOUR  VALUES (13, 2, 2);
-- Tour 3 de la Partie 13
INSERT INTO legos.TOUR  VALUES (13, 3, 2);



INSERT INTO legos.Historiser VALUES(1, 1, 'défaussée', 101);
INSERT INTO legos.Historiser VALUES(1, 2, 'piochée', 102);
INSERT INTO legos.Historiser VALUES(1, 3, 'piochée', 103);

-- Partie 2, Tour 1

INSERT INTO legos.Historiser VALUES(2, 1, 'défaussée', 104);
INSERT INTO legos.Historiser VALUES(2, 2, 'piochée', 105);
INSERT INTO legos.Historiser VALUES(2, 3, 'défaussée', 106);

-- Partie 3, Tour 1

INSERT INTO legos.Historiser VALUES(3, 1, 'piochée', 107);
INSERT INTO legos.Historiser VALUES(3, 2, 'défaussée', 108);

-- Partie 4, Tour 1

INSERT INTO legos.Historiser VALUES(4, 1, 'piochée', 109);
INSERT INTO legos.Historiser VALUES(4, 2, 'défaussée', 110);
INSERT INTO legos.Historiser VALUES(4, 3, 'piochée', 111);



-- Partie 6, Tour 1

INSERT INTO legos.Historiser VALUES(6, 1, 'piochée', 114);
INSERT INTO legos.Historiser VALUES(6, 2, 'défaussée', 115);
INSERT INTO legos.Historiser VALUES(6, 3, 'piochée', 116);

-- Partie 7, Tour 1

INSERT INTO legos.Historiser VALUES(7, 1, 'défaussée', 117);
INSERT INTO legos.Historiser VALUES(7, 2, 'piochée', 118);

-- Partie 8, Tour 1

INSERT INTO legos.Historiser VALUES(8, 1, 'piochée', 119);
INSERT INTO legos.Historiser VALUES(8, 2, 'défaussée', 120);

-- Partie 9, Tour 1

INSERT INTO legos.Historiser VALUES(9, 1, 'défaussée', 121);
INSERT INTO legos.Historiser VALUES(9, 2, 'piochée', 122);
INSERT INTO legos.Historiser VALUES(9, 3, 'défaussée', 123);

-- Partie 10, Tour 1

INSERT INTO legos.Historiser VALUES(10, 1, 'piochée', 124);
INSERT INTO legos.Historiser VALUES(10, 2, 'défaussée', 125);

-- Partie 11, Tour 1

INSERT INTO legos.Historiser VALUES(11, 1, 'piochée', 126);
INSERT INTO legos.Historiser VALUES(11, 2, 'défaussée', 127);

-- Partie 12, Tour 1

INSERT INTO legos.Historiser VALUES(12, 1, 'piochée', 128);
INSERT INTO legos.Historiser VALUES(12, 2, 'défaussée', 129);

-- Partie 13, Tour 1
INSERT INTO legos.Historiser VALUES(13, 1, 'piochée', 130);
INSERT INTO legos.Historiser VALUES(13, 2, 'défaussée', 131);


INSERT INTO piece.piece VALUES (1, 1, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (2, 2, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (3, 3, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (4, 4, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (5, 6, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (6, 8, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (7, 10, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (8, 12, 1, 1, '#000000');
INSERT INTO piece.piece VALUES (9, 1, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (10, 2, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (11, 3, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (12, 4, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (13, 6, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (14, 8, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (15, 10, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (16, 12, 2, 1, '#000000');
INSERT INTO piece.piece VALUES (17, 1, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (18, 2, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (19, 3, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (20, 4, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (21, 6, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (22, 8, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (23, 10, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (24, 12, 3, 1, '#000000');
INSERT INTO piece.piece VALUES (25, 1, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (26, 2, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (27, 3, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (28, 4, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (29, 6, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (30, 8, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (31, 10, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (32, 12, 4, 1, '#000000');
INSERT INTO piece.piece VALUES (33, 1, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (34, 2, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (35, 3, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (36, 4, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (37, 6, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (38, 8, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (39, 10, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (40, 12, 6, 1, '#000000');
INSERT INTO piece.piece VALUES (41, 1, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (42, 2, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (43, 3, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (44, 4, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (45, 6, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (46, 8, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (47, 10, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (48, 12, 8, 1, '#000000');
INSERT INTO piece.piece VALUES (49, 1, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (50, 2, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (51, 3, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (52, 4, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (53, 6, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (54, 8, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (55, 10, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (56, 12, 10, 1, '#000000');
INSERT INTO piece.piece VALUES (57, 1, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (58, 2, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (59, 3, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (60, 4, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (61, 6, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (62, 8, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (63, 10, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (64, 12, 12, 1, '#000000');
INSERT INTO piece.piece VALUES (65, 1, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (66, 2, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (67, 3, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (68, 4, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (69, 6, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (70, 8, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (71, 10, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (72, 12, 1, 0.33, '#000000');
INSERT INTO piece.piece VALUES (73, 1, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (74, 2, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (75, 3, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (76, 4, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (77, 6, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (78, 8, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (79, 10, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (80, 12, 2, 0.33, '#000000');
INSERT INTO piece.piece VALUES (81, 1, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (82, 2, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (83, 3, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (84, 4, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (85, 6, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (86, 8, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (87, 10, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (88, 12, 3, 0.33, '#000000');
INSERT INTO piece.piece VALUES (89, 1, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (90, 2, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (91, 3, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (92, 4, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (93, 6, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (94, 8, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (95, 10, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (96, 12, 4, 0.33, '#000000');
INSERT INTO piece.piece VALUES (97, 1, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (98, 2, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (99, 3, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (100, 4, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (101, 6, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (102, 8, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (103, 10, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (104, 12, 6, 0.33, '#000000');
INSERT INTO piece.piece VALUES (105, 1, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (106, 2, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (107, 3, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (108, 4, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (109, 6, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (110, 8, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (111, 10, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (112, 12, 8, 0.33, '#000000');
INSERT INTO piece.piece VALUES (113, 1, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (114, 2, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (115, 3, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (116, 4, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (117, 6, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (118, 8, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (119, 10, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (120, 12, 10, 0.33, '#000000');
INSERT INTO piece.piece VALUES (121, 1, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (122, 2, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (123, 3, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (124, 4, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (125, 6, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (126, 8, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (127, 10, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (128, 12, 12, 0.33, '#000000');
INSERT INTO piece.piece VALUES (129, 1, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (130, 2, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (131, 3, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (132, 4, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (133, 6, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (134, 8, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (135, 10, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (136, 12, 1, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (137, 1, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (138, 2, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (139, 3, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (140, 4, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (141, 6, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (142, 8, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (143, 10, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (144, 12, 2, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (145, 1, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (146, 2, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (147, 3, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (148, 4, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (149, 6, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (150, 8, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (151, 10, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (152, 12, 3, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (153, 1, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (154, 2, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (155, 3, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (156, 4, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (157, 6, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (158, 8, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (159, 10, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (160, 12, 4, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (161, 1, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (162, 2, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (163, 3, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (164, 4, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (165, 6, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (166, 8, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (167, 10, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (168, 12, 6, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (169, 1, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (170, 2, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (171, 3, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (172, 4, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (173, 6, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (174, 8, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (175, 10, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (176, 12, 8, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (177, 1, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (178, 2, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (179, 3, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (180, 4, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (181, 6, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (182, 8, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (183, 10, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (184, 12, 10, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (185, 1, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (186, 2, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (187, 3, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (188, 4, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (189, 6, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (190, 8, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (191, 10, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (192, 12, 12, 1, '#c0c0c0');
INSERT INTO piece.piece VALUES (193, 1, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (194, 2, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (195, 3, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (196, 4, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (197, 6, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (198, 8, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (199, 10, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (200, 12, 1, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (201, 1, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (202, 2, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (203, 3, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (204, 4, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (205, 6, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (206, 8, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (207, 10, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (208, 12, 2, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (209, 1, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (210, 2, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (211, 3, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (212, 4, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (213, 6, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (214, 8, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (215, 10, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (216, 12, 3, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (217, 1, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (218, 2, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (219, 3, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (220, 4, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (221, 6, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (222, 8, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (223, 10, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (224, 12, 4, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (225, 1, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (226, 2, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (227, 3, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (228, 4, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (229, 6, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (230, 8, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (231, 10, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (232, 12, 6, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (233, 1, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (234, 2, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (235, 3, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (236, 4, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (237, 6, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (238, 8, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (239, 10, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (240, 12, 8, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (241, 1, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (242, 2, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (243, 3, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (244, 4, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (245, 6, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (246, 8, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (247, 10, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (248, 12, 10, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (249, 1, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (250, 2, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (251, 3, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (252, 4, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (253, 6, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (254, 8, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (255, 10, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (256, 12, 12, 0.33, '#c0c0c0');
INSERT INTO piece.piece VALUES (257, 1, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (258, 2, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (259, 3, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (260, 4, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (261, 6, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (262, 8, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (263, 10, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (264, 12, 1, 1, '#ffffff');
INSERT INTO piece.piece VALUES (265, 1, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (266, 2, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (267, 3, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (268, 4, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (269, 6, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (270, 8, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (271, 10, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (272, 12, 2, 1, '#ffffff');
INSERT INTO piece.piece VALUES (273, 1, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (274, 2, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (275, 3, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (276, 4, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (277, 6, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (278, 8, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (279, 10, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (280, 12, 3, 1, '#ffffff');
INSERT INTO piece.piece VALUES (281, 1, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (282, 2, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (283, 3, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (284, 4, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (285, 6, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (286, 8, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (287, 10, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (288, 12, 4, 1, '#ffffff');
INSERT INTO piece.piece VALUES (289, 1, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (290, 2, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (291, 3, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (292, 4, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (293, 6, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (294, 8, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (295, 10, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (296, 12, 6, 1, '#ffffff');
INSERT INTO piece.piece VALUES (297, 1, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (298, 2, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (299, 3, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (300, 4, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (301, 6, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (302, 8, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (303, 10, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (304, 12, 8, 1, '#ffffff');
INSERT INTO piece.piece VALUES (305, 1, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (306, 2, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (307, 3, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (308, 4, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (309, 6, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (310, 8, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (311, 10, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (312, 12, 10, 1, '#ffffff');
INSERT INTO piece.piece VALUES (313, 1, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (314, 2, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (315, 3, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (316, 4, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (317, 6, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (318, 8, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (319, 10, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (320, 12, 12, 1, '#ffffff');
INSERT INTO piece.piece VALUES (321, 1, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (322, 2, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (323, 3, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (324, 4, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (325, 6, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (326, 8, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (327, 10, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (328, 12, 1, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (329, 1, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (330, 2, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (331, 3, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (332, 4, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (333, 6, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (334, 8, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (335, 10, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (336, 12, 2, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (337, 1, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (338, 2, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (339, 3, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (340, 4, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (341, 6, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (342, 8, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (343, 10, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (344, 12, 3, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (345, 1, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (346, 2, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (347, 3, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (348, 4, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (349, 6, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (350, 8, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (351, 10, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (352, 12, 4, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (353, 1, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (354, 2, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (355, 3, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (356, 4, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (357, 6, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (358, 8, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (359, 10, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (360, 12, 6, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (361, 1, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (362, 2, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (363, 3, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (364, 4, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (365, 6, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (366, 8, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (367, 10, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (368, 12, 8, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (369, 1, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (370, 2, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (371, 3, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (372, 4, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (373, 6, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (374, 8, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (375, 10, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (376, 12, 10, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (377, 1, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (378, 2, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (379, 3, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (380, 4, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (381, 6, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (382, 8, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (383, 10, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (384, 12, 12, 0.33, '#ffffff');
INSERT INTO piece.piece VALUES (385, 1, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (386, 2, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (387, 3, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (388, 4, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (389, 6, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (390, 8, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (391, 10, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (392, 12, 1, 1, '#8b4513');
INSERT INTO piece.piece VALUES (393, 1, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (394, 2, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (395, 3, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (396, 4, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (397, 6, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (398, 8, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (399, 10, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (400, 12, 2, 1, '#8b4513');
INSERT INTO piece.piece VALUES (401, 1, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (402, 2, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (403, 3, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (404, 4, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (405, 6, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (406, 8, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (407, 10, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (408, 12, 3, 1, '#8b4513');
INSERT INTO piece.piece VALUES (409, 1, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (410, 2, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (411, 3, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (412, 4, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (413, 6, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (414, 8, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (415, 10, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (416, 12, 4, 1, '#8b4513');
INSERT INTO piece.piece VALUES (417, 1, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (418, 2, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (419, 3, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (420, 4, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (421, 6, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (422, 8, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (423, 10, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (424, 12, 6, 1, '#8b4513');
INSERT INTO piece.piece VALUES (425, 1, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (426, 2, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (427, 3, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (428, 4, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (429, 6, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (430, 8, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (431, 10, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (432, 12, 8, 1, '#8b4513');
INSERT INTO piece.piece VALUES (433, 1, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (434, 2, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (435, 3, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (436, 4, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (437, 6, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (438, 8, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (439, 10, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (440, 12, 10, 1, '#8b4513');
INSERT INTO piece.piece VALUES (441, 1, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (442, 2, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (443, 3, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (444, 4, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (445, 6, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (446, 8, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (447, 10, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (448, 12, 12, 1, '#8b4513');
INSERT INTO piece.piece VALUES (449, 1, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (450, 2, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (451, 3, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (452, 4, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (453, 6, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (454, 8, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (455, 10, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (456, 12, 1, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (457, 1, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (458, 2, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (459, 3, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (460, 4, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (461, 6, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (462, 8, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (463, 10, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (464, 12, 2, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (465, 1, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (466, 2, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (467, 3, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (468, 4, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (469, 6, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (470, 8, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (471, 10, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (472, 12, 3, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (473, 1, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (474, 2, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (475, 3, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (476, 4, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (477, 6, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (478, 8, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (479, 10, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (480, 12, 4, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (481, 1, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (482, 2, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (483, 3, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (484, 4, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (485, 6, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (486, 8, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (487, 10, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (488, 12, 6, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (489, 1, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (490, 2, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (491, 3, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (492, 4, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (493, 6, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (494, 8, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (495, 10, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (496, 12, 8, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (497, 1, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (498, 2, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (499, 3, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (500, 4, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (501, 6, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (502, 8, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (503, 10, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (504, 12, 10, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (505, 1, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (506, 2, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (507, 3, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (508, 4, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (509, 6, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (510, 8, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (511, 10, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (512, 12, 12, 0.33, '#8b4513');
INSERT INTO piece.piece VALUES (513, 1, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (514, 2, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (515, 3, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (516, 4, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (517, 6, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (518, 8, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (519, 10, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (520, 12, 1, 1, '#00bfff');
INSERT INTO piece.piece VALUES (521, 1, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (522, 2, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (523, 3, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (524, 4, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (525, 6, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (526, 8, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (527, 10, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (528, 12, 2, 1, '#00bfff');
INSERT INTO piece.piece VALUES (529, 1, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (530, 2, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (531, 3, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (532, 4, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (533, 6, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (534, 8, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (535, 10, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (536, 12, 3, 1, '#00bfff');
INSERT INTO piece.piece VALUES (537, 1, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (538, 2, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (539, 3, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (540, 4, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (541, 6, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (542, 8, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (543, 10, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (544, 12, 4, 1, '#00bfff');
INSERT INTO piece.piece VALUES (545, 1, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (546, 2, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (547, 3, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (548, 4, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (549, 6, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (550, 8, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (551, 10, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (552, 12, 6, 1, '#00bfff');
INSERT INTO piece.piece VALUES (553, 1, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (554, 2, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (555, 3, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (556, 4, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (557, 6, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (558, 8, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (559, 10, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (560, 12, 8, 1, '#00bfff');
INSERT INTO piece.piece VALUES (561, 1, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (562, 2, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (563, 3, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (564, 4, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (565, 6, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (566, 8, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (567, 10, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (568, 12, 10, 1, '#00bfff');
INSERT INTO piece.piece VALUES (569, 1, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (570, 2, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (571, 3, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (572, 4, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (573, 6, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (574, 8, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (575, 10, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (576, 12, 12, 1, '#00bfff');
INSERT INTO piece.piece VALUES (577, 1, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (578, 2, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (579, 3, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (580, 4, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (581, 6, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (582, 8, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (583, 10, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (584, 12, 1, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (585, 1, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (586, 2, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (587, 3, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (588, 4, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (589, 6, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (590, 8, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (591, 10, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (592, 12, 2, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (593, 1, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (594, 2, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (595, 3, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (596, 4, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (597, 6, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (598, 8, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (599, 10, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (600, 12, 3, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (601, 1, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (602, 2, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (603, 3, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (604, 4, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (605, 6, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (606, 8, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (607, 10, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (608, 12, 4, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (609, 1, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (610, 2, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (611, 3, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (612, 4, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (613, 6, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (614, 8, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (615, 10, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (616, 12, 6, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (617, 1, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (618, 2, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (619, 3, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (620, 4, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (621, 6, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (622, 8, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (623, 10, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (624, 12, 8, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (625, 1, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (626, 2, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (627, 3, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (628, 4, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (629, 6, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (630, 8, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (631, 10, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (632, 12, 10, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (633, 1, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (634, 2, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (635, 3, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (636, 4, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (637, 6, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (638, 8, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (639, 10, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (640, 12, 12, 0.33, '#00bfff');
INSERT INTO piece.piece VALUES (641, 1, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (642, 2, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (643, 3, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (644, 4, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (645, 6, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (646, 8, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (647, 10, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (648, 12, 1, 1, '#0000cd');
INSERT INTO piece.piece VALUES (649, 1, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (650, 2, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (651, 3, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (652, 4, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (653, 6, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (654, 8, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (655, 10, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (656, 12, 2, 1, '#0000cd');
INSERT INTO piece.piece VALUES (657, 1, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (658, 2, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (659, 3, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (660, 4, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (661, 6, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (662, 8, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (663, 10, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (664, 12, 3, 1, '#0000cd');
INSERT INTO piece.piece VALUES (665, 1, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (666, 2, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (667, 3, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (668, 4, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (669, 6, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (670, 8, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (671, 10, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (672, 12, 4, 1, '#0000cd');
INSERT INTO piece.piece VALUES (673, 1, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (674, 2, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (675, 3, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (676, 4, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (677, 6, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (678, 8, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (679, 10, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (680, 12, 6, 1, '#0000cd');
INSERT INTO piece.piece VALUES (681, 1, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (682, 2, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (683, 3, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (684, 4, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (685, 6, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (686, 8, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (687, 10, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (688, 12, 8, 1, '#0000cd');
INSERT INTO piece.piece VALUES (689, 1, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (690, 2, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (691, 3, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (692, 4, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (693, 6, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (694, 8, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (695, 10, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (696, 12, 10, 1, '#0000cd');
INSERT INTO piece.piece VALUES (697, 1, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (698, 2, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (699, 3, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (700, 4, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (701, 6, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (702, 8, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (703, 10, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (704, 12, 12, 1, '#0000cd');
INSERT INTO piece.piece VALUES (705, 1, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (706, 2, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (707, 3, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (708, 4, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (709, 6, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (710, 8, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (711, 10, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (712, 12, 1, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (713, 1, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (714, 2, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (715, 3, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (716, 4, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (717, 6, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (718, 8, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (719, 10, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (720, 12, 2, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (721, 1, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (722, 2, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (723, 3, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (724, 4, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (725, 6, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (726, 8, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (727, 10, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (728, 12, 3, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (729, 1, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (730, 2, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (731, 3, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (732, 4, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (733, 6, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (734, 8, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (735, 10, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (736, 12, 4, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (737, 1, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (738, 2, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (739, 3, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (740, 4, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (741, 6, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (742, 8, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (743, 10, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (744, 12, 6, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (745, 1, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (746, 2, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (747, 3, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (748, 4, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (749, 6, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (750, 8, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (751, 10, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (752, 12, 8, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (753, 1, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (754, 2, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (755, 3, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (756, 4, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (757, 6, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (758, 8, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (759, 10, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (760, 12, 10, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (761, 1, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (762, 2, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (763, 3, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (764, 4, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (765, 6, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (766, 8, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (767, 10, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (768, 12, 12, 0.33, '#0000cd');
INSERT INTO piece.piece VALUES (769, 1, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (770, 2, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (771, 3, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (772, 4, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (773, 6, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (774, 8, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (775, 10, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (776, 12, 1, 1, '#006400');
INSERT INTO piece.piece VALUES (777, 1, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (778, 2, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (779, 3, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (780, 4, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (781, 6, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (782, 8, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (783, 10, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (784, 12, 2, 1, '#006400');
INSERT INTO piece.piece VALUES (785, 1, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (786, 2, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (787, 3, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (788, 4, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (789, 6, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (790, 8, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (791, 10, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (792, 12, 3, 1, '#006400');
INSERT INTO piece.piece VALUES (793, 1, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (794, 2, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (795, 3, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (796, 4, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (797, 6, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (798, 8, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (799, 10, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (800, 12, 4, 1, '#006400');
INSERT INTO piece.piece VALUES (801, 1, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (802, 2, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (803, 3, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (804, 4, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (805, 6, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (806, 8, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (807, 10, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (808, 12, 6, 1, '#006400');
INSERT INTO piece.piece VALUES (809, 1, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (810, 2, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (811, 3, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (812, 4, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (813, 6, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (814, 8, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (815, 10, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (816, 12, 8, 1, '#006400');
INSERT INTO piece.piece VALUES (817, 1, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (818, 2, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (819, 3, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (820, 4, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (821, 6, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (822, 8, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (823, 10, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (824, 12, 10, 1, '#006400');
INSERT INTO piece.piece VALUES (825, 1, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (826, 2, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (827, 3, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (828, 4, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (829, 6, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (830, 8, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (831, 10, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (832, 12, 12, 1, '#006400');
INSERT INTO piece.piece VALUES (833, 1, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (834, 2, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (835, 3, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (836, 4, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (837, 6, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (838, 8, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (839, 10, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (840, 12, 1, 0.33, '#006400');
INSERT INTO piece.piece VALUES (841, 1, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (842, 2, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (843, 3, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (844, 4, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (845, 6, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (846, 8, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (847, 10, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (848, 12, 2, 0.33, '#006400');
INSERT INTO piece.piece VALUES (849, 1, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (850, 2, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (851, 3, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (852, 4, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (853, 6, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (854, 8, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (855, 10, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (856, 12, 3, 0.33, '#006400');
INSERT INTO piece.piece VALUES (857, 1, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (858, 2, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (859, 3, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (860, 4, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (861, 6, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (862, 8, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (863, 10, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (864, 12, 4, 0.33, '#006400');
INSERT INTO piece.piece VALUES (865, 1, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (866, 2, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (867, 3, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (868, 4, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (869, 6, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (870, 8, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (871, 10, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (872, 12, 6, 0.33, '#006400');
INSERT INTO piece.piece VALUES (873, 1, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (874, 2, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (875, 3, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (876, 4, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (877, 6, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (878, 8, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (879, 10, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (880, 12, 8, 0.33, '#006400');
INSERT INTO piece.piece VALUES (881, 1, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (882, 2, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (883, 3, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (884, 4, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (885, 6, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (886, 8, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (887, 10, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (888, 12, 10, 0.33, '#006400');
INSERT INTO piece.piece VALUES (889, 1, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (890, 2, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (891, 3, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (892, 4, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (893, 6, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (894, 8, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (895, 10, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (896, 12, 12, 0.33, '#006400');
INSERT INTO piece.piece VALUES (897, 1, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (898, 2, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (899, 3, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (900, 4, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (901, 6, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (902, 8, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (903, 10, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (904, 12, 1, 1, '#ffff00');
INSERT INTO piece.piece VALUES (905, 1, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (906, 2, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (907, 3, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (908, 4, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (909, 6, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (910, 8, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (911, 10, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (912, 12, 2, 1, '#ffff00');
INSERT INTO piece.piece VALUES (913, 1, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (914, 2, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (915, 3, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (916, 4, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (917, 6, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (918, 8, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (919, 10, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (920, 12, 3, 1, '#ffff00');
INSERT INTO piece.piece VALUES (921, 1, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (922, 2, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (923, 3, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (924, 4, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (925, 6, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (926, 8, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (927, 10, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (928, 12, 4, 1, '#ffff00');
INSERT INTO piece.piece VALUES (929, 1, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (930, 2, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (931, 3, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (932, 4, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (933, 6, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (934, 8, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (935, 10, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (936, 12, 6, 1, '#ffff00');
INSERT INTO piece.piece VALUES (937, 1, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (938, 2, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (939, 3, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (940, 4, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (941, 6, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (942, 8, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (943, 10, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (944, 12, 8, 1, '#ffff00');
INSERT INTO piece.piece VALUES (945, 1, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (946, 2, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (947, 3, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (948, 4, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (949, 6, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (950, 8, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (951, 10, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (952, 12, 10, 1, '#ffff00');
INSERT INTO piece.piece VALUES (953, 1, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (954, 2, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (955, 3, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (956, 4, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (957, 6, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (958, 8, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (959, 10, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (960, 12, 12, 1, '#ffff00');
INSERT INTO piece.piece VALUES (961, 1, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (962, 2, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (963, 3, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (964, 4, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (965, 6, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (966, 8, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (967, 10, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (968, 12, 1, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (969, 1, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (970, 2, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (971, 3, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (972, 4, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (973, 6, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (974, 8, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (975, 10, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (976, 12, 2, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (977, 1, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (978, 2, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (979, 3, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (980, 4, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (981, 6, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (982, 8, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (983, 10, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (984, 12, 3, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (985, 1, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (986, 2, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (987, 3, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (988, 4, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (989, 6, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (990, 8, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (991, 10, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (992, 12, 4, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (993, 1, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (994, 2, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (995, 3, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (996, 4, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (997, 6, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (998, 8, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (999, 10, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1000, 12, 6, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1001, 1, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1002, 2, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1003, 3, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1004, 4, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1005, 6, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1006, 8, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1007, 10, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1008, 12, 8, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1009, 1, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1010, 2, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1011, 3, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1012, 4, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1013, 6, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1014, 8, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1015, 10, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1016, 12, 10, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1017, 1, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1018, 2, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1019, 3, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1020, 4, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1021, 6, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1022, 8, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1023, 10, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1024, 12, 12, 0.33, '#ffff00');
INSERT INTO piece.piece VALUES (1025, 1, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1026, 2, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1027, 3, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1028, 4, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1029, 6, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1030, 8, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1031, 10, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1032, 12, 1, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1033, 1, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1034, 2, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1035, 3, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1036, 4, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1037, 6, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1038, 8, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1039, 10, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1040, 12, 2, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1041, 1, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1042, 2, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1043, 3, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1044, 4, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1045, 6, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1046, 8, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1047, 10, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1048, 12, 3, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1049, 1, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1050, 2, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1051, 3, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1052, 4, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1053, 6, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1054, 8, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1055, 10, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1056, 12, 4, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1057, 1, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1058, 2, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1059, 3, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1060, 4, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1061, 6, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1062, 8, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1063, 10, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1064, 12, 6, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1065, 1, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1066, 2, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1067, 3, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1068, 4, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1069, 6, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1070, 8, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1071, 10, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1072, 12, 8, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1073, 1, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1074, 2, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1075, 3, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1076, 4, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1077, 6, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1078, 8, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1079, 10, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1080, 12, 10, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1081, 1, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1082, 2, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1083, 3, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1084, 4, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1085, 6, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1086, 8, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1087, 10, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1088, 12, 12, 1, '#7b68ee');
INSERT INTO piece.piece VALUES (1089, 1, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1090, 2, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1091, 3, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1092, 4, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1093, 6, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1094, 8, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1095, 10, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1096, 12, 1, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1097, 1, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1098, 2, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1099, 3, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1100, 4, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1101, 6, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1102, 8, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1103, 10, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1104, 12, 2, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1105, 1, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1106, 2, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1107, 3, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1108, 4, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1109, 6, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1110, 8, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1111, 10, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1112, 12, 3, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1113, 1, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1114, 2, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1115, 3, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1116, 4, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1117, 6, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1118, 8, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1119, 10, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1120, 12, 4, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1121, 1, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1122, 2, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1123, 3, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1124, 4, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1125, 6, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1126, 8, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1127, 10, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1128, 12, 6, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1129, 1, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1130, 2, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1131, 3, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1132, 4, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1133, 6, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1134, 8, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1135, 10, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1136, 12, 8, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1137, 1, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1138, 2, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1139, 3, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1140, 4, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1141, 6, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1142, 8, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1143, 10, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1144, 12, 10, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1145, 1, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1146, 2, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1147, 3, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1148, 4, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1149, 6, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1150, 8, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1151, 10, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1152, 12, 12, 0.33, '#7b68ee');
INSERT INTO piece.piece VALUES (1153, 1, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1154, 2, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1155, 3, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1156, 4, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1157, 6, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1158, 8, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1159, 10, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1160, 12, 1, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1161, 1, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1162, 2, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1163, 3, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1164, 4, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1165, 6, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1166, 8, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1167, 10, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1168, 12, 2, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1169, 1, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1170, 2, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1171, 3, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1172, 4, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1173, 6, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1174, 8, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1175, 10, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1176, 12, 3, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1177, 1, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1178, 2, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1179, 3, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1180, 4, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1181, 6, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1182, 8, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1183, 10, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1184, 12, 4, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1185, 1, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1186, 2, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1187, 3, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1188, 4, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1189, 6, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1190, 8, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1191, 10, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1192, 12, 6, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1193, 1, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1194, 2, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1195, 3, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1196, 4, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1197, 6, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1198, 8, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1199, 10, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1200, 12, 8, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1201, 1, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1202, 2, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1203, 3, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1204, 4, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1205, 6, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1206, 8, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1207, 10, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1208, 12, 10, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1209, 1, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1210, 2, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1211, 3, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1212, 4, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1213, 6, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1214, 8, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1215, 10, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1216, 12, 12, 1, '#ff0000');
INSERT INTO piece.piece VALUES (1217, 1, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1218, 2, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1219, 3, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1220, 4, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1221, 6, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1222, 8, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1223, 10, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1224, 12, 1, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1225, 1, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1226, 2, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1227, 3, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1228, 4, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1229, 6, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1230, 8, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1231, 10, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1232, 12, 2, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1233, 1, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1234, 2, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1235, 3, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1236, 4, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1237, 6, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1238, 8, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1239, 10, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1240, 12, 3, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1241, 1, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1242, 2, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1243, 3, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1244, 4, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1245, 6, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1246, 8, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1247, 10, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1248, 12, 4, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1249, 1, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1250, 2, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1251, 3, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1252, 4, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1253, 6, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1254, 8, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1255, 10, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1256, 12, 6, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1257, 1, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1258, 2, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1259, 3, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1260, 4, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1261, 6, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1262, 8, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1263, 10, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1264, 12, 8, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1265, 1, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1266, 2, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1267, 3, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1268, 4, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1269, 6, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1270, 8, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1271, 10, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1272, 12, 10, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1273, 1, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1274, 2, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1275, 3, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1276, 4, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1277, 6, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1278, 8, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1279, 10, 12, 0.33, '#ff0000');
INSERT INTO piece.piece VALUES (1280, 12, 12, 0.33, '#ff0000');
