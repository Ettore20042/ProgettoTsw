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
        const url = `${this.contextPath}/SetAdminServlet`; // URL del servlet per promuovere l'utente ad amministratore

            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ userId: userId })
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Errore nella richiesta');
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        alert('Utente promosso ad amministratore con successo!');
                        window.location.reload(); // Ricarica la pagina per aggiornare lo stato
                    } else {
                        alert('Errore nella promozione dell\'utente: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Errore:', error);
                    alert('Errore durante la promozione.');
                });
        }





}


// Esposizione globale per il sistema
window.UserManager = UserManager;
