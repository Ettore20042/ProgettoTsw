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

    /**
     * Gestione del form di aggiunta/modifica utenti
     */
    initializeFormSubmission() {
        const form = document.getElementById('addUserForm') ||
                    document.getElementById('addAdminForm') ||
                    document.getElementById('addProductForm');
        if (!form) return;

        form.addEventListener('submit', (event) => {
            event.preventDefault();
            const submitBtn = document.getElementById('submitBtn');
            const isEdit = submitBtn?.textContent.includes('Modifica');

            if (isEdit) {
                this.updateUser(form);
            } else {
                this.addUser(form);
            }
        });
    }

    /**
     * Aggiunta nuovo utente/admin
     */
    async addUser(form) {
        try {
            const formData = new FormData(form);
            const url = this.entity === 'admins' ?
                      `${this.contextPath}/AdminServlet` :
                      `${this.contextPath}/UserServlet`;

            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success && (data.user || data.admin)) {
                const userData = data.user || data.admin;
                this.addUserToTable(userData);
                this.showMessage(`✅ ${this.getEntityDisplayName()} aggiunto con successo`, "#4CAF50");
                form.reset();
                this.closeModal();
            } else {
                this.showMessage(`❌ Errore nell'aggiunta del ${this.getEntityDisplayName().toLowerCase()}`, "#f44336");
            }
        } catch (error) {
            console.error(`Errore nell'aggiunta del ${this.getEntityDisplayName().toLowerCase()}:`, error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Modifica utente/admin esistente
     */
    async updateUser(form) {
        try {
            const userId = this.getCurrentEditId();
            const formData = new FormData(form);
            const url = this.entity === 'admins' ?
                      `${this.contextPath}/AdminServlet?action=update&id=${userId}` :
                      `${this.contextPath}/UserServlet?action=update&id=${userId}`;

            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                this.showMessage(`✅ ${this.getEntityDisplayName()} modificato con successo`, "#4CAF50");
                this.closeModal();
                location.reload();
            } else {
                this.showMessage(`❌ Errore nella modifica del ${this.getEntityDisplayName().toLowerCase()}`, "#f44336");
            }
        } catch (error) {
            console.error(`Errore nella modifica del ${this.getEntityDisplayName().toLowerCase()}:`, error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Aggiunge una nuova riga alla tabella degli utenti
     */
    addUserToTable(userData) {
        const tableBody = document.querySelector('.componentTableBody');
        if (!tableBody) return;

        const newRow = document.createElement('tr');

        if (this.entity === 'admins') {
            newRow.innerHTML = `
                <td>${userData.adminId || userData.userId}</td>
                <td>${userData.username}</td>
                <td>${userData.email}</td>
                <td>${userData.role || 'Admin'}</td>
                <td>
                    <a href="#" class="edit-link" data-user-id="${userData.adminId || userData.userId}">Modifica</a>
                </td>
                <td>
                    <button type="button" class="remove-button-user remove-item-btn" data-id="${userData.adminId || userData.userId}">
                        <img src="${this.contextPath}/img/icon/delete.png" class="remove-icon">
                    </button>
                </td>
            `;
        } else {
            newRow.innerHTML = `
                <td>${userData.userId}</td>
                <td>${userData.username}</td>
                <td>${userData.email}</td>
                <td>${userData.firstName} ${userData.lastName}</td>
                <td>
                    <a href="#" class="edit-link" data-user-id="${userData.userId}">Modifica</a>
                </td>
                <td>
                    <button type="button" class="remove-button-user remove-item-btn" data-id="${userData.userId}">
                        <img src="${this.contextPath}/img/icon/delete.png" class="remove-icon">
                    </button>
                </td>
            `;
        }

        tableBody.appendChild(newRow);

        const editLink = newRow.querySelector('.edit-link');
        const removeButton = newRow.querySelector('.remove-button-user');

        if (editLink) this.addEditEventListener(editLink);
        if (removeButton) this.addRemoveEventListener(removeButton);
    }

    /**
     * Gestione dei pulsanti di rimozione
     */
    initializeRemoveButtons() {
        document.querySelectorAll('.remove-button-user, .remove-button-admin').forEach(button => {
            this.addRemoveEventListener(button);
        });
    }

    addRemoveEventListener(button) {
        button.addEventListener('click', async (e) => {
            e.preventDefault();

            const entityName = this.getEntityDisplayName().toLowerCase();
            if (!confirm(`Sei sicuro di voler eliminare questo ${entityName}?`)) {
                return;
            }

            try {
                const userId = button.getAttribute('data-id');
                const url = this.entity === 'admins' ?
                          `${this.contextPath}/AdminServlet?action=delete&id=${userId}` :
                          `${this.contextPath}/UserServlet?action=delete&id=${userId}`;

                const data = await this.makeRequest(url, { method: 'DELETE' });

                if (data.success) {
                    const userRow = button.closest('tr');
                    if (userRow) {
                        userRow.remove();
                        this.showMessage(`✅ ${this.getEntityDisplayName()} eliminato con successo`, "#4CAF50");
                    }
                } else {
                    this.showMessage(`❌ Errore nell'eliminazione del ${entityName}`, "#f44336");
                }
            } catch (error) {
                console.error(`Errore nell'eliminazione del ${entityName}:`, error);
                this.showMessage(`❌ Errore nell'eliminazione del ${entityName}`, "#f44336");
            }
        });
    }

    /**
     * Gestione dei link di modifica
     */
    initializeEditLinks() {
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.edit-link').forEach(link => {
                this.addEditEventListener(link);
            });
        });
    }

    addEditEventListener(link) {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const userId = link.dataset.userId;
            this.loadUserForEdit(userId);
        });
    }

    /**
     * Carica i dati dell'utente per la modifica
     */
    async loadUserForEdit(userId) {
        try {
            const url = this.entity === 'admins' ?
                      `${this.contextPath}/AdminServlet?action=edit&id=${userId}` :
                      `${this.contextPath}/UserServlet?action=edit&id=${userId}`;

            const data = await this.makeRequest(url);

            if (data.success && (data.user || data.admin)) {
                const userData = data.user || data.admin;
                this.populateFormForEdit(userData);
                this.openModal();
            } else {
                this.showMessage(`❌ Errore nel caricamento del ${this.getEntityDisplayName().toLowerCase()}`, "#f44336");
            }
        } catch (error) {
            console.error(`Errore nel caricamento del ${this.getEntityDisplayName().toLowerCase()}:`, error);
            this.showMessage(`❌ Errore nel caricamento del ${this.getEntityDisplayName().toLowerCase()}`, "#f44336");
        }
    }

    /**
     * Popola il form con i dati dell'utente per la modifica
     */
    populateFormForEdit(userData) {
        this.setFormValue('username', userData.username);
        this.setFormValue('email', userData.email);
        this.setFormValue('firstName', userData.firstName);
        this.setFormValue('lastName', userData.lastName);

        if (this.entity === 'admins') {
            this.setFormValue('role', userData.role);
            this.currentEditId = userData.adminId;
        } else {
            this.setFormValue('phone', userData.phone);
            this.setFormValue('dateOfBirth', userData.dateOfBirth);
            this.currentEditId = userData.userId;
        }

        this.setEditMode();
    }

    getCurrentEditId() {
        return this.currentEditId;
    }

    setEditMode() {
        const submitBtn = document.getElementById('submitBtn');
        const modalTitle = document.getElementById('modalTitle');

        if (submitBtn) submitBtn.textContent = `Modifica ${this.getEntityDisplayName()}`;
        if (modalTitle) modalTitle.textContent = `Modifica ${this.getEntityDisplayName()}`;
    }

    /**
     * Override del metodo getEntityDisplayName per gestire admin/users
     */
    getEntityDisplayName() {
        return this.entity === 'admins' ? 'Admin' : 'Utente';
    }
}

// Esposizione globale per il sistema
window.UserManager = UserManager;
