class UserManager extends BaseManager {
    constructor(system) {
        super(system);
        this.initializeAdminToggle();
    }


    initializeAdminToggle() {
        window.setAdmin = (iconElement, userId) => {
            this.toggleAdminStatus(iconElement, userId);
        };
    }

    async toggleAdminStatus(imgElement, userId) {
        const url = `${this.contextPath}/SetAdminServlet`;
        const altAttribute = imgElement.getAttribute('alt');
        const formData = new URLSearchParams();
        formData.append('userId', userId);
        formData.append('isAdmin', (altAttribute === 'yes') ? 'no' : 'yes'); // Inverti lo stato

        try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            });

            if (!response.ok) throw new Error('Errore nella richiesta');
            const data = await response.json();

            if (data.success) {
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

                this.showMessage('✅ Status admin aggiornato', "#4CAF50");
            } else {
                this.showMessage('❌ Errore: ' + data.message, "#f44336");
            }
        } catch (error) {
            console.error('Errore:', error);
            this.showMessage('❌ Errore durante l\'aggiornamento', "#f44336");
        }
    }
}

window.UserManager = UserManager;