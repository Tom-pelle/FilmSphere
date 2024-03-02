-- Niccolò Franchi, Tommaso Pellegrini. Progetto di Basi di Dati 2023

-- Questo script definisce i trigger che implementano i vincoli del database.


-- Vincoli intrarelazionali di dominio

USE mydb;

DROP TRIGGER IF EXISTS int_pos_abbonamento;

DELIMITER $$

CREATE TRIGGER int_pos_abbonamento
BEFORE INSERT ON Abbonamento FOR EACH ROW
BEGIN
  IF NEW.Tariffa < 0 OR NEW.Durata < 0 OR NEW.MaxOre < 0 OR NEW.EtaMinima < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_attore;

DELIMITER $$

CREATE TRIGGER int_pos_attore
BEFORE INSERT ON Attore FOR EACH ROW
BEGIN
  IF NEW.IdAttore < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_critico;

DELIMITER $$

CREATE TRIGGER int_pos_critico
BEFORE INSERT ON Critico FOR EACH ROW
BEGIN
  IF NEW.IdCritico < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_dispositivo;

DELIMITER $$

CREATE TRIGGER int_pos_dispositivo
BEFORE INSERT ON Dispositivo FOR EACH ROW
BEGIN
  IF NEW.Id < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_fattura;

DELIMITER $$

CREATE TRIGGER int_pos_fattura
BEFORE INSERT ON Fattura FOR EACH ROW
BEGIN
  IF NEW.IdFattura < 0 OR NEW.Saldo < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_film;

DELIMITER $$

CREATE TRIGGER int_pos_film
BEFORE INSERT ON Film FOR EACH ROW
BEGIN
  IF NEW.IdFilm < 0 OR NEW.Durata < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_formatoaudio;

DELIMITER $$

CREATE TRIGGER int_pos_formatoaudio
BEFORE INSERT ON FormatoAudio FOR EACH ROW
BEGIN
  IF NEW.Codice < 0 OR NEW.Bitrate < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_formatovideo;

DELIMITER $$

CREATE TRIGGER int_pos_formatovideo
BEFORE INSERT ON FormatoVideo FOR EACH ROW
BEGIN
  IF NEW.Codice < 0 OR NEW.Bitrate < 0  THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_premiofilm;

DELIMITER $$

CREATE TRIGGER int_pos_premiofilm
BEFORE INSERT ON PremioFilm FOR EACH ROW
BEGIN
  IF NEW.Codice < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_premioregista;

DELIMITER $$

CREATE TRIGGER int_pos_premioregista
BEFORE INSERT ON PremioRegista FOR EACH ROW
BEGIN
  IF NEW.Codice < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_premioattore;

DELIMITER $$

CREATE TRIGGER int_pos_premioattore
BEFORE INSERT ON PremioAttore FOR EACH ROW
BEGIN
  IF NEW.Codice < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_premiazioneattore;

DELIMITER $$

CREATE TRIGGER int_pos_premiazioneattore
BEFORE INSERT ON PremiazioneAttore FOR EACH ROW
BEGIN
  IF NEW.Anno < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_premiazionefilm;

DELIMITER $$

CREATE TRIGGER int_pos_premiazionefilm
BEFORE INSERT ON PremiazioneFilm FOR EACH ROW
BEGIN
  IF NEW.Anno < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_premiazioneregista;

DELIMITER $$

CREATE TRIGGER int_pos_premiazioneregista
BEFORE INSERT ON PremiazioneRegista FOR EACH ROW
BEGIN
  IF NEW.Anno < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_regista;

DELIMITER $$

CREATE TRIGGER int_pos_regista
BEFORE INSERT ON Regista FOR EACH ROW
BEGIN
  IF NEW.IdRegista < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_server;

DELIMITER $$

CREATE TRIGGER int_pos_server
BEFORE INSERT ON Server FOR EACH ROW
BEGIN
  IF NEW.IdServer < 0 OR NEW.LarghezzaDiBanda < 0 OR NEW.CapacitaMax < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_servizio;

DELIMITER $$

CREATE TRIGGER int_pos_servizio
BEFORE INSERT ON Servizio FOR EACH ROW
BEGIN
  IF NEW.IdServizio < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_utente;

