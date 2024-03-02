use mydb;
-- 1) RATING GLOBALE DI UN FILM

-- Trigger che aggiorna l'attributo visualizzazioni ogni volta che viene erogata
-- una versione del film
DROP TRIGGER IF EXISTS nuova_visualizzazione;
DELIMITER $$
CREATE TRIGGER nuova_visualizzazione
AFTER INSERT ON Servizio
FOR EACH ROW
BEGIN
    DECLARE v_IDFILM INT;

    -- Ottiene l'IdFilm associato all'erogazione
    SELECT Film_IdFilm INTO v_IDFILM
    FROM Versione
    WHERE CodiceVersione = NEW.Versione_CodiceVersione;

    -- Aggiona numero di visualizzazioni 
    UPDATE Film
    SET NumeroDiVisualizzazioni = NumeroDiVisualizzazioni + 1
    WHERE IdFilm = v_IDFILM;
END $$
DELIMITER ;

-- Procedura che calcola il rating, lo restituisce e aggiorna l'attributo 
DROP PROCEDURE IF EXISTS rating_globale;
DELIMITER $$
CREATE PROCEDURE rating_globale(IN film_id INT, OUT voto DOUBLE)
BEGIN
    DECLARE mediaUtenti DOUBLE;
    DECLARE mediaCritici DOUBLE;
    DECLARE nUtenti INT;
    DECLARE nCritici INT;
    DECLARE nVis INT;
    DECLARE pVis DOUBLE;

    -- Media voti utenti
    SELECT AVG(RU.Voto) INTO mediaUtenti
    FROM RecensioneUtente RU
    WHERE RU.Film_IdFilm = film_id;

    -- Media voti critici
    SELECT AVG(RC.Voto) INTO mediaCritici
    FROM RecensioneCritico RC
    WHERE RC.Film_IdFilm = film_id;

    -- Numero recensioni utente
    SELECT COUNT(*) INTO nUtenti
    FROM RecensioneUtente
    WHERE Film_IdFilm = film_id;

    -- Numero recensioni critici
    SELECT COUNT(*) INTO nCritici
    FROM RecensioneCritico
    WHERE Film_IdFilm = film_id;

    -- Numero visualizzazioni
    SELECT NumeroDiVisualizzazioni INTO nVis
    FROM Film
    WHERE IdFilm = film_id;

    SET pVis := CASE 
                WHEN nVis < 30000 THEN 0
                WHEN nVis < 45000 THEN 1
                WHEN nVis < 60000 THEN 2
                WHEN nVis < 75000 THEN 3
                WHEN nVis < 90000 THEN 4
                ELSE 5
            END;
        
    -- Calcolo voto
    IF nUtenti > 0 AND nCritici > 0 AND nVis > 0 THEN
        SET voto = mediaUtenti * 0.30 + mediaCritici * 0.30 + pVis * 0.40;
        -- Aggiorno voto
        UPDATE Film
        SET PunteggioGlobale = voto 
        WHERE IdFilm = film_id;
    ELSE
        SET voto = 0;
    END IF;

END $$
DELIMITER ;

-- 2) RESTRIZIONE FILM PAESE
DROP PROCEDURE IF EXISTS film_vietati;
DELIMITER $$
-- Si ipotizza un indirizzo ip in ingresso fornito in questo fomrato "001002003004"
CREATE PROCEDURE film_vietati(IN user_ip VARCHAR(12))
BEGIN
    DECLARE Codice INT;
    DECLARE nomePaese VARCHAR(45); 

    DECLARE stringa varchar(3);
    SET stringa = LEFT(user_ip, 3);

    -- Recupera nome paese corrispondente 
    SELECT P.Nome INTO nomePaese
    FROM Paese P
    WHERE P.Ip = stringa;

    -- Errore se paese non trovato
    IF nomePaese IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Paese non trovato per l''indirizzo IP fornito.';
    END IF;

    -- Recupera film vietati nel paese corrispondente
    SELECT DISTINCT F.Titolo
    FROM Film F
    INNER JOIN Versione V ON V.Film_IdFilm = F.IdFilm
    INNER JOIN RestrizioneVersione RV ON V.CodiceVersione = RV.Versione_CodiceVersione
    WHERE RV.Paese_Nome = nomePaese;

