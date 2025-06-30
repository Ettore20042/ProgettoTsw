/**
 * BrandManager.js - Manager specifico per la gestione dei brand
 * Estende BaseManager con funzionalità specifiche per i brand
 */

class BrandManager extends BaseManager {
    constructor(system) {
        super(system);
        this.initializeBrandEvents();
    }

    initializeBrandEvents() {
        this.initializeFormSubmission();
        this.initializeRemoveButtons();
        this.initializeEditLinks();
    }

    /**
     * Gestione del form di aggiunta/modifica brand
     */
    initializeFormSubmission() {
        const form = document.getElementById('addBrandForm') ;
        if (!form) return;

        form.addEventListener('submit', (event) => {
            event.preventDefault();
            const submitBtn = document.getElementById('submitBtn');
            const isEdit = submitBtn?.textContent === 'Modifica Brand';

            if (isEdit) {
                this.updateBrand(form);
            } else {
                this.addBrand(form);
            }
        });
    }

    /**
     * Aggiunta nuovo brand
     */
    async addBrand(form) {
        console.log("BrandManager: addBrand chiamato");
        try {
            const formData = new FormData(form);

            // Debug: verifichiamo i dati del form
            console.log("Form data:");
            for (let [key, value] of formData.entries()) {
                console.log(key, value);
            }

            const url = `${this.contextPath}/ManageBrandServlet`;
            console.log("URL chiamata:", url);

            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            console.log("Response status:", response.status);
            console.log("Response ok:", response.ok);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success && data.brand) {
                this.addBrandToTable(data.brand);
                this.showMessage("✅ Brand aggiunto con successo", "#4CAF50");
                form.reset();
                this.closeModal();
            } else {
                this.showMessage("❌ Errore nell'aggiunta del brand", "#f44336");
            }
        } catch (error) {
            console.error("Errore nell'aggiunta del brand:", error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Modifica brand esistente
     */
    async updateBrand(form) {
        try {
            const brandId = this.getCurrentEditId();
            const formData = new FormData(form);
            const url = `${this.contextPath}/ManageBrandServlet?action=update&id=${brandId}`;

            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                this.showMessage("✅ Brand modificato con successo", "#4CAF50");
                this.closeModal();
                location.reload();
            } else {
                this.showMessage("❌ Errore nella modifica del brand", "#f44336");
            }
        } catch (error) {
            console.error("Errore nella modifica del brand:", error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Aggiunge una nuova riga alla tabella dei brand
     */
    addBrandToTable(brand) {
        const tableBody = document.querySelector('.componentTableBody');
        if (!tableBody) return;

        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td>${brand.brandId}</td>
            <td>${brand.logoPath || ''}</td>
            <td>${brand.brandName}</td>
            <td>
                <a href="#" class="edit-link" data-brand-id="${brand.brandId}">Modifica</a>
            </td>
            <td>
               <button type="button" class="remove-button-brand remove-item-btn" data-id="${brand.brandId}" >
                   <img src="${this.contextPath}/img/icon/delete.png" class="remove-icon">
               </button>
            </td>
        `;

        tableBody.appendChild(newRow);

        const editLink = newRow.querySelector('.edit-link');
        const removeButton = newRow.querySelector('.remove-button-brand');

        if (editLink) this.addEditEventListener(editLink);
        if (removeButton) this.addRemoveEventListener(removeButton);
    }

    /**
     * Gestione dei pulsanti di rimozione
     */
    initializeRemoveButtons() {
        document.querySelectorAll('.remove-item-btn').forEach(button => {
            this.addRemoveEventListener(button);
        });
    }

    addRemoveEventListener(button) {
        button.addEventListener('click', async (e) => {
            e.preventDefault();

            if (!confirm('Sei sicuro di voler eliminare questo brand?')) {
                return;
            }

            try {
                const brandId = button.getAttribute('data-id');
                console.log("Tentativo di eliminazione brand ID:", brandId);

                const url = `${this.contextPath}/ManageBrandServlet`;

                const response = await fetch(url, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `brandId=${brandId}`
                });

                console.log("Response status:", response.status);

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const data = await response.json();
                console.log("Response data:", data);

                if (data.success) {
                    const brandRow = button.closest('tr');
                    if (brandRow) {
                        brandRow.remove();
                        this.showMessage("✅ Brand eliminato con successo", "#4CAF50");
                    }
                } else {
                    this.showMessage(`❌ ${data.message}`, "#f44336");
                }
            } catch (error) {
                console.error('Errore nell\'eliminazione del brand:', error);
                this.showMessage("❌ Errore nell'eliminazione del brand", "#f44336");
            }
        });
    }

    /**
     * Gestione dei link di modifica
     */
    initializeEditLinks() {
        console.log("Inizializzazione dei link di modifica");
        document.querySelectorAll('.edit-link').forEach(link => {
            console.log("Link di modifica trovato:", link);
            this.addEditEventListener(link);
        });
    }

    addEditEventListener(link) {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const brandId = link.dataset.brandId;
            console.log("Link di modifica cliccato per brand ID:", brandId);
            this.loadBrandForEdit(brandId);
        });
    }

    /**
     * Carica i dati del brand per la modifica
     */
    async loadBrandForEdit(brandId) {
        try {
            const url = `${this.contextPath}/ManageBrandServlet?action=edit&id=${brandId}`;
            const data = await this.makeRequest(url);

            if (data.success && data.brand) {
                console.log("Dati del brand caricati per la modifica:", data.brand);
                this.populateFormForEdit(data.brand);
                this.openModal();
            } else {
                this.showMessage("❌ Errore nel caricamento del brand", "#f44336");
            }
        } catch (error) {
            console.error('Errore nel caricamento del brand:', error);
            this.showMessage("❌ Errore nel caricamento del brand", "#f44336");
        }
    }

    /**
     * Popola il form con i dati del brand per la modifica
     */
    populateFormForEdit(brand) {
        this.setFormValue('brandName', brand.brandName);
        this.setFormValue('brandPath', brand.logoPath);

        // Salva l'ID per l'aggiornamento
        this.currentEditId = brand.brandId;

        this.setEditMode();
    }

    getCurrentEditId() {
        return this.currentEditId;
    }

    setEditMode() {
        const submitBtn = document.getElementById('submitBtn');
        const modalTitle = document.getElementById('modalTitle');

        if (submitBtn) submitBtn.textContent = 'Modifica Brand';
        if (modalTitle) modalTitle.textContent = 'Modifica Brand';
    }
}

// Esposizione globale per il sistema
window.BrandManager = BrandManager;