DELIMITER $$

CREATE TRIGGER int_pos_utente
BEFORE INSERT ON Utente FOR EACH ROW
BEGIN
  IF NEW.Codice < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS int_pos_versione;

DELIMITER $$

CREATE TRIGGER int_pos_versione
BEFORE INSERT ON Versione FOR EACH ROW
BEGIN
  IF NEW.CodiceVersione < 0 OR NEW.Dimensione < 0  THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_fattura;

DELIMITER $$

CREATE TRIGGER data_post_fattura
BEFORE INSERT ON Fattura FOR EACH ROW
BEGIN
  IF NEW.Emissione < '2022-01-01' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_recensionecritico;

DELIMITER $$

CREATE TRIGGER data_post_recensionecritico
BEFORE INSERT ON RecensioneCritico FOR EACH ROW
BEGIN
  IF NEW.Data < '2022-01-01' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_connessione;

DELIMITER $$

CREATE TRIGGER data_post_connessione
BEFORE INSERT ON Connessione FOR EACH ROW
BEGIN
  IF NEW.Inizio < '2022-01-01 00:00:00' OR NEW.Fine < '2022-01-01 00:00:00' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_servizio;

DELIMITER $$

CREATE TRIGGER data_post_servizio
BEFORE INSERT ON Servizio FOR EACH ROW
BEGIN
  IF NEW.Inizio < '2022-01-01 00:00:00' OR NEW.Fine < '2022-01-01 00:00:00' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_memorizzazione;

DELIMITER $$

CREATE TRIGGER data_post_memorizzazione
BEFORE INSERT ON Memorizzazione FOR EACH ROW
BEGIN
  IF NEW.Inizio < '2022-01-01 00:00:00' OR NEW.Fine < '2022-01-01 00:00:00' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_recensioneutente;

DELIMITER $$

CREATE TRIGGER data_post_recensioneutente
BEFORE INSERT ON RecensioneUtente FOR EACH ROW
BEGIN
  IF NEW.Data < '2022-01-01' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS data_post_utente;

DELIMITER $$

CREATE TRIGGER data_post_utente
BEFORE INSERT ON Utente FOR EACH ROW
BEGIN
  IF NEW.DataNascita > CURRENT_DATE() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

-- Attributi interi con particolari vincoli di dominio

DROP TRIGGER IF EXISTS pos_paese;

DELIMITER $$

CREATE TRIGGER pos_paese
BEFORE INSERT ON Paese FOR EACH ROW
BEGIN
  IF NEW.Latitudine < -90 OR NEW.Latitudine > 90 OR NEW.Longitudine < -180 OR NEW.Longitudine > 180 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS pos_server;

DELIMITER $$

CREATE TRIGGER pos_server
BEFORE INSERT ON Server FOR EACH ROW
BEGIN
  IF NEW.Latitudine < -90 OR NEW.Latitudine > 90 OR NEW.Longitudine < -180 OR NEW.Longitudine > 180 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Dati inseriti non validi';
  END IF;
END $$
DELIMITER ;



DROP TRIGGER IF EXISTS cvv_carta;

DELIMITER $$

CREATE TRIGGER cvv_carta
BEFORE INSERT ON CartaDiCredito FOR EACH ROW
BEGIN
  IF NEW.Cvv < 0 OR NEW.Cvv > 999 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cvv Carta di Credito non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS mesescadenza_carta;

DELIMITER $$

CREATE TRIGGER mesescadenza_carta
BEFORE INSERT ON CartaDiCredito FOR EACH ROW
BEGIN
  IF NEW.MeseScadenza < 1 OR NEW.MeseScadenza > 12 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Mese di Scadenza Carta di Credito non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS annoscadenza_carta;

DELIMITER $$

CREATE TRIGGER annoscadenza_carta
BEFORE INSERT ON CartaDiCredito FOR EACH ROW
BEGIN
  IF NEW.AnnoScadenza < 2022 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Anno di Scadenza Carta di Credito non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS ip_connessione;

DELIMITER $$

