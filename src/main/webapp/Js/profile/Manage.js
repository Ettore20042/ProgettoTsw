/**
 * Manage.js - Sistema di gestione unificato per il pannello amministrativo
 * Gestisce tutte le entità: prodotti, brand, categorie, admin, utenti
 *
 * Questo file implementa un pattern modulare per la gestione del pannello admin:
 * - ManageSystem: Classe principale che coordina tutto il sistema
 * - BaseManager: Classe base con funzionalità comuni per tutti i manager
 * - Caricamento dinamico dei manager specifici in base all'entità corrente
 *
 * Pattern utilizzati:
 * - Singleton: ManageSystem ha una sola istanza globale
 * - Factory: Crea il manager appropriato in base all'entità
 * - Observer: Sistema di eventi personalizzati
 *
 */


class ManageSystem {
    /**
     * Costruttore della classe ManageSystem.
     * Inizializza la configurazione base e avvia il processo di inizializzazione.
     */
    constructor() {
        // Configurazione del sistema recuperata dal DOM
        this.config = {
            // Context path dell'applicazione per costruire URL corretti
            contextPath: document.body.dataset.contextPath,
            // Tipo di entità gestita (products, brands, categories, admins, users)
            entity: document.body?.dataset.entity || 'products',
            // Flag per abilitare/disabilitare il logging di debug
            debug: true
        };

        // Manager attualmente attivo per l'entità corrente
        this.currentManager = null;
        // Flag che indica se il sistema è stato completamente inizializzato
        this.isInitialized = false;


        // Avvia il processo di inizializzazione asincrono
        this.initialize();
    }

    /**
     * Inizializza il sistema completo in modo asincrono.
     * Gestisce tutti i passaggi necessari per rendere operativo il sistema.
     * In caso di errore, attiva automaticamente la modalità fallback.
     */
    async initialize() {
        try {


            // Fase 1: Inizializza gli elementi comuni dell'interfaccia (modale, messaggi, barra di ricerca)
            this.initializeCommonElements();


            // Fase 3: Istanzia e configura il manager appropriato
            this.initializeManager();



        } catch (error) {
            // In caso di errore durante l'inizializzazione, attiva la modalità fallback
            this.log('❌ Errore durante l\'inizializzazione:', error);
            this.initializeFallback();
        }
    }

    /**
     * Carica dinamicamente il manager specifico per l'entità corrente.
     * Utilizza una mappa per associare ogni entità al suo file JavaScript corrispondente.
     */
   /* async loadManagers() {
        // Mappa delle entità ai loro file manager corrispondenti
        const managers = {
            products: 'ProductManager.js',      // Gestione prodotti
            brands: 'BrandManager.js',         // Gestione brand/marchi
            categories: 'CategoryManager.js',   // Gestione categorie
            admins: 'UserManager.js',           // Gestione admin (usa lo stesso manager degli utenti)
            users: 'UserManager.js'            // Gestione utenti (usa lo stesso manager degli admin)
        };

        // Determina quale file manager caricare in base all'entità corrente
        const currentManagerFile = managers[this.config.entity];
        console.log(`🔍 Caricamento manager per entità: ${this.config.entity} (${currentManagerFile})`);

        if (currentManagerFile) {
            try {
                // Carica il file JavaScript del manager dalla cartella managers/
                await this.loadScript(`Js/profile/managers/${currentManagerFile}`);
                this.log(`✅ Manager caricato: ${currentManagerFile}`);
            } catch (error) {
                // Log dell'errore ma non blocca l'esecuzione (verrà usato BaseManager)
                this.log(`⚠️ Errore caricamento manager ${currentManagerFile}:`, error);
            }
        }
    }*/

    /**
     * Utility per caricare script JavaScript dinamicamente.
     * Previene il caricamento duplicato dello stesso script.
     *
     * @param {string} src - URL del file JavaScript da caricare
     * @returns {Promise} Promise che si risolve quando lo script è caricato
     */
    /*loadScript(src) {
        return new Promise((resolve, reject) => {
            // Controlla se lo script è già stato caricato per evitare duplicati
            if (document.querySelector(`script[src="${src}"]`)) {
                resolve();
                return;
            }

            // Crea e configura l'elemento script
            const script = document.createElement('script');
            script.src = src;
            script.type = 'text/javascript';

            // Configura i callback per successo e fallimento
            script.onload = resolve;
            script.onerror = reject;

            // Aggiunge lo script al DOM per avviare il caricamento
            document.head.appendChild(script);
        });
    }*/