END $$
DELIMITER ;

-- 3) INDIVIDUAZIONE DEL SERVER MIGLIORE

-- Trigger per l'aggironamento della capacità rimanente
-- Aggiorna capacità rimanente del server dopo l'inserimento di una nuova riga in Memorizzazione
drop trigger if exists aggiorna_capacita_rimanente_ins;
DELIMITER $$
CREATE TRIGGER aggiorna_capacita_rimanente_ins
AFTER INSERT ON Memorizzazione
FOR EACH ROW
BEGIN
if NEW.fine is null then
    UPDATE Server
    SET CapacitaRimanente = CapacitaRimanente - (
        SELECT Dimensione
        FROM Versione V
        WHERE V.CodiceVersione = NEW.Versione_CodiceVersione
    )
    WHERE IdServer = NEW.Server_IdServer;
    end if;
END $$

delimiter ;
drop trigger if exists aggiorna_capacita_rimanente_upd;
DELIMITER $$

-- Aggiorna capacità rimanente del server dopo che una memorizzazione è conclusa
CREATE TRIGGER aggiorna_capacita_rimanente_upd
AFTER UPDATE ON Memorizzazione
FOR EACH ROW
BEGIN
    IF NEW.Fine = TRUE THEN
        UPDATE SERVER
        SET CapacitaRimanente = CapacitaRimanente + (
            SELECT Dimensione
            FROM Versione
            WHERE CodiceVersione = NEW.Versione_CodiceVersione
        )
        WHERE IdServer = NEW.Server_IdServer;
    END IF;
END $$
DELIMITER ;

-- Procedura che calcola il server migliore
DROP PROCEDURE IF EXISTS server_migliori;
DELIMITER $$

CREATE PROCEDURE server_migliori(
    IN user_ip varchar(12), 
    IN versione_film INT
)
BEGIN
    DECLARE nomePaese VARCHAR(45);
    -- Nome del paese per il primo numero dell'indirizzo IP fornito
    declare stringa varchar(3);
    set stringa= left(user_ip, 3);
   
   SELECT NOME INTO nomePaese
    FROM Paese 
    WHERE Ip=stringa;

    -- Popola i punteggi dei server 
    SELECT S.IdServer, 
           (CASE 
                WHEN D.Valore < 500 THEN 5
                WHEN D.Valore BETWEEN 500 AND 999 THEN 4
                WHEN D.Valore BETWEEN 1000 AND 2999 THEN 3
                WHEN D.Valore BETWEEN 3000 AND 4999 THEN 2
                WHEN D.Valore BETWEEN 5000 AND 9999 THEN 1
                ELSE 0
            END +
            CASE 
                WHEN S.LarghezzaDiBanda <= 5 THEN 0
                WHEN S.LarghezzaDiBanda BETWEEN 6 AND 10 THEN 1
                WHEN S.LarghezzaDiBanda BETWEEN 11 AND 20 THEN 2
                ELSE 3
            END +
            CASE 
                WHEN S.CapacitaRimanente <= 100 THEN 0
                WHEN S.CapacitaRimanente BETWEEN 101 AND 500 THEN 1
                ELSE 2
            END) AS Punteggio
    FROM Server S
    INNER JOIN Distanza D ON S.IdServer = D.Server_IdServer
    WHERE D.Paese_Nome = nomePaese
    ORDER BY Punteggio DESC
    LIMIT 1;
END $$
DELIMITER ;

-- 4) SERVER PIENO
DROP PROCEDURE IF EXISTS server_pieno;
DELIMITER $$
CREATE PROCEDURE server_pieno(
    IN server_id INT, 
    OUT pieno TINYINT
)
BEGIN
    DECLARE capacity INT;
    DECLARE server_status VARCHAR(20);

    -- capacità rimanente del server specificato
    SELECT CapacitaRimanente INTO capacity
    FROM Server
    WHERE IdServer = server_id;

    -- Verifica stato server
    IF capacity = 0 THEN
        SET pieno = 1;
    ELSE
        SET pieno = 0;
    END IF;