CREATE TRIGGER ip_connessione
BEFORE INSERT ON Connessione FOR EACH ROW
BEGIN
  IF NEW.IP < 0 OR NEW.IP > 100255255255 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'IP non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS ip_paese;

DELIMITER $$

CREATE TRIGGER ip_paese
BEFORE INSERT ON Paese FOR EACH ROW
BEGIN
  IF NEW.IP < 0 OR NEW.IP > 100255255255 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'IP non valido';
  END IF;

END $$
DELIMITER ;


DROP TRIGGER IF EXISTS anno_film;

DELIMITER $$

CREATE TRIGGER anno_film
BEFORE INSERT ON Film FOR EACH ROW
BEGIN
  IF NEW.Anno < 1900 OR NEW.Anno > YEAR(CURRENT_DATE) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Anno non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS valore_distanza;

DELIMITER $$

CREATE TRIGGER valore_distanza
BEFORE INSERT ON Distanza FOR EACH ROW
BEGIN
  IF NEW.Valore < 0 OR NEW.Valore > 20000 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Valore di importanza non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS voto_recensionecritico;

DELIMITER $$

CREATE TRIGGER voto_recensionecritico
BEFORE INSERT ON RecensioneCritico FOR EACH ROW
BEGIN
  IF NEW.Voto < 1 OR NEW.Voto > 5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Voto non valido';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS voto_recensioneutente;

DELIMITER $$

CREATE TRIGGER voto_recensioneutente
BEFORE INSERT ON RecensioneUtente FOR EACH ROW
BEGIN
  IF NEW.Voto < 1 OR NEW.Voto > 5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Voto non valido';
  END IF;

END $$
DELIMITER ;



-- Vincoli intrarelazionali di n-upla

DROP TRIGGER IF EXISTS data_carta_futura;

DELIMITER $$

CREATE TRIGGER data_carta_futura
BEFORE INSERT ON CartaDiCredito FOR EACH ROW
BEGIN
  IF NEW.AnnoScadenza < YEAR(CURRENT_DATE) OR (NEW.AnnoScadenza = YEAR(CURRENT_DATE) AND NEW.MeseScadenza <= MONTH(CURRENT_DATE)) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Carta Scaduta';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS connessione_inizio;

DELIMITER $$

CREATE TRIGGER connessione_inizio
BEFORE INSERT ON Connessione FOR EACH ROW
BEGIN
  IF NEW.Inizio >= NEW.Fine THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Inizio(Connessione) deve essere minore di Fine(Connessione)';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS servizio_inizio;

DELIMITER $$

CREATE TRIGGER servizio_inizio
BEFORE INSERT ON Servizio FOR EACH ROW
BEGIN
  IF NEW.Inizio >= NEW.Fine THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Inizio(Servizio) deve essere minore di Fine(Servizio)';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS memorizzazione_inizio;

DELIMITER $$

CREATE TRIGGER memorizzazione_inizio
BEFORE INSERT ON Memorizzazione FOR EACH ROW
BEGIN
  IF NEW.Inizio >= NEW.Fine THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Inizio(Memorizzazione) deve essere minore di Fine(Memorizzazione)';
  END IF;

END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Controllo_carta;
DELIMITER $$
	CREATE TRIGGER Controllo_carta
    BEFORE INSERT ON CartaDiCredito
	FOR EACH ROW
	BEGIN
    IF CHAR_LENGTH(cast(NEW.Numero as char)) != 16 
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La lunghezza del numero della carta deve essere di 16 cifre';
		END IF;
	END $$
DELIMITER ;
-- -----------

-- Vincoli di integrità referenziale

-- Ogni formato video in Versione deve comparire nella tabella FormatoVideo
DROP TRIGGER IF EXISTS Versione_formatovideo;

DELIMITER $$

CREATE TRIGGER versione_formatovideo
BEFORE INSERT ON Versione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM FormatoVideo F
     WHERE F.Codice = NEW.FormatoVideo_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni formato video in Versione deve comparire nella tabella FormatoVideo';
  END IF;

END $$
DELIMITER ;

-- Ogni formato video in Versione deve comparire nella tabella FormatoVideo
DROP TRIGGER IF EXISTS Versione_formatovideo;