    /**
     * Inizializza tutti gli elementi comuni dell'interfaccia utente.
     * Trova e memorizza i riferimenti agli elementi DOM utilizzati da tutto il sistema.
     */
    initializeCommonElements() {
        // Elemento modale principale (con fallback per nomi diversi)
        this.modal = document.getElementById("productModal") || document.getElementById("modal");
        // Elemento per mostrare messaggi di feedback all'utente
        this.messageElement = document.getElementById("message");
        // Campo di input della barra di ricerca
        this.searchInput = document.getElementById("searchBarTable");
        // Contenitore per i suggerimenti di ricerca
        this.suggestionBox = document.getElementById("suggestions-for-table");
        // Wrapper che contiene tutta la barra di ricerca (per styling)
        this.searchWrapper = document.querySelector('.manage-components-container-right_search-bar');

        // Inizializza il sistema di suggerimenti solo se tutti gli elementi necessari esistono
        if (this.searchInput && this.suggestionBox && this.searchWrapper) {
            this.initializeSuggestions();
        }
    }

    /**
     Il metodo `initializeManager()` implementa un sistema di polling che attende fino a 5 secondi che il manager specifico
     per l'entità corrente (ProductManager, BrandManager, etc.) sia disponibile nella finestra globale.
     Se il manager viene trovato, lo istanzia e completa l'inizializzazione del sistema; altrimenti,
     dopo il timeout, utilizza il BaseManager come fallback per garantire che l'applicazione rimanga funzionale.
     Utilizza un approccio ricorsivo con `setTimeout` per verificare periodicamente la disponibilità del manager
     senza bloccare il thread principale.
     *
     */
    initializeManager() {
        const maxAttempts = 50; // 5 secondi massimo (50 * 100ms)
        let attempts = 0;

        const checkAndInitialize = () => {
            const managers = {
                products: window.ProductManager,
                brands: window.BrandManager,
                categories: window.CategoryManager,
                admins: window.UserManager,
                users: window.UserManager
            };

            const ManagerClass = managers[this.config.entity];

            if (ManagerClass) {
                //  Il manager è disponibile, procedi con l'inizializzazione
                this.currentManager = new ManagerClass(this);
                this.log(`✅ Manager inizializzato: ${ManagerClass.name}`);

                // Continua con l'inizializzazione
                this.setupGlobalEventListeners();
                this.isInitialized = true;
               /* this.dispatchEvent('manage:system:ready', {
                    entity: this.config.entity,
                    manager: this.currentManager
                });*/
            } else if (attempts < maxAttempts) {
                // Il manager non è ancora disponibile, riprova tra 100ms
                attempts++;
                this.log(` Tentativo ${attempts}/${maxAttempts} per ${this.config.entity}...`);
                setTimeout(checkAndInitialize, 100);
            } else {
                // Timeout raggiunto, usa BaseManager come fallback
                this.log(`️ Timeout nel caricamento del manager per ${this.config.entity}, uso BaseManager`);
                this.currentManager = new BaseManager(this);
                this.setupGlobalEventListeners();
                this.isInitialized = true;
            }
        };

        checkAndInitialize();
    }

    /**
     * Inizializza il sistema di suggerimenti automatici per la barra di ricerca.
     * Implementa debouncing per evitare troppe richieste al server.
     */
    initializeSuggestions() {
        // Variabile per il debouncing (ritarda le richieste consecutive)
        let timeout = null;

        // Event listener per l'input della barra di ricerca
        this.searchInput.addEventListener('input', (e) => {
            // Cancella il timeout precedente per implementare il debouncing
            clearTimeout(timeout);
            // Ottiene il valore dell'input rimuovendo spazi vuoti
            const value = e.target.value.trim();

            // Se l'input è vuoto, nasconde i suggerimenti
            if (value.length === 0) {
                this.hideSuggestions();
                return;
            }

            // Imposta un nuovo timeout di 300ms prima di fare la richiesta
            // Questo evita di fare troppe richieste mentre l'utente sta digitando
            timeout = setTimeout(() => {
                this.fetchSuggestions(value);
            }, 300);
        });
    }

