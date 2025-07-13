class UserManager extends BaseManager {
    constructor(system) {
        super(system);
        this.initializeAdminToggle();
    }


    initializeAdminToggle() {
        //usiamo una funzione globale perchè le icone nella tabella html
        //vengono generate con l'attributo onclick scritto direttamente nel codice html
        window.setAdmin = (iconElement, userId) => {
            this.toggleAdminStatus(iconElement, userId);
        };
    }

    //eseguito ogni volta che si clicca su un'icona
    async toggleAdminStatus(imgElement, userId) {
        const url = `${this.contextPath}/SetAdminServlet`;
        //viene preso per capire lo stato attuale dell'utente (yes o no)
        const altAttribute = imgElement.getAttribute('alt');


        //prima di continuare ci assicuriamo che l'admin voglia veramente compiere l'azione
        const confirmationMessage = (altAttribute === 'yes')
        ? "Sei sicuro di voler REVOCARE i privilegi di amministratore a questo utente?"
        : "Sei sicuro di voler PROMUOVERE questo utente ad amministratore?";

        if(!confirm(confirmationMessage)){
            return;
        }


        const formData = new URLSearchParams();
        formData.append('userId', userId);
        formData.append('isAdmin', (altAttribute === 'yes') ? 'no' : 'yes'); // Inverti lo stato
        //se lo stato attuale è yes, invia al server la richiesta di impostarlo a no, e viceversa

        try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            });

            if (!response.ok) throw new Error('Errore nella richiesta');
            //converte la risposta del server da formato JSON a un oggetto javascript
            const data = await response.json();

            if (data.success) {
                //trova l'intera riga della tabella che contiene l'icona cliccata
                const row = imgElement.closest('tr');
                const statusTextCell = row.querySelector('td:nth-child(6)'); // Colonna SI/NO
                const statusIconCell = row.querySelector('td:nth-child(7)'); // Colonna icona

                if (altAttribute === 'yes') {
                    // Era admin → diventa utente normale
                    statusTextCell.textContent = 'NO';
                    statusIconCell.innerHTML = `<img src="${this.contextPath}/img/icon/remove.png" alt="no" class="icon admin-icon" onclick="setAdmin(this,${userId})">`;
                } else {
                    // utente normale → diventa admin
                    statusTextCell.textContent = 'SI';
                    statusIconCell.innerHTML = `<img src="${this.contextPath}/img/icon/check.png" alt="yes" class="icon admin-icon" onclick="setAdmin(this,${userId})">`;
                }

                this.showMessage('Status admin aggiornato', "#4CAF50");
            } else {
                this.showMessage('Errore: ' + data.message, "#f44336");
            }
        } catch (error) {
            console.error('Errore:', error);
            this.showMessage('Errore durante l\'aggiornamento', "#f44336");
        }
    }
}

window.UserManager = UserManager;