DELIMITER $$

CREATE TRIGGER versione_formatovideo
BEFORE INSERT ON Versione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM FormatoVideo F
     WHERE F.Codice = NEW.FormatoVideo_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni formato video in Versione deve comparire nella tabella FormatoVideo';
  END IF;

END $$
DELIMITER ;

-- Ogni formato audio in Versione deve comparire nella tabella FormatoAudio
DROP TRIGGER IF EXISTS Versione_formatoaudio;

DELIMITER $$

CREATE TRIGGER Versione_formatoaudio
BEFORE INSERT ON Versione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM FormatoAudio F
     WHERE F.Codice = NEW.FormatoAudio_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni formato audio in Versione deve comparire nella tabella FormatoAudio';
  END IF;

END $$
DELIMITER ;

-- Ogni film in Versione deve comparire nella tabella Film
DROP TRIGGER IF EXISTS Versione_film;

DELIMITER $$

CREATE TRIGGER Versione_film
BEFORE INSERT ON Versione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Film F
     WHERE F.IdFilm = NEW.Film_idfilm
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni film in Versione deve comparire nella tabella Film';
  END IF;

END $$
DELIMITER ;

-- Ogni versione in RestrizioneVersione deve comparire nella tabella Versione
DROP TRIGGER IF EXISTS Restrizioneversione_versione;

DELIMITER $$

CREATE TRIGGER Restrizioneversione_versione
BEFORE INSERT ON RestrizioneVersione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Versione V
     WHERE V.CodiceVersione = NEW.Versione_codiceVersione
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni versione in RestrizioneVersione deve comparire nella tabella Versione';
  END IF;

END $$
DELIMITER ;

-- Ogni Paese in RestrizioneVersione deve comparire nella tabella Paese
DROP TRIGGER IF EXISTS Restrizioneversione_paese;

DELIMITER $$

CREATE TRIGGER Restrizioneversione_paese
BEFORE INSERT ON RestrizioneVersione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Paese P
     WHERE P.Nome = NEW.Paese_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Paese in RestrizioneVersione deve comparire nella tabella Paese';
  END IF;

END $$
DELIMITER ;

-- Ogni server in Memorizzazione deve comparire nella tabella Server
DROP TRIGGER IF EXISTS server_memorizzazione;

DELIMITER $$

CREATE TRIGGER server_memorizzazione
BEFORE INSERT ON Memorizzazione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Server S
     WHERE S.IdServer = NEW.Server_idServer
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni server in Memorizzazione deve comparire nella tabella Server';
  END IF;

END $$
DELIMITER ;

-- Ogni versione in Memorizzazione deve comparire nella tabella Versione
DROP TRIGGER IF EXISTS versione_memorizzazione;

DELIMITER $$

CREATE TRIGGER versione_memorizzazione
BEFORE INSERT ON Memorizzazione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Versione V
     WHERE V.CodiceVersione = NEW.Versione_codiceVersione
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni versione in Memorizzazione deve comparire nella tabella Versione';
  END IF;

END $$
DELIMITER ;

-- Ogni versione in Servizio deve comparire nella tabella Versione
DROP TRIGGER IF EXISTS versione_servizio;

DELIMITER $$

CREATE TRIGGER versione_servizio
BEFORE INSERT ON Servizio FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Versione V
     WHERE V.CodiceVersione = NEW.Versione_CodiceVersione
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni versione in Servizio deve comparire nella tabella Versione';
  END IF;

END $$
DELIMITER ;

-- Ogni server in Servizio deve comparire nella tabella Server
DROP TRIGGER IF EXISTS server_servizio;

DELIMITER $$

CREATE TRIGGER server_servizio
BEFORE INSERT ON Servizio FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Server S
     WHERE S.IdServer = NEW.Server_IdServer
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni server in Servizio deve comparire nella tabella Server';
  END IF;

END $$
DELIMITER ;

-- Ogni paese in Distanza deve comparire nella tabella Paese
DROP TRIGGER IF EXISTS paese_distanza;

DELIMITER $$