END $$
DELIMITER ;

-- 5) REGISTRAZIONE E SOTTOSCRIZIONE ABBONAMENTO
DROP PROCEDURE IF EXISTS registrazione_pagamento;
DELIMITER $$
CREATE PROCEDURE registrazione_pagamento(
    IN nuovo_nome VARCHAR(45),
    IN nuovo_cognome VARCHAR(45),
    IN nuovo_email VARCHAR(45),
    IN nuovo_datanascita DATE,
    IN nuovo_pass VARCHAR(45),
    IN nome_abbonamento VARCHAR(45),
    IN nuovo_paese VARCHAR(45),
    IN numero_carta VARCHAR(16),
    IN cvv_carta INT,
    IN mese_carta INT, 
    IN anno_carta INT
)
BEGIN
    -- Il nuovo utente non può avere una mail già presente sulla piattaforma
    DECLARE eta_user INT;
       DECLARE nuovo_idutente INT;
    DECLARE id_carta INT;
    DECLARE saldo_abbonamento DECIMAL(10, 2);
    declare id_fattura int;
    
    select max(Codice)+1 into nuovo_idutente
    from Utente;
    
    select max(IdFattura)+1 into id_fattura
    from fattura;
    
    IF nuovo_email IN (
        SELECT U.IndirizzoEmail
        FROM Utente U
    ) THEN
        signal sqlstate '45000'
        set message_text= 'Indirizzo email non valido';
    END IF;
    -- Un utente minore di 14 anni non può sottoscrivere un abbonamento Basic o Premium e 
    -- un utente minore di 18 anni non può sottoscrivere un abbonamento Pro, Deluxe o Ultimate
    
    -- età dell'utente
    SET eta_user = TIMESTAMPDIFF(YEAR, nuovo_datanascita, CURDATE());
    
    -- Verifica per abbonamenti Pro, Deluxe e Ultimate
    IF eta_user < 18 THEN
        IF nome_abbonamento IN ('Pro', 'Deluxe', 'Ultimate') THEN
			signal sqlstate '45000'
            set message_text= 'Abbonamento selezionato non valido';
           
        END IF;
    END IF;
    
    -- Verifica per abbonamenti Basic e Premium
    IF eta_user < 14 THEN       
        IF subscription_name IN ('Basic', 'Premium') THEN
            signal sqlstate '45000'
            set message_text= 'Abbonamento selezionato non valido';
        END IF;
    END IF;

 

    IF nome_abbonamento NOT IN (SELECT Nome FROM Abbonamento ) then
        signal sqlstate '45000'
	    set message_text= 'Abbonamento non valido';
    END if;

    IF EXISTS (SELECT Paese_Nome FROM RestrizioneAbbonamento RA 
                WHERE RA.Paese_Nome = nuovo_paese AND nome_abbonamento = RA.Abbonamento_Nome) then
                signal sqlstate '45000'
	            set message_text= 'Errore: nel paese non è disponibile l''abbonamento';
    END if;

    -- Inserisce il nuovo utente nella tabella Utente
    INSERT INTO Utente (Codice, Nome, Cognome, IndirizzoEmail, DataNascita, Password, Abbonamento_Nome, Paese_Nome)
    VALUES (nuovo_idutente,nuovo_nome, nuovo_cognome, nuovo_email, nuovo_datanascita, nuovo_pass, nome_abbonamento, nuovo_paese);
    
    
    -- Ottiene il saldo associato all'abbonamento
    SELECT Tariffa INTO saldo_abbonamento
    FROM Abbonamento
    WHERE Nome = nome_abbonamento;
    
    -- Inserisce la carta di credito associata al nuovo utente nella tabella CartaDiCredito
    INSERT INTO CartaDiCredito (Numero, Cvv, Intestatario, AnnoScadenza, MeseScadenza, Attiva, Utente_Codice)
    VALUES (numero_carta, cvv_carta, CONCAT(nuovo_nome, " ", nuovo_cognome), anno_carta, mese_carta, 1, nuovo_idutente);
    
    -- Inserisce la fattura relativa all'abbonamento per il nuovo utente nella tabella Fattura
    INSERT INTO Fattura (IdFattura,CartaDiCredito_Numero, Utente_Codice, Saldo, Emissione, Scadenza)
    VALUES (id_fattura,numero_carta, nuovo_idutente, saldo_abbonamento, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY));