    /**
     * Recupera i suggerimenti dal server in base alla query dell'utente.
     * Gestisce la risposta e aggiorna l'interfaccia di conseguenza.
     *
     * @param {string} query - Testo inserito dall'utente per la ricerca
     */
    async fetchSuggestions(query) {
        try {
            // Costruisce l'URL per la richiesta dei suggerimenti
            const url = `${this.config.contextPath}/SuggestionsServlet?entity=${this.config.entity}&query=${encodeURIComponent(query)}`;
            // Esegue la richiesta HTTP
            const response = await fetch(url);
            // Parsifica la risposta JSON
            const results = await response.json();

            // Pulisce il contenitore dei suggerimenti precedenti
            this.suggestionBox.innerHTML = '';

            // Se non ci sono risultati, nasconde i suggerimenti
            if (results.length === 0) {
                this.hideSuggestions();
                return;
            }

            // Mostra i suggerimenti ricevuti
            this.showSuggestions(results);
        } catch (error) {
            // In caso di errore, log e nasconde i suggerimenti
            console.error('Errore nel recupero suggerimenti:', error);
            this.hideSuggestions();
        }
    }

    /**
     * Mostra i suggerimenti nell'interfaccia utente.
     * Crea elementi DOM per ogni suggerimento e configura i loro event listener.
     *
     * @param {Array} results - Array di stringhe contenenti i suggerimenti
     */
    showSuggestions(results) {
        // Rende visibile il contenitore dei suggerimenti
        this.suggestionBox.classList.add('active');
        this.searchWrapper.classList.add('active');

        // Crea un elemento DOM per ogni suggerimento
        results.forEach(item => {
            const div = document.createElement('div');
            div.textContent = item;
            div.classList.add('suggestion-for-table-item');
            div.setAttribute('role', 'option'); // Aggiunge ruolo per accessibilità


            // Configura il click sul suggerimento
            div.addEventListener('click', () => {
                // Imposta il valore selezionato nella barra di ricerca
                this.searchInput.value = item;
                // Nasconde i suggerimenti
                this.hideSuggestions();
                // Sottomette automaticamente il form di ricerca
                this.searchInput.form.submit();
            });

            // Aggiunge l'elemento al contenitore
            this.suggestionBox.appendChild(div);
        });
    }

    /**
     * Nasconde il contenitore dei suggerimenti e pulisce il suo contenuto.
     */
    hideSuggestions() {
        // Pulisce il contenuto
        this.suggestionBox.innerHTML = '';
        // Rimuove le classi CSS che rendono visibile il contenitore
        this.suggestionBox.classList.remove('active');
        this.searchWrapper.classList.remove('active');
    }

    /**
     * Configura tutti gli event listener globali del sistema.
     * Coordina l'inizializzazione di modale, switch entità e shortcut da tastiera.
     */
    setupGlobalEventListeners() {
        // Configura gli eventi del modale (apertura, chiusura)
        this.setupModalEvents();
        // Configura il cambio dinamico di entità
       /* this.setupEntitySwitching();*/

        // Configura le scorciatoie da tastiera
        this.setupKeyboardShortcuts();
    }