CREATE TRIGGER paese_distanza
BEFORE INSERT ON Distanza FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Paese P
     WHERE P.Nome = NEW.Paese_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni paese in Distanza deve comparire nella tabella Paese';
  END IF;

END $$
DELIMITER ;

-- Ogni server in Distanza deve comparire nella tabella Server
DROP TRIGGER IF EXISTS server_distanza;

DELIMITER $$

CREATE TRIGGER server_distanza
BEFORE INSERT ON Distanza FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Server S
     WHERE S.IdServer = NEW.Server_idserver
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni server in Distanza deve comparire nella tabella Server';
  END IF;

END $$
DELIMITER ;

-- Ogni servizio in Connessione deve comparire nella tabella Servizio
DROP TRIGGER IF EXISTS servizio_connessione;

DELIMITER $$

CREATE TRIGGER servizio_connessione
BEFORE INSERT ON Connessione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Servizio S
     WHERE S.IdServizio = NEW.Servizio_idServizio
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni servizio in Connessione deve comparire nella tabella Servizio';
  END IF;

END $$
DELIMITER ;

-- Ogni Dispositivo in Connessione deve comparire nella tabella Dispositivo
DROP TRIGGER IF EXISTS dispositivo_connessione;

DELIMITER $$

CREATE TRIGGER dispositivo_connessione
BEFORE INSERT ON Connessione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Dispositivo D
     WHERE D.Id = NEW.Dispositivo_id
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Dispositivo in Connessione deve comparire nella tabella Dispositivo';
  END IF;

END $$
DELIMITER ;

-- Ogni Utente in Connessione deve comparire nella tabella Utente
DROP TRIGGER IF EXISTS utente_connessione;

DELIMITER $$

CREATE TRIGGER utente_connessione
BEFORE INSERT ON Connessione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Utente U
     WHERE U.Codice = NEW.Utente_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Utente in Connessione deve comparire nella tabella Utente';
  END IF;

END $$
DELIMITER ;

-- Ogni regista in Film deve comparire nella tabella Regista
DROP TRIGGER IF EXISTS regista_film;

DELIMITER $$

CREATE TRIGGER regista_film
BEFORE INSERT ON Film FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Regista R
     WHERE R.IdRegista = NEW.Regista_idregista
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni regista in Film deve comparire nella tabella Regista';
  END IF;

END $$
DELIMITER ;

-- Ogni Film in Appartenenza deve comparire nella tabella Film
DROP TRIGGER IF EXISTS film_appartenenza;

DELIMITER $$

CREATE TRIGGER film_appartenenza
BEFORE INSERT ON Appartenenza FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Film F
     WHERE F.IdFilm = NEW.Film_idfilm
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Film in Appartenenza deve comparire nella tabella Film';
  END IF;

END $$
DELIMITER ;

-- Ogni Genere in Appartenenza deve comparire nella tabella Genere
DROP TRIGGER IF EXISTS genere_appartenenza;

DELIMITER $$

CREATE TRIGGER genere_appartenenza
BEFORE INSERT ON Appartenenza FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Genere G
     WHERE G.Nome = NEW.Genere_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Genere in Appartenenza deve comparire nella tabella Genere';
  END IF;

END $$
DELIMITER ;

-- Ogni Critico in RecensioneCritico deve comparire nella tabella Critico
DROP TRIGGER IF EXISTS critico_recensionecritico;

DELIMITER $$

CREATE TRIGGER critico_recensionecritico
BEFORE INSERT ON RecensioneCritico FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Critico C
     WHERE C.IdCritico = NEW.Critico_idcritico
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Critico in RecensioneCritico deve comparire nella tabella Critico';
  END IF;

END $$
DELIMITER ;

-- Ogni Film in RecensioneCritico deve comparire nella tabella Film
DROP TRIGGER IF EXISTS film_recensionecritico;

DELIMITER $$

CREATE TRIGGER film_recensionecritico
BEFORE INSERT ON RecensioneCritico FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Film F
     WHERE F.IdFilm = NEW.Film_idfilm
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Film in RecensioneCritico deve comparire nella tabella Film';
  END IF;

END $$
DELIMITER ;

