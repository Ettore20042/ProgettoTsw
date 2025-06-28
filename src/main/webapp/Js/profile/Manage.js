/**
 * Manage.js - Sistema di gestione unificato per il pannello amministrativo
 * Gestisce tutte le entità: prodotti, brand, categorie, admin, utenti
 */

class ManageSystem {
    constructor() {
        this.config = {
            contextPath: document.getElementsByTagName("body")[0]?.dataset.contextPath,
            entity: document.body?.dataset.entity || 'products',
            debug: true
        };

        this.currentManager = null;
        this.isInitialized = false;

        this.log('🚀 ManageSystem inizializzato', this.config);
        this.initialize();
    }

    /**
     * Inizializza il sistema completo
     */
    async initialize() {
        try {
            this.log('📦 Avvio inizializzazione sistema...');

            // Inizializza gli elementi comuni
            this.initializeCommonElements();

            // Carica i manager specifici
            await this.loadManagers();

            // Inizializza il manager appropriato
            this.initializeManager();

            // Configura gli event listener globali
            this.setupGlobalEventListeners();

            this.isInitialized = true;
            this.log('✅ Sistema inizializzato con successo');

            // Notifica il completamento
            this.dispatchEvent('manage:system:ready', {
                entity: this.config.entity,
                manager: this.currentManager
            });

        } catch (error) {
            this.log('❌ Errore durante l\'inizializzazione:', error);
            this.initializeFallback();
        }
    }

    /**
     * Carica i manager specifici dinamicamente
     */
    async loadManagers() {
        const managers = {
            products: 'ProductManager.js',
            brands: 'BrandManager.js',
            categories: 'CategoryManager.js',
            admins: 'UserManager.js',
            users: 'UserManager.js'
        };

        const currentManagerFile = managers[this.config.entity];
        console.log(`🔍 Caricamento manager per entità: ${this.config.entity} (${currentManagerFile})`);
        if (currentManagerFile) {
            try {
                await this.loadScript(`Js/profile/managers/${currentManagerFile}`);
                this.log(`✅ Manager caricato: ${currentManagerFile}`);
            } catch (error) {
                this.log(`⚠️ Errore caricamento manager ${currentManagerFile}:`, error);
            }
        }
    }

    /**
     * Carica script dinamicamente
     */
    loadScript(src) {
        return new Promise((resolve, reject) => {
            if (document.querySelector(`script[src="${src}"]`)) {
                resolve();
                return;
            }

            const script = document.createElement('script');
            script.src = src;
            script.type = 'text/javascript';
            script.onload = resolve;
            script.onerror = reject;
            document.head.appendChild(script);
        });
    }

    /**
     * Inizializza elementi comuni dell'interfaccia
     */
    initializeCommonElements() {
        this.modal = document.getElementById("productModal") || document.getElementById("modal");
        this.messageElement = document.getElementById("message");
        this.searchInput = document.getElementById("searchBarTable");
        this.suggestionBox = document.getElementById("suggestions-for-table");
        this.searchWrapper = document.querySelector('.manage-components-container-right_search-bar');

        // Inizializza suggerimenti se gli elementi esistono
        if (this.searchInput && this.suggestionBox && this.searchWrapper) {
            this.initializeSuggestions();
        }
    }

    /**
     * Inizializza il manager appropriato basato sull'entità
     */
    initializeManager() {
        const { entity } = this.config;

        switch(entity) {
            case 'products':
                this.currentManager = window.ProductManager ? new window.ProductManager(this) : new BaseManager(this);
                break;
            case 'brands':
                this.currentManager = window.BrandManager ? new window.BrandManager(this) : new BaseManager(this);
                break;
            case 'categories':
                this.currentManager = window.CategoryManager ? new window.CategoryManager(this) : new BaseManager(this);
                break;
            case 'admins':
            case 'users':
                this.currentManager = window.UserManager ? new window.UserManager(this) : new BaseManager(this);
                break;
            default:
                this.log(`⚠️ Entità non riconosciuta: ${entity}, utilizzo manager base`);
                this.currentManager = new BaseManager(this);
        }

        this.log(`✅ Manager inizializzato per: ${entity}`);
    }

    /**
     * Gestione dei suggerimenti nella barra di ricerca
     */
    initializeSuggestions() {
        let timeout = null;

        this.searchInput.addEventListener('input', (e) => {
            clearTimeout(timeout);
            const value = e.target.value.trim();

            if (value.length === 0) {
                this.hideSuggestions();
                return;
            }

            timeout = setTimeout(() => {
                this.fetchSuggestions(value);
            }, 300);
        });
    }

