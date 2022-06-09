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