-- Ogni Film in RecensioneUtente deve comparire nella tabella Film
DROP TRIGGER IF EXISTS film_recensioneutente;

DELIMITER $$

CREATE TRIGGER film_recensioneutente
BEFORE INSERT ON RecensioneUtente FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Film F
     WHERE F.IdFilm = NEW.Film_idfilm
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Film in RecensioneUtente deve comparire nella tabella Film';
  END IF;

END $$
DELIMITER ;

-- Ogni utente in RecensioneUtente deve comparire nella tabella Utente
DROP TRIGGER IF EXISTS utente_recensioneutente;

DELIMITER $$

CREATE TRIGGER utente_recensioneutente
BEFORE INSERT ON RecensioneUtente FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Utente U
     WHERE U.Codice = NEW.Utente_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni utente in RecensioneUtente deve comparire nella tabella Utente';
  END IF;

END $$
DELIMITER ;

-- Ogni Film in Interpretazione deve comparire nella tabella Film
DROP TRIGGER IF EXISTS film_interpretazione;

DELIMITER $$

CREATE TRIGGER film_interpretazione
BEFORE INSERT ON Interpretazione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Film F
     WHERE F.IdFilm = NEW.Film_idfilm
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Film in Interpretazione deve comparire nella tabella Film';
  END IF;

END $$
DELIMITER ;

-- Ogni Attore in Interpretazione deve comparire nella tabella Attore
DROP TRIGGER IF EXISTS attore_interpretazione;

DELIMITER $$

CREATE TRIGGER attore_interpretazione
BEFORE INSERT ON Interpretazione FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Attore A
     WHERE A.IdAttore = NEW.Attore_idattore
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Attore in Interpretazione deve comparire nella tabella Attore';
  END IF;

END $$
DELIMITER ;

-- Ogni Film in PremiazioneFilm deve comparire nella tabella Film
DROP TRIGGER IF EXISTS film_premiazionefilm;

DELIMITER $$

CREATE TRIGGER film_premiazionefilm
BEFORE INSERT ON PremiazioneFilm FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Film F
     WHERE F.IdFilm = NEW.Film_idfilm
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Film in PremiazioneFilm deve comparire nella tabella Film';
  END IF;

END $$
DELIMITER ;

-- Ogni PremioFilm in PremiazioneFilm deve comparire nella tabella PremioFilm
DROP TRIGGER IF EXISTS premiofilm_premiazionefilm;

DELIMITER $$

CREATE TRIGGER premiofilm_premiazionefilm
BEFORE INSERT ON PremiazioneFilm FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM PremioFilm P
     WHERE P.Codice= NEW.PremioFilm_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni PremioFilm in PremiazioneFilm deve comparire nella tabella PremioFilm';
  END IF;

END $$
DELIMITER ;

-- Ogni Attore in PremiazioneAttore deve comparire nella tabella Attore
DROP TRIGGER IF EXISTS attore_premiazioneattore;

DELIMITER $$

CREATE TRIGGER attore_premiazioneattore
BEFORE INSERT ON PremiazioneAttore FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Attore A
     WHERE A.IdAttore = NEW.Attore_idattore
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Attore in PremiazioneAttore deve comparire nella tabella Attore';
  END IF;

END $$
DELIMITER ;

-- Ogni PremioAttore in PremiazioneAttore deve comparire nella tabella PremioAttore
DROP TRIGGER IF EXISTS premioattore_premiazioneattore;

DELIMITER $$

CREATE TRIGGER premioattore_premiazioneattore
BEFORE INSERT ON PremiazioneAttore FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM PremioAttore P
     WHERE P.Codice = NEW.PremioAttore_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni PremioAttore in PremiazioneAttore deve comparire nella tabella PremioAttore';
  END IF;

END $$
DELIMITER ;

-- Ogni PremioRegista in PremiazioneRegista deve comparire nella tabella PremioRegista
DROP TRIGGER IF EXISTS premioregista_premiazioneregista;

DELIMITER $$

CREATE TRIGGER premioregista_premiazioneregista
BEFORE INSERT ON PremiazioneRegista FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM PremioRegista P
     WHERE P.Codice = NEW.PremioRegista_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni PremioRegista in PremiazioneRegista deve comparire nella tabella PremioRegista';
  END IF;

