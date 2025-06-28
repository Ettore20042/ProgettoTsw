/**
 * UserManager.js - Manager specifico per la gestione di utenti e amministratori
 * Estende BaseManager con funzionalità specifiche per utenti/admin
 */

class UserManager extends BaseManager {
    constructor(system) {
        super(system);
        this.initializeUserEvents();
    }

    initializeUserEvents() {
        this.initializeFormSubmission();
        this.initializeRemoveButtons();
        this.initializeEditLinks();
    }

    setAdmin(userId) {

    }

}


// Esposizione globale per il sistema
window.UserManager = UserManager;