    /**
     * Configura tutti gli event listener relativi al modale.
     * Gestisce apertura, chiusura tramite pulsanti, ESC e click fuori dal modale.
     */
    setupModalEvents() {
        // Configura i pulsanti di apertura del modale
        const addButton = document.getElementById("add-btn");
            if(addButton) {
                addButton.addEventListener('click', (e) => {
                    e.preventDefault(); // Previene il comportamento di default del link/button
                    this.openModal();
            });
        }


        // Configura i pulsanti di chiusura del modale
        const closeModal = document.getElementById("close-modal");
            if(closeModal){
                // Aggiunge l'evento di click per chiudere il modale
                closeModal.addEventListener('click', (e) => {
                    e.preventDefault(); // Previene il comportamento di default del link/button
                    this.closeModal();
                });
            }



        // Configura la chiusura del modale con il tasto ESC
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                this.closeModal();
            }
        });

        // Configura la chiusura del modale cliccando fuori dall'area del contenuto
        if (this.modal) {
            this.modal.addEventListener('click', (e) => {
                // Chiude solo se si clicca direttamente sul backdrop (non sui figli)
                if (e.target === this.modal) {
                    this.closeModal();
                }
            });
        }
    }

    /**
     * Configura il sistema di cambio dinamico di entità.
     * Permette di passare da una gestione all'altra (es. da prodotti a brand) senza ricaricare la pagina.
     */
    /*setupEntitySwitching() {
        // Trova tutti gli elementi che permettono di cambiare entità
        const entitySwitchers = document.querySelectorAll('[data-entity]:not(body)'); //Esclude il body per evitare conflitti
        entitySwitchers.forEach(switcher => {
            switcher.addEventListener('click', async (e) => {
                // Ottiene la nuova entità dall'attributo data-entity
                const newEntity = switcher.dataset.entity;
                // Se è diversa dall'entità corrente, effettua il cambio
                if (newEntity !== this.config.entity) {
                    await this.switchEntity(newEntity);
                }
            });
        });
    }*/

    /**
     * Configura le scorciatoie da tastiera per migliorare l'usabilità.
     * Implementa shortcut comuni per operazioni frequenti.
     */
    setupKeyboardShortcuts() {
        document.addEventListener('keydown', (e) => {
            // Ctrl+N: Apre il modale per aggiungere un nuovo elemento
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault(); // Previene l'apertura di una nuova finestra del browser
                this.openModal();
            }

            // Ctrl+S: Salva il form se il modale è aperto
            if (e.ctrlKey && e.key === 's') {
                const modal = this.modal;
                // Verifica che il modale sia visibile
                if (modal && modal.style.display !== 'none') {
                    e.preventDefault(); // Previene il salvataggio della pagina
                    const submitBtn = document.getElementById('submitBtn');
                    if (submitBtn) {
                        submitBtn.click(); // Simula il click sul pulsante di submit
                    }
                }
            }
        });
    }

    /**
     * Cambia dinamicamente l'entità gestita dal sistema.
     * Ricarica il manager appropriato e aggiorna la configurazione.
     *
     * @param {string} newEntity - Nuova entità da gestire (products, brands, etc.)
     */
    /*async switchEntity(newEntity) {
        try {
            this.log(`🔄 Cambio entità da ${this.config.entity} a ${newEntity}`);

            // Aggiorna la configurazione interna
            this.config.entity = newEntity;
            // Aggiorna anche l'attributo nel DOM per coerenza
            document.body.dataset.entity = newEntity;

            // Carica il nuovo manager specifico per l'entità
           /!* await this.loadManagers();*!/
            // Inizializza il nuovo manager
            this.initializeManager();

            // Notifica il cambio di entità a tutti i listener
            this.dispatchEvent('manage:entity:changed', {
                oldEntity: this.config.entity,
                newEntity: newEntity,
                manager: this.currentManager
            });

            this.log(`✅ Entità cambiata con successo: ${newEntity}`);

        } catch (error) {
            this.log(`❌ Errore nel cambio entità:`, error);
        }
    }*/

    /**
     * Apre il modale utilizzando il manager corrente se disponibile, altrimenti usa il fallback.
     * Invia un evento personalizzato per notificare l'apertura.
     */
    openModal() {
        // Prova a usare il metodo openModal del manager corrente
        if (this.currentManager && typeof this.currentManager.openModal === 'function') {
            this.currentManager.openModal();
        } else if (this.modal) {
            // Fallback: mostra direttamente il modale
            this.modal.style.display = 'flex';
        }
        // Notifica l'apertura del modale
        /*this.dispatchEvent('manage:modal:opened');*/

    }

    /**
     * Chiude il modale utilizzando il manager corrente se disponibile, altrimenti usa il fallback.
     * Invia un evento personalizzato per notificare la chiusura.
     */
    closeModal() {
        // Prova a usare il metodo closeModal del manager corrente
        if (this.currentManager && typeof this.currentManager.closeModal === 'function') {
            this.currentManager.closeModal();
        } else if (this.modal) {
            // Fallback: nasconde direttamente il modale
            this.modal.style.display = 'none';
        }
        // Notifica la chiusura del modale
       /* this.dispatchEvent('manage:modal:closed');*/
    }

    /**
     * Sistema unificato per mostrare messaggi di feedback all'utente.
     * Gestisce styling, posizionamento e auto-dismiss dei messaggi.
     *
     * @param {string} text - Testo del messaggio da mostrare
     * @param {string} backgroundColor - Colore di sfondo del messaggio (default: verde successo)
     */
    showMessage(text, backgroundColor = "#4CAF50") {
        // Verifica che l'elemento per i messaggi esista
        if (!this.messageElement) return;

        // Applica tutti gli stili necessari per il messaggio
        Object.assign(this.messageElement.style, {
            display: 'flex',                    // Rende visibile l'elemento
            position: 'fixed',                 // Posizionamento fisso nella viewport
            top: '20px',                       // Distanza dal top
            right: '20px',                     // Distanza da destra
            backgroundColor: backgroundColor,   // Colore di sfondo personalizzabile
            color: 'white',                    // Testo bianco per contrasto
            padding: '15px',                   // Spaziatura interna
            borderRadius: '5px',               // Angoli arrotondati
            boxShadow: '0 4px 8px rgba(0,0,0,0.2)', // Ombra per depth
            opacity: '1',                      // Completamente opaco
            transform: 'translateY(0)',        // Posizione normale (per animazioni)
            transition: 'all 0.3s ease',      // Transizioni fluide
            zIndex: '1000'                     // Z-index alto per stare sopra altri elementi
        });

        // Imposta il testo del messaggio
        this.messageElement.innerText = text;

        // Auto-dismiss dopo 2 secondi con animazione di fade-out
        setTimeout(() => {
            this.messageElement.style.opacity = '0';           // Fade out
            this.messageElement.style.transform = 'translateY(-20px)'; // Slide up
            this.messageElement.style.display = 'none';        // Nasconde completamente
        }, 2000);
    }

    /**
     * Utility per eseguire richieste HTTP con gestione errori standardizzata.
     * Fornisce un'interfaccia unificata per tutte le chiamate AJAX del sistema.
     *
     * @param {string} url - URL della richiesta
     * @param {Object} options - Opzioni per fetch() (method, headers, body, etc.)
     * @returns {Promise} Promise che si risolve con i dati JSON della risposta
     */
    async makeRequest(url, options = {}) {
        try {
            // Esegue la richiesta fetch con headers di default + quelli personalizzati
            const response = await fetch(url, {
                headers: {
                    'Content-Type': 'application/json', // Header di default
                    ...options.headers                   // Headers personalizzati (sovrascrivono i default)
                },
                ...options // Altre opzioni (method, body, etc.)
            });

            // Verifica che la risposta sia successful (status 200-299)
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            // Parsifica e ritorna i dati JSON
            return await response.json();
        } catch (error) {
            // Log dell'errore e re-throw per permettere gestione specifica
            console.error('Errore nella richiesta:', error);
            throw error;
        }
    }

    /**
     * Modalità fallback attivata quando l'inizializzazione normale fallisce.
     * Fornisce funzionalità minime per non lasciare l'interfaccia completamente non funzionante.
     */
    initializeFallback() {
        this.log('️ Inizializzazione fallback attivata');

        // Crea un manager minimale con solo le funzionalità base del modale
        this.currentManager = {
            openModal: () => {
                if (this.modal) this.modal.style.display = 'flex';
            },
            closeModal: () => {
                if (this.modal) this.modal.style.display = 'none';
            }
        };

        // Mostra una notifica all'utente per informarlo della modalità limitata
        this.showNotification(' Sistema in modalità limitata', 'warning');
        // Configura almeno gli eventi base del modale
        this.setupModalEvents();
    }

    /**
     * Sistema di notifiche toast animate per feedback all'utente.
     * Più avanzato rispetto a showMessage, con animazioni di slide-in/out.
     *
     * @param {string} message - Messaggio da mostrare
     * @param {string} type - Tipo di notifica (info, success, warning, error)
     * @param {number} duration - Durata in millisecondi (default: 5000)
     */
    showNotification(message, type = 'info', duration = 5000) {
        // Crea l'elemento DOM per la notifica
        const notification = document.createElement('div');
        notification.className = `manage-notification manage-notification--${type}`;
        notification.textContent = message;

        // Mappa dei colori per ogni tipo di notifica
        const colors = {
            info: '#2196F3',     // Blu per informazioni
            success: '#4CAF50',  // Verde per successo
            warning: '#FF9800',  // Arancione per avvisi
            error: '#F44336'     // Rosso per errori
        };

        // Applica tutti gli stili per l'aspetto e le animazioni
        Object.assign(notification.style, {
            position: 'fixed',
            top: '20px',
            right: '20px',
            padding: '12px 20px',
            borderRadius: '6px',
            color: 'white',
            fontSize: '14px',
            fontWeight: '500',
            zIndex: '10000',
            boxShadow: '0 4px 12px rgba(0,0,0,0.2)',
            backgroundColor: colors[type] || colors.info,  // Usa il colore appropriato
            transform: 'translateX(100%)',                 // Inizia fuori schermo (a destra)
            transition: 'transform 0.3s ease'             // Animazione fluida
        });

        // Aggiunge la notifica al DOM
        document.body.appendChild(notification);

        // Animazione di slide-in (da destra verso sinistra)
        setTimeout(() => {
            notification.style.transform = 'translateX(0)';
        }, 100);

        // Animazione di slide-out e rimozione dopo la durata specificata
        setTimeout(() => {
            notification.style.transform = 'translateX(100%)';
            // Rimuove dal DOM dopo l'animazione
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.parentNode.removeChild(notification);
                }
            }, 300);
        }, duration);
    }

    /**
     * Sistema di eventi personalizzati per comunicazione tra componenti.
     * Permette a diverse parti del sistema di comunicare in modo loosely-coupled.
     *
     * @param {string} eventName - Nome dell'evento da inviare
     * @param {Object} detail - Dati da allegare all'evento
     */
    dispatchEvent(eventName, detail = {}) {
        // Crea e invia un CustomEvent con i dati specificati
        const event = new CustomEvent(eventName, { detail });
        document.dispatchEvent(event);
        // Log per debugging
        this.log(`📡 Evento inviato: ${eventName}`, detail);
    }

    /**
     * Sistema di logging unificato con timestamp.
     * Attivo solo quando il debug è abilitato nella configurazione.
     *
     * @param {string} message - Messaggio principale da loggare
     * @param {...any} args - Argomenti aggiuntivi da loggare
     */
    log(message, ...args) {
        // Log solo se il debug è abilitato
        if (this.config.debug) {
            // Aggiunge timestamp per tracciare la sequenza temporale
            const timestamp = new Date().toLocaleTimeString();
            console.log(`[${timestamp}] ${message}`, ...args);
        }
    }

    /**
     * Getter per ottenere il manager attualmente attivo.
     * Utile per accesso esterno al sistema.
     *
     * @returns {Object} Manager correntemente attivo
     */
    getCurrentManager() {
        return this.currentManager;
    }

    /**
     * Implementazione del pattern Singleton.
     * Garantisce che esista una sola istanza di ManageSystem in tutta l'applicazione.
     *
     * @returns {ManageSystem} L'istanza singleton di ManageSystem
     */
    static getInstance() { // Singleton pattern per garantire un'unica istanza del sistema
        // Se non esiste ancora un'istanza, la crea
        if (!ManageSystem._instance) {
            ManageSystem._instance = new ManageSystem();
        }
        // Ritorna sempre la stessa istanza
        return ManageSystem._instance;
    }
}

