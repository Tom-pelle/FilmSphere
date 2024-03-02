use mydb;
-- ANALYTICS 1 - CLASSIFICHE
DROP PROCEDURE IF EXISTS genera_classifica;
DELIMITER $$
CREATE PROCEDURE genera_classifica()
BEGIN

    WITH classifica_versioni AS(
        SELECT U.Abbonamento_Nome AS TipoAbbonamento, U.Paese_nome AS Paese, V.FormatoAudio_codice as FormatoAudio , V.FormatoVideo_codice as FormatoVideo,
                V.CodiceVersione AS Versione, COUNT(SV.versione_codiceversione) AS Visualizzazioni
        FROM Servizio SV 
        INNER JOIN Versione V on SV.Versione_CodiceVersione = V.CodiceVersione
        inner join connessione C on Sv.IdServizio = C.Servizio_IdServizio
        INNER JOIN Utente U ON C.Utente_Codice = U.Codice
        GROUP BY U.Abbonamento_Nome, U.Paese_nome, V.FormatoAudio_codice, V.FormatoVideo_codice, V.CodiceVersione
    )
    SELECT TipoAbbonamento, Paese, FormatoAudio, FormatoVideo, Versione, Visualizzazioni, F.Titolo
    FROM classifica_versioni CV
    INNER JOIN Versione V ON V.CodiceVersione = CV.Versione
    INNER JOIN Film F ON F.IdFilm = V.Film_IdFilm
    ORDER BY Visualizzazioni DESC
    LIMIT 30;

END $$
DELIMITER ;

-- ANALYTICS 2 -- Statistiche per abbonamento
DROP PROCEDURE IF EXISTS stats_abbonamenti;
DELIMITER $$
CREATE PROCEDURE stats_abbonamenti()
BEGIN
    SELECT A.Nome AS TipoAbbonamento, 
        A.MaxOre,
        A.MaxGb,
        AVG(TIMESTAMPDIFF(HOUR, S.Inizio, S.Fine)) AS TempoMedioVisione,
        SUM(TIMESTAMPDIFF(HOUR, S.Inizio, S.FIne)) AS TempoTotaleVisione,
        SUM(TIMESTAMPDIFF(HOUR, C.Inizio, C.Fine)) AS TempoTotaleConnesso,
        SUM(TIMESTAMPDIFF(HOUR, S.Inizio, S.Fine)) / COUNT(S.IdServizio) AS TempoMedioVisione,
        SUM(V.Dimensione) AS SommaGBUsati
    FROM Connessione C
    INNER JOIN Utente U ON C.Utente_Codice = U.Codice
    INNER JOIN Servizio S ON C.Servizio_IdServizio = S.IdServizio
    INNER JOIN Abbonamento A ON U.Abbonamento_Nome = A.Nome
    INNER JOIN Versione V ON S.Versione_CodiceVersione = V.CodiceVersione
    WHERE C.Inizio > CURRENT_DATE - INTERVAL 6 MONTH
    GROUP BY A.Nome;
END $$
DELIMITER ;