    async fetchSuggestions(query) {
        try {
            const url = `${this.config.contextPath}/SuggestionsServlet?entity=${this.config.entity}&query=${encodeURIComponent(query)}`;
            const response = await fetch(url);
            const results = await response.json();

            this.suggestionBox.innerHTML = '';

            if (results.length === 0) {
                this.hideSuggestions();
                return;
            }

            this.showSuggestions(results);
        } catch (error) {
            console.error('Errore nel recupero suggerimenti:', error);
            this.hideSuggestions();
        }
    }

    showSuggestions(results) {
        this.suggestionBox.classList.add('active');
        this.searchWrapper.classList.add('active');

        results.forEach(item => {
            const div = document.createElement('div');
            div.textContent = item;
            div.classList.add('suggestion-for-table-item');

            div.addEventListener('click', () => {
                this.searchInput.value = item;
                this.hideSuggestions();
                this.searchInput.form.submit();
            });

            this.suggestionBox.appendChild(div);
        });
    }

    hideSuggestions() {
        this.suggestionBox.innerHTML = '';
        this.suggestionBox.classList.remove('active');
        this.searchWrapper.classList.remove('active');
    }

    /**
     * Configura event listener globali
     */
    setupGlobalEventListeners() {
        this.setupModalEvents();
        this.setupEntitySwitching();
        this.setupKeyboardShortcuts();
    }

    setupModalEvents() {
        // Apertura modale
        const addButtons = document.querySelectorAll('[data-action="add"], .add-btn, #addButton, .add-component-button-toggle');
        addButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault();
                this.openModal();
            });
        });

        // Chiusura modale
        const closeButtons = document.querySelectorAll('[data-action="close"], .close-modal, #closeModal');
        closeButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault();
                this.closeModal();
            });
        });

        // Chiusura con ESC e click fuori
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                this.closeModal();
            }
        });

        if (this.modal) {
            this.modal.addEventListener('click', (e) => {
                if (e.target === this.modal) {
                    this.closeModal();
                }
            });
        }
    }

    setupEntitySwitching() {
        const entitySwitchers = document.querySelectorAll('[data-entity]');
        entitySwitchers.forEach(switcher => {
            switcher.addEventListener('click', async (e) => {
                const newEntity = switcher.dataset.entity;
                if (newEntity !== this.config.entity) {
                    await this.switchEntity(newEntity);
                }
            });
        });
    }

    setupKeyboardShortcuts() {
        document.addEventListener('keydown', (e) => {
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                this.openModal();
            }

            if (e.ctrlKey && e.key === 's') {
                const modal = this.modal;
                if (modal && modal.style.display !== 'none') {
                    e.preventDefault();
                    const submitBtn = document.getElementById('submitBtn');
                    if (submitBtn) {
                        submitBtn.click();
                    }
                }
            }
        });
    }

    /**
     * Cambia dinamicamente l'entità gestita
     */
    async switchEntity(newEntity) {
        try {
            this.log(`🔄 Cambio entità da ${this.config.entity} a ${newEntity}`);

            this.config.entity = newEntity;
            document.body.dataset.entity = newEntity;

            // Carica il nuovo manager
            await this.loadManagers();
            this.initializeManager();

            this.dispatchEvent('manage:entity:changed', {
                oldEntity: this.config.entity,
                newEntity: newEntity,
                manager: this.currentManager
            });

            this.log(`✅ Entità cambiata con successo: ${newEntity}`);

        } catch (error) {
            this.log(`❌ Errore nel cambio entità:`, error);
        }
    }

    /**
     * Metodi pubblici per il modale
     */
    openModal() {
        if (this.currentManager && typeof this.currentManager.openModal === 'function') {
            this.currentManager.openModal();
        } else if (this.modal) {
            this.modal.style.display = 'flex';
        }
        this.dispatchEvent('manage:modal:opened');
    }

    closeModal() {
        if (this.currentManager && typeof this.currentManager.closeModal === 'function') {
            this.currentManager.closeModal();
        } else if (this.modal) {
            this.modal.style.display = 'none';
        }
        this.dispatchEvent('manage:modal:closed');
    }

    /**
     * Sistema di messaggi
     */
    showMessage(text, backgroundColor = "#4CAF50") {
        if (!this.messageElement) return;

        Object.assign(this.messageElement.style, {
            display: 'flex',
            position: 'fixed',
            top: '20px',
            right: '20px',
            backgroundColor: backgroundColor,
            color: 'white',
            padding: '15px',
            borderRadius: '5px',
            boxShadow: '0 4px 8px rgba(0,0,0,0.2)',
            opacity: '1',
            transform: 'translateY(0)',
            transition: 'all 0.3s ease',
            zIndex: '1000'
        });

        this.messageElement.innerText = text;

        setTimeout(() => {
            this.messageElement.style.opacity = '0';
            this.messageElement.style.transform = 'translateY(-20px)';
        }, 2000);
    }

    /**
     * Utility per le richieste HTTP
     */
    async makeRequest(url, options = {}) {
        try {
            const response = await fetch(url, {
                headers: {
                    'Content-Type': 'application/json',
                    ...options.headers
                },
                ...options
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            return await response.json();
        } catch (error) {
            console.error('Errore nella richiesta:', error);
            throw error;
        }
    }

    /**
     * Fallback se l'inizializzazione fallisce
     */
    initializeFallback() {
        this.log('⚠️ Inizializzazione fallback attivata');

        this.currentManager = {
            openModal: () => {
                if (this.modal) this.modal.style.display = 'flex';
            },
            closeModal: () => {
                if (this.modal) this.modal.style.display = 'none';
            }
        };

        this.showNotification('⚠️ Sistema in modalità limitata', 'warning');
        this.setupModalEvents();
    }

    showNotification(message, type = 'info', duration = 5000) {
        const notification = document.createElement('div');
        notification.className = `manage-notification manage-notification--${type}`;
        notification.textContent = message;

        const colors = {
            info: '#2196F3',
            success: '#4CAF50',
            warning: '#FF9800',
            error: '#F44336'
        };

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
            backgroundColor: colors[type] || colors.info,
            transform: 'translateX(100%)',
            transition: 'transform 0.3s ease'
        });

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.transform = 'translateX(0)';
        }, 100);

        setTimeout(() => {
            notification.style.transform = 'translateX(100%)';
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.parentNode.removeChild(notification);
                }
            }, 300);
        }, duration);
    }

    dispatchEvent(eventName, detail = {}) {
        const event = new CustomEvent(eventName, { detail });
        document.dispatchEvent(event);
        this.log(`📡 Evento inviato: ${eventName}`, detail);
    }

    log(message, ...args) {
        if (this.config.debug) {
            const timestamp = new Date().toLocaleTimeString();
            console.log(`[${timestamp}] ${message}`, ...args);
        }
    }

    getCurrentManager() {
        return this.currentManager;
    }

    static getInstance() {
        if (!ManageSystem._instance) {
            ManageSystem._instance = new ManageSystem();
        }
        return ManageSystem._instance;
    }
}