/**
 * Classe base per tutti i manager specifici di entità.
 * Fornisce funzionalità comuni e interfaccia standardizzata per tutti i manager.
 * I manager specifici (ProductManager, BrandManager, etc.) estendono questa classe.
 */
class BaseManager {
    /**
     * Costruttore della classe BaseManager.
     * Inizializza le proprietà comuni a tutti i manager.
     *
     * @param {ManageSystem} system - Riferimento al sistema principale
     */
    constructor(system) {
        // Riferimento al sistema principale per accedere alle sue funzionalità
        this.system = system;
        // Context path per costruire URL corretti
        this.contextPath = system.config.contextPath;
        // Tipo di entità gestita da questo manager
        this.entity = system.config.entity;
    }

    /**
     * Metodo standard per aprire il modale.
     * Implementazione base che può essere sovrascritta dai manager specifici.
     */
    openModal() {
        if (this.system.modal) {
            this.system.modal.style.display = 'flex';
        }
    }

    /**
     * Metodo standard per chiudere il modale.
     * Chiude il modale e resetta automaticamente il form.
     */
    closeModal() {
        if (this.system.modal) {
            this.system.modal.style.display = 'none';
            // Resetta sempre il form quando si chiude il modale
            this.resetForm();
        }
    }

    /**
     * Resetta il form del modale allo stato iniziale.
     * Pulisce tutti i campi e ripristina i testi dei pulsanti/titoli.
     */
    resetForm() {
        // Trova il form all'interno del modale
        const form = this.system.modal?.querySelector('form');
        if (form) {
            // Resetta tutti i campi del form
            form.reset();

            // Trova e resetta gli elementi dell'interfaccia
            const submitBtn = document.getElementById('submitBtn');
            const modalTitle = document.getElementById('modalTitle');

            // Ripristina il testo del pulsante per la modalità "aggiungi"
            if (submitBtn) submitBtn.textContent = `Aggiungi ${this.getEntityDisplayName()}`; // Imposta il testo del pulsante di submit(modifica o aggiungi);
            // Ripristina il titolo del modale per la modalità "aggiungi"
            if (modalTitle) modalTitle.textContent = `Aggiungi ${this.getEntityDisplayName()}`;
        }
    }