END $$
DELIMITER ;

-- Ogni Regista in PremiazioneRegista deve comparire nella tabella Regista
DROP TRIGGER IF EXISTS regista_premiazioneregista;

DELIMITER $$

CREATE TRIGGER regista_premiazioneregista
BEFORE INSERT ON PremiazioneRegista FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Regista R
     WHERE R.IdRegista = NEW.Regista_idregista
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Regista in PremiazioneRegista deve comparire nella tabella Regista';
  END IF;

END $$
DELIMITER ;

-- Ogni Paese in RestrizioneAbbonamento deve comparire nella tabella Paese
DROP TRIGGER IF EXISTS Restrizioneabbonamento_paese;

DELIMITER $$

CREATE TRIGGER Restrizioneabbonamento_paese
BEFORE INSERT ON RestrizioneAbbonamento FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Paese P
     WHERE P.Nome = NEW.Paese_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Paese in RestrizioneAbbonamento deve comparire nella tabella Paese';
  END IF;

END $$
DELIMITER ;

-- Ogni Abbonamento in RestrizioneAbbonamento deve comparire nella tabella Abbonamento
DROP TRIGGER IF EXISTS Restrizioneabbonamento_abbonamento;

DELIMITER $$

CREATE TRIGGER Restrizioneabbonamento_abbonamento
BEFORE INSERT ON RestrizioneAbbonamento FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Abbonamento A
     WHERE A.Nome = NEW.Abbonamento_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Abbonamento in RestrizioneAbbonamento deve comparire nella tabella Abbonamento';
  END IF;

END $$
DELIMITER ;

-- Ogni utente in CartaDiCredito deve comparire nella tabella Utente
DROP TRIGGER IF EXISTS utente_cartadicredito;

DELIMITER $$

CREATE TRIGGER utente_cartadicredito
BEFORE INSERT ON CartaDiCredito FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Utente U
     WHERE U.Codice = NEW.Utente_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni utente in CartaDiCredito deve comparire nella tabella Utente';
  END IF;

END $$
DELIMITER ;

-- Ogni utente in Fattura deve comparire nella tabella Utente
DROP TRIGGER IF EXISTS utente_fattura;

DELIMITER $$

CREATE TRIGGER utente_fattura
BEFORE INSERT ON Fattura FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Utente U
     WHERE U.Codice = NEW.Utente_codice
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni utente in Fattura deve comparire nella tabella Utente';
  END IF;

END $$
DELIMITER ;

-- Ogni CartaDiCredito in Fattura deve comparire nella tabella CartaDiCredito
DROP TRIGGER IF EXISTS cartadicredito_fattura;

DELIMITER $$

CREATE TRIGGER cartadicredito_fattura
BEFORE INSERT ON Fattura FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM CartaDiCredito C
     WHERE C.Numero = NEW.CartaDiCredito_numero
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni CartaDiCredito in Fattura deve comparire nella tabella CartaDiCredito';
  END IF;

END $$
DELIMITER ;

-- Ogni Paese in Utente deve comparire nella tabella Paese
DROP TRIGGER IF EXISTS utente_paese;

DELIMITER $$

CREATE TRIGGER utente_paese
BEFORE INSERT ON Utente FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Paese P
     WHERE P.Nome = NEW.Paese_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Paese in Utente deve comparire nella tabella Paese';
  END IF;

END $$
DELIMITER ;

-- Ogni Abbonamento in Utente deve comparire nella tabella Abbonamento
DROP TRIGGER IF EXISTS utente_abbonamento;

DELIMITER $$

CREATE TRIGGER utente_abbonamento
BEFORE INSERT ON Utente FOR EACH ROW
BEGIN
  DECLARE temp INT DEFAULT 0;
  SET temp = 
    (SELECT COUNT(*)
     FROM Abbonamento A
     WHERE A.Nome = NEW.Abbonamento_nome
    );
  IF temp = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ogni Abbonamento in Utente deve comparire nella tabella Abbonamento';
  END IF;

END $$
DELIMITER ;

