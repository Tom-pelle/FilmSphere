# FilmSphere 

**FilmSphere** è un sistema di gestione per una piattaforma di streaming video online.
Progetto sviluppato per il corso di *Basi di Dati (cod. 861II)* del Corso di Laurea in Ingegneria Informatica presso l'Università di Pisa.

L'obiettivo è progettare e implementare un database relazionale su **DBMS Oracle MySQL** in grado di gestire un vasto catalogo di film, utenti, abbonamenti e logiche di streaming, supportando operazioni complesse e funzionalità di data analytics.

## Struttura del Progetto

Il repository è organizzato come segue:

- **`SQL/`**: Contiene tutti gli script per la creazione e gestione del database.
  - `script.sql`: Creazione dello schema e delle tabelle.
  - `popolamento.sql`: Script per l'inserimento dei dati iniziali.
  - `trigger.sql`: Definizione dei trigger per automatizzare controlli e aggiornamenti.
  - `operazioni.sql`: Stored procedures e operazioni comuni.
  - `analytics.sql`: Query complesse per l'analisi dei dati (es. visualizzazioni per genere, statistiche utenti).
- **`Generazione di dati/`**: Script Python utilizzati per generare dati sintetici realistici per popolare il database (Utenti, Fatture, Streaming, ecc.).
- **`ER/`**: Diagrammi Entity-Relationship (Concettuale e Logico).
- **`Documentazione.pdf`**: Relazione tecnica dettagliata del progetto.

## Funzionalità Principali

- **Gestione Utenti & Abbonamenti**: Tracciamento di profili, metodi di pagamento e storico fatturazione.
- **Catalogo Multimediale**: Organizzazione di film, generi, cast e produzioni.
- **Sistema di Streaming**: Gestione delle sessioni di visione e qualità dello stream.
- **Automazione**: Trigger per garantire l'integrità referenziale e regole di business.
- **Business Intelligence**: Query analitiche per estrarre insight sulla piattaforma (es. film più visti, trend di visualizzazione).

### Prerequisiti
- **MySQL Server** (8.0 o superiore)
- **Python 3.x** (se si desidera rigenerare i dati)

### Setup del Database
1. Clona il repository:
   ```bash
   git clone https://github.com/Tom-pelle/FilmSphere.git

2. Accedi alla tua istanza MySQL e crea il database: esegui gli script SQL nel seguente ordine per evitare errori di dipendenza:
  - SQL/script.sql (Creazione tabelle)
  - SQL/trigger.sql (Definizione trigger)
  - SQL/popolamento.sql (Inserimento dati)
  - SQL/operazioni.sql (Procedure opzionali)

3. Se desideri generare un nuovo set di dati di test, naviga nella cartella **Generazione di dati** ed esegui i relativi script Python.
    
## Autori
Tommaso Pellegrini - Tom-pelle
Niccolò Franchi