    /**
     * Ritorna il nome visualizzabile dell'entità gestita.
     * Utilizzato per costruire dinamicamente testi dell'interfaccia.
     *
     * @returns {string} Nome dell'entità in italiano
     */
    getEntityDisplayName() {
        // Mappa delle entità ai loro nomi in italiano
        switch(this.entity) {
            case 'products': return 'Prodotto';
            case 'brands': return 'Brand';
            case 'categories': return 'Categoria';
            case 'admins':
            case 'users': return 'Utente';
            default: return 'Elemento'; // Fallback generico
        }
    }

    /**
     * Utility per impostare il valore di un campo del form.
     * Gestisce automaticamente i controlli null/undefined.
     *
     * @param {string} fieldId - ID dell'elemento del form
     * @param {any} value - Valore da impostare
     */
    setFormValue(fieldId, value) {
        const field = document.getElementById(fieldId);
        // Imposta il valore solo se il campo esiste e il valore è definito
        if (field && value !== undefined) {
            field.value = value;
        }
    }

    /**
     * Delega al sistema principale per mostrare messaggi.
     * Fornisce un'interfaccia semplificata per i manager specifici.
     *
     * @param {string} text - Testo del messaggio
     * @param {string} backgroundColor - Colore di sfondo
     */
    showMessage(text, backgroundColor) {
        this.system.showMessage(text, backgroundColor);
    }