/**
 * Manager base con funzionalità comuni
 */
class BaseManager {
    constructor(system) {
        this.system = system;
        this.contextPath = system.config.contextPath;
        this.entity = system.config.entity;
    }

    openModal() {
        if (this.system.modal) {
            this.system.modal.style.display = 'flex';
        }
    }

    closeModal() {
        if (this.system.modal) {
            this.system.modal.style.display = 'none';
            this.resetForm();
        }
    }

    resetForm() {
        const form = this.system.modal?.querySelector('form');
        if (form) {
            form.reset();
            const submitBtn = document.getElementById('submitBtn');
            const modalTitle = document.getElementById('modalTitle');

            if (submitBtn) submitBtn.textContent = `Aggiungi ${this.getEntityDisplayName()}`;
            if (modalTitle) modalTitle.textContent = `Aggiungi ${this.getEntityDisplayName()}`;
        }
    }

    getEntityDisplayName() {
        switch(this.entity) {
            case 'products': return 'Prodotto';
            case 'brands': return 'Brand';
            case 'categories': return 'Categoria';
            case 'admins':
            case 'users': return 'Utente';
            default: return 'Elemento';
        }
    }

    setFormValue(fieldId, value) {
        const field = document.getElementById(fieldId);
        if (field && value !== undefined) {
            field.value = value;
        }
    }

    showMessage(text, backgroundColor) {
        this.system.showMessage(text, backgroundColor);
    }

    async makeRequest(url, options) {
        return this.system.makeRequest(url, options);
    }
}

// Inizializzazione automatica quando il DOM è pronto
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => ManageSystem.getInstance());
} else {
    ManageSystem.getInstance();
}

// Esposizione globale per compatibilità
window.ManageSystem = ManageSystem;
window.BaseManager = BaseManager;
window.openModal = () => ManageSystem.getInstance().openModal();
window.closeModal = () => ManageSystem.getInstance().closeModal();
window.getCurrentManager = () => ManageSystem.getInstance().getCurrentManager();
