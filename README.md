
# Progetto TSW – Bricoshop

## Descrizione
Bricoshop è un progetto universitario sviluppato per il corso **Tecnologie Software per il Web (TSW)**.  
Si tratta di un’applicazione web di tipo e-commerce che consente la gestione di prodotti, utenti e ordini, con funzionalità di catalogo, carrello e checkout.

---

## Tecnologie utilizzate
- **Java 11+**  
- **JSP / Servlet** su **Apache Tomcat**  
- **JavaScript (AJAX)** per aggiornamenti dinamici (es. carrello)  
- **HTML5 / CSS3** (con validazioni tramite *stylelint* e *htmlhint*)  
- **MySQL** per la persistenza dei dati  
- **Maven** per il build management  
- **GitLab CI/CD** per validazione HTML/CSS (`.gitlab-ci.yml`)  

---

## Funzionalità principali
- Registrazione e login utenti  
- Gestione sessione e autenticazione  
- Catalogo prodotti con ricerca e filtro  
- Visualizzazione dettagli prodotto  
- Carrello dinamico (AJAX: aggiunta, rimozione, aggiornamento quantità senza ricaricare la pagina)  
- Checkout e gestione ordini  
- Amministrazione (CRUD prodotti e categorie)  
- Validazioni lato client e lato server  

---

## Struttura del progetto


ProgettoTsw/
├─ src/
│  ├─ main/
│  │   ├─ java/              # Classi Java (Servlet, Controller, DAO, Model)
│  │   ├─ resources/         # Configurazioni
│  │   └─ webapp/            # JSP, static (JS, CSS)
│  └─ test/                  # Test (se presenti)
├─ Prompt_SQL/               # Script SQL per database
├─ pom.xml                   # Configurazione Maven
├─ .gitlab-ci.yml            # Pipeline CI/CD per validazione HTML e CSS
├─ .stylelintrc.json         # Configurazione Stylelint
├─ .htmlhintrc               # Configurazione HTMLHint
└─ target/                   # Output di compilazione



---

## Requisiti
- **Java 11+**  
- **Apache Maven 3.6+**  
- **Apache Tomcat 9+**  
- **MySQL 8.x**  

---

## Installazione e setup
1. Clonare il repository:

   git clone https://github.com/Ettore20042/ProgettoTsw.git
   cd ProgettoTsw


2. Creare il database ed eseguire gli script presenti in `Prompt_SQL/`:

   CREATE DATABASE bricoshop;
   USE bricoshop;
   SOURCE Prompt_SQL/schema.sql;


3. Configurare le credenziali del DB (file `src/main/resources/...` o nel codice se presente un DAO con JDBC):

   db.url=jdbc:mysql://localhost:3306/bricoshop
   db.username=tuo_user
   db.password=tuo_password


4. Compilare il progetto:


   mvn clean package


5. Deploy del file `.war` generato su Tomcat (`target/ProgettoTsw.war`).

6. Avviare Tomcat e accedere all’applicazione su:


   http://localhost:8080/ProgettoTsw


---

## Utilizzo

* Registrarsi o effettuare il login.
* Sfogliare il catalogo prodotti.
* Aggiungere articoli al carrello tramite AJAX.
* Procedere al checkout e completare l’ordine.
* (Admin) Gestire catalogo e ordini dal pannello di amministrazione.

---

## CI/CD

Il progetto include una pipeline GitLab (`.gitlab-ci.yml`) che:

* Valida file **HTML** con *htmlhint*
* Valida file **CSS** con *stylelint*

---

## Autore

**La Luna,Cerrato,Rossetti** – Progetto per l’esame di *Tecnologie Software per il Web*
Università – A.A. 2024/2025

---

```

Vuoi che aggiunga anche un esempio concreto di **script SQL** dal tuo `Prompt_SQL/` (per utenti e prodotti) dentro al README, così è subito pronto per chi scarica?
```