    /**
     * Delega al sistema principale per eseguire richieste HTTP.
     * Fornisce un'interfaccia semplificata per i manager specifici.
     *
     * @param {string} url - URL della richiesta
     * @param {Object} options - Opzioni per la richiesta
     * @returns {Promise} Promise con la risposta
     */
    async makeRequest(url, options) {
        return this.system.makeRequest(url, options);
    }
}

// === INIZIALIZZAZIONE AUTOMATICA DEL SISTEMA ===

// Verifica lo stato del DOM e inizializza il sistema al momento opportuno
if (document.readyState === 'loading') {
    // Se il DOM non è ancora caricato, aspetta l'evento DOMContentLoaded
    document.addEventListener('DOMContentLoaded', () => ManageSystem.getInstance());
} else {
    // Se il DOM è già caricato, inizializza immediatamente
    ManageSystem.getInstance();
}

// === ESPOSIZIONE GLOBALE PER COMPATIBILITÀ ===

// Espone le classi principali globalmente per accesso da altri script
window.ManageSystem = ManageSystem;
window.BaseManager = BaseManager;

// Espone funzioni di utility globali per compatibilità con codice legacy
window.openModal = () => ManageSystem.getInstance().openModal();
window.closeModal = () => ManageSystem.getInstance().closeModal();
window.getCurrentManager = () => ManageSystem.getInstance().getCurrentManager();
