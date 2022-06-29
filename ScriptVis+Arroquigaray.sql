create SCHEMA Steam;
use Steam;

create table Categorias (
    id_cat INT AUTO_INCREMENT NOT NULL,
    cat varchar(255),
    PRIMARY KEY(id_cat)
    );

CREATE TABLE Jugadores (
    id_player INT AUTO_INCREMENT NOT NULL,
    nick VARCHAR (50) NOT NULL,
    PASS VARBINARY(20) NOT NULL,
    hs_totl DECIMAL(5,2),
    PRIMARY KEY(id_player)
    );
 
CREATE TABLE Juegos (
    id_cat INT,
    id_game INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(120) NOT NULL,
    diadlanz DATE,
    reca DECIMAL(7,2),
    cost DECIMAL(7,2),
    PRIMARY KEY (id_game),
    FOREIGN KEY (id_cat) REFERENCES Categorias (id_cat)
    );
    
CREATE TABLE Logros (
    id_player INT,
    id_game INT,
    id_logro INT AUTO_INCREMENT NOT NULL,
    log VARCHAR(255),
    PRIMARY KEY(id_logro),
    FOREIGN KEY (id_game) REFERENCES Juegos (id_game),
    FOREIGN KEY (id_player) REFERENCES Jugadores (id_player)
    );
    
CREATE TABLE Resenia (
    id_res INT AUTO_INCREMENT NOT NULL,
    res VARCHAR(255),
    pos_neg BOOLEAN NOT NULL DEFAULT 0,
    id_player INT,
    id_game INT,
    PRIMARY KEY (id_res),
    FOREIGN KEY (id_player) REFERENCES Jugadores(id_player),
    FOREIGN KEY (id_game) REFERENCES Juegos(id_game)
    );
    
CREATE TABLE Horas (
    hs_totl DECIMAL (5,2),
    id_player INT,
    id_game INT,
    id_res INT,
    id_cat INT,
    FOREIGN KEY (id_player) REFERENCES Jugadores(id_player),
    FOREIGN KEY (id_game) REFERENCES Juegos(id_game),
    FOREIGN KEY (id_res) REFERENCES Resenia(id_res),
    FOREIGN KEY (id_cat) REFERENCES Categorias(id_cat)
    );
    

/* INSERT DE DATOS A LAS TABLAS */    
INSERT INTO Categorias (id_cat, cat) VALUES (NULL, "Terror"), (NULL, "Aventura"), (NULL, "Shooter"), (NULL, "MMORPG");

INSERT INTO juegos (id_cat, id_game, name, diadlanz, reca, cost) VALUES 
(3,null,"Overwatch","2016/06/16", 89456,12657),
(1,null,"Project Zero","2001/12/13",45156,15365),
(2,null,"Jack & Daxter","2001/12/4",56246,20456);

INSERT into Jugadores (id_player, nick, PASS, hs_totl) values 
(null, "Pitdog", "asd123",560),
(null,"Black","542sdf",430),
(null,"Ashma","bnde12",153);

INSERT INTO logros values
(1,3,1,'Bien potente Consigue 50 baterías.'),
(2,2,2, 'Mejora al máximo la cámara y las lentes.'),
(3,1,3,'Obtén una racha de 20 asesinatos en partida rápida o competitiva.');

INSERT INTO resenia values (null, 'Muy bueno', 1, 1, 3), (null, 'No me gustó', 0 , 3 , 1), (null, 'Me la pase bien', 1, 2,2);

INSERT INTO horas values (45, 1, 3, 1, 2), (30, 2, 2, 3, 1), (70, 3, 1, 2, 3); 

/* CREACION DE LAS VISTAS */
CREATE VIEW `VW_cat1DeJuegos` AS SELECT cat, name From categorias right join juegos on juegos.id_cat = categorias.id_cat;

CREATE VIEW `VW_jugador.resenia` AS SELECT nick as Jugador, res as Resenia, name as Juego From jugadores right join resenia on jugadores.id_player = resenia.id_player right join juegos on resenia.id_game = juegos.id_game;

CREATE VIEW `VW_horasdejuego` AS SELECT name as Juego, hs_totl as Horas_Totales FROM juegos right join horas on juegos.id_game = horas.id_game;

CREATE VIEW `VW_respos.juego` AS SELECT name as Juego, res as Resenias_Positivas, pos_neg as Positiva FROM juegos INNER JOIN resenia on juegos.id_game = resenia.id_game where pos_neg > 0;

CREATE VIEW `VW_jugador.por.hora` AS SELECT nick as jugador, hs_totl as horas, name as juego FROM jugadores INNER JOIN horas on jugadores.id_player = horas.id_player INNER JOIN juegos on horas.id_game = juegos.id_game group by horas.hs_totl;
