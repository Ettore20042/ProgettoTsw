/**
 * CategoryManager.js - Manager specifico per la gestione delle categorie
 * Estende BaseManager con funzionalità specifiche per le categorie
 */

class CategoryManager extends BaseManager {
    constructor(system) {
        super(system);
        this.initializeCategoryEvents();
    }

    initializeCategoryEvents() {
        this.initializeFormSubmission();
        this.initializeRemoveButtons();
        this.initializeEditLinks();
    }

    /**
     * Gestione del form di aggiunta/modifica categorie
     */
    initializeFormSubmission() {
        const form = document.getElementById('addCategoryForm');
        if (!form) return;

        form.addEventListener('submit', (event) => {
            event.preventDefault();
            const submitBtn = document.getElementById('submitBtn');
            const isEdit = submitBtn?.textContent === 'Modifica Categoria';

            if (isEdit) {
                this.updateCategory(form);
            } else {
                this.addCategory(form);
            }
        });
    }

    /**
     * Aggiunta nuova categoria
     */
    async addCategory(form) {
        try {
            const formData = new FormData(form);
            const response = await fetch(`${this.contextPath}/ManageCategoryServlet`, {
                method: 'POST',
                body: formData
            });

            const responseText = await response.text();
            console.log("Response RAW:", responseText);

            const data = JSON.parse(responseText);
            console.log("Data parsed:", data);
            console.log("Data.category:", data.category);
            console.log("CategoryId ricevuto:", data.category.categoryId);

            if (data.success && data.category) {
                // ✅ AGGIUNGI DEBUG QUI
                console.log("Chiamando addCategoryToTable con:", data.category);

                this.addCategoryToTable(data.category);

                this.showMessage("✅ Categoria aggiunta con successo", "#4CAF50");
                form.reset();
                this.closeModal();
            } else {
                console.log("Errore nei dati:", data);
                this.showMessage("❌ Errore nell'aggiunta della categoria", "#f44336");
            }
        } catch (error) {
            console.error("Errore nell'aggiunta della categoria:", error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Modifica categoria esistente
     */
    async updateCategory(form) {
        try {
            const categoryId = this.getCurrentEditId();
            const formData = new FormData(form);

            // Aggiungi l'action e l'ID al FormData
            formData.append('action', 'update');

            const url = `${this.contextPath}/ManageCategoryServlet?action=update&id=${categoryId}`;



            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const responseText = await response.text();
            console.log("Response RAW:", responseText);

            const data = JSON.parse(responseText);
            console.log("Response parsed:", data);

            if (data.success) {
                // Aggiorna la riga della tabella invece di ricaricare la pagina
                this.updateCategoryInTable(data.category);
                this.showMessage("✅ Categoria modificata con successo", "#4CAF50");
                this.closeModal();

            } else {
                this.showMessage(`❌ Errore nella modifica della categoria: ${data.message}`, "#f44336");
            }
        } catch (error) {
            console.error("Errore nella modifica della categoria:", error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }
    /**
     * Aggiorna una riga esistente nella tabella delle categorie
     */
    /**
     * Aggiorna una riga esistente nella tabella delle categorie
     */
    updateCategoryInTable(category) {
        // Prima prova con data-id (per righe aggiunte dinamicamente)
        let row = document.querySelector(`tr[data-id="${category.categoryId}"]`);

        // Se non trova la riga con data-id, cerca nella prima colonna (ID categoria)
        if (!row) {
            const tableBody = document.querySelector('.componentTableBody');
            if (tableBody) {
                const rows = tableBody.querySelectorAll('tr');
                for (const tableRow of rows) {
                    const firstCell = tableRow.querySelector('td:first-child');
                    if (firstCell && parseInt(firstCell.textContent) === category.categoryId) {
                        row = tableRow;
                        // Aggiungi data-id per le prossime volte
                        row.setAttribute('data-id', category.categoryId);
                        break;
                    }
                }
            }
        }

        if (!row) {
            console.error("Riga non trovata per categoria ID:", category.categoryId);
            return;
        }

        // Aggiorna le celle della riga
        const cells = row.querySelectorAll('td');
        if (cells.length >= 3) {
            cells[1].textContent = category.categoryName; // Nome categoria
            cells[2].textContent = category.categoryPath || ''; // Path categoria
        }

        console.log("Riga aggiornata per categoria:", category.categoryName);
    }
    /**
     * Aggiunge una nuova riga alla tabella delle categorie
     */
    addCategoryToTable(category) {
        const tableBody = document.querySelector('.componentTableBody');
        if (!tableBody) return;

        const newRow = document.createElement('tr');
        newRow.setAttribute('data-id', category.categoryId);
        newRow.innerHTML = `
            <td>${category.categoryId}</td>
            <td>${category.categoryName}</td>
            <td>${category.categoryPath || ''}</td>
            <td>
                <a href="#" class="edit-link" data-category-id="${category.categoryId}">Modifica</a>
            </td>
            <td>
                <button type="button" class="remove-button-category remove-item-btn" data-id="${category.categoryId}">
                    <img src="${this.contextPath}/img/icon/delete.png" class="remove-icon">
                </button>
            </td>
        `;

        tableBody.appendChild(newRow);

        const editLink = newRow.querySelector('.edit-link');
        const removeButton = newRow.querySelector('.remove-button-category');

        if (editLink) this.addEditEventListener(editLink);
        if (removeButton) this.addRemoveEventListener(removeButton);
    }

    /**
     * Gestione dei pulsanti di rimozione
     */
    initializeRemoveButtons() {
        document.querySelectorAll('.remove-button-category').forEach(button => {
            this.addRemoveEventListener(button);
        });
    }

    addRemoveEventListener(button) {
        button.addEventListener('click', async (e) => {
            e.preventDefault();

            if (!confirm('Sei sicuro di voler eliminare questa categoria?')) {
                return;
            }

            try {
                const categoryId = button.getAttribute('data-id');
                console.log("Tentativo di eliminazione categoria ID:", categoryId);

                const url = `${this.contextPath}/ManageCategoryServlet`;

                const response = await fetch(url, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `categoryId=${categoryId}`
                });

                console.log("Response status:", response.status);

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const data = await response.json();
                console.log("Response data:", data);

                if (data.success) {
                    const categoryRow = button.closest('tr');
                    if (categoryRow) {
                        categoryRow.remove();
                        this.showMessage("✅ Categoria eliminata con successo", "#4CAF50");
                    }
                } else {
                    this.showMessage(`❌ ${data.message}`, "#f44336");
                }
            } catch (error) {
                console.error('Errore nell\'eliminazione della categoria:', error);
                this.showMessage("❌ Errore nell'eliminazione della categoria", "#f44336");
            }
        });
    }

    /**
     * Gestione dei link di modifica
     */
    initializeEditLinks() {
        console.log("Inizializzazione dei link di modifica categorie");
        const editLinks = document.querySelectorAll('.edit-link');
        console.log(`Trovati ${editLinks.length} link di modifica`);

        editLinks.forEach((link, index) => {
            console.log(`Link ${index}:`, link);
            console.log(`- data-category-id: ${link.dataset.categoryId}`);

            this.addEditEventListener(link);
        });
    }

    addEditEventListener(link) {
        // Crea un handler specifico per questo link usando una closure
        const editHandler = (event) => {
            event.preventDefault();
            const categoryId = link.dataset.categoryId || link.dataset.brandId;
            console.log("Link di modifica cliccato per categoria ID:", categoryId);

            if (!categoryId) {
                console.error("ID categoria non trovato nel link:", link);
                return;
            }

            this.loadCategoryForEdit(categoryId);
        };

        link.addEventListener('click', editHandler);
    }
    /**
     * Carica i dati della categoria per la modifica
     */
    async loadCategoryForEdit(categoryId) {
        try {
            const url = `${this.contextPath}/ManageCategoryServlet?action=edit&id=${categoryId}`;
            const data = await this.makeRequest(url);

            if (data.success && data.category) {
                console.log("Dati della categoria caricati per la modifica:", data.category);
                this.populateFormForEdit(data.category);
                this.openModal();
            } else {
                this.showMessage("❌ Errore nel caricamento della categoria", "#f44336");
            }
        } catch (error) {
            console.error('Errore nel caricamento della categoria:', error);
            this.showMessage("❌ Errore nel caricamento della categoria", "#f44336");
        }
    }

    /**
     * Popola il form con i dati della categoria per la modifica
     */
    populateFormForEdit(category) {
        this.setFormValue('categoryName', category.categoryName);
        this.setFormValue('categoryPath', category.categoryPath);

        // Salva l'ID per l'aggiornamento
        this.currentEditId = category.categoryId;

        this.setEditMode();
    }

    getCurrentEditId() {
        return this.currentEditId;
    }

    setEditMode() {
        const submitBtn = document.getElementById('submitBtn');
        const modalTitle = document.getElementById('modalTitle');

        if (submitBtn) submitBtn.textContent = 'Modifica Categoria';
        if (modalTitle) modalTitle.textContent = 'Modifica Categoria';
    }
}

// Esposizione globale per il sistema
window.CategoryManager = CategoryManager;