END $$

DELIMITER ;

-- 6) MODIFICA DEL METODO DI PAGAMENTO DI UN UTENTE
DROP PROCEDURE IF EXISTS modifica_pagamento;
DELIMITER $$
CREATE PROCEDURE modifica_pagamento (
    IN NumeroCarta VARCHAR(16),
    IN CodiceUtente INT,
    IN CVV INT,
    IN AScad INT, 
    IN MScad INT
)
BEGIN
	declare _nome varchar(45);
    declare _cognome varchar(45);
    UPDATE CartaDiCredito
    SET Attiva = 0
    WHERE Utente_Codice = CodiceUtente;
    
    Select Nome into _nome
    from Utente
    where Codice= CodiceUtente;
    
	Select Cognome into _cognome
    from Utente
    where Codice= CodiceUtente;

    INSERT INTO CartaDiCredito (Numero, Cvv, Intestatario, AnnoScadenza, 
                                MeseScadenza, Attiva, Utente_Codice)
    VALUES (NumeroCarta, Cvv,
            CONCAT(_nome, " ", _cognome),  
            AScad, MScad,
            1, CodiceUtente);
END $$
DELIMITER ;

-- 7) VERSIONI DISPONIBILI PER UN FILM
DROP PROCEDURE IF EXISTS versioni_disponibili;
DELIMITER $$

CREATE PROCEDURE versioni_disponibili(
    IN user_ip varchar(12),
    IN titolo_film VARCHAR(45)
)
BEGIN
    DECLARE nome_paese VARCHAR(45);
    declare stringa varchar(3);
    set stringa= left (user_ip,3);
    
    -- Trova l'ID del paese corrispondente all'indirizzo IP fornito
    SELECT Nome INTO nome_paese 
    FROM Paese 
    WHERE Ip=stringa;
    
    -- Seleziona le versioni disponibili del film escludendo quelle vietate nel paese corrispondente
    SELECT DISTINCT V.CodiceVersione, V.Anno, V.Dimensione, FA.Qualita AS qualità_audio, FA.Bitrate AS bitrate_audio,
           FV.qualita AS qualità_video, FV.RapportoDAspetto AS rapporto_d_aspetto_video,
           FV.risoluzione AS risoluzione_video, FV.BitRate AS bitrate_video
    FROM Film F
    INNER JOIN Versione V ON F.IdFilm = V.FIlm_IdFilm
    LEFT JOIN FormatoAudio FA ON V.FormatoAudio_Codice = FA.Codice
    LEFT JOIN FormatoVideo FV ON V.FormatoVideo_Codice = FV.Codice
    LEFT JOIN RestrizioneVersione RV ON V.CodiceVersione = RV.Versione_CodiceVersione
    WHERE F.Titolo = titolo_film
    AND RV.Versione_CodiceVersione NOT IN(
        SELECT RV2.versione_CodiceVersione
        FROM RestrizioneVersione RV2
        WHERE RV2.Paese_Nome = nome_paese
    );
END $$
DELIMITER ;

-- 8) GENERI PREFERITI
DROP PROCEDURE IF EXISTS generi_preferiti;
DELIMITER $$
CREATE PROCEDURE generi_preferiti(IN cod_utente INT)
BEGIN
    SELECT A.Genere_Nome AS Genere, COUNT(*) AS Visualizzazioni
    FROM Utente U
    INNER JOIN Connessione C ON U.Codice = C.Utente_Codice
    INNER JOIN Servizio S ON C.Servizio_IdServizio = S.IdServizio
    inner join Versione V on V.codiceVersione=S.Versione_CodiceVersione
    inner join Film F on F.IdFIlm=V.film_IdFIlm
    INNER JOIN Appartenenza A ON F.IdFilm = A.Film_IdFilm
    WHERE U.Codice = cod_utente
    GROUP BY A.Genere_Nome
    ORDER BY Visualizzazioni DESC
    LIMIT 3;
END $$
DELIMITER ;