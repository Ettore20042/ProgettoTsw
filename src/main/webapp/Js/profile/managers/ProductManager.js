/**
 * ProductManager.js - Manager specifico per la gestione dei prodotti
 * Estende BaseManager con funzionalità specifiche per i prodotti
 */

class ProductManager extends BaseManager {
    constructor(system) {
        super(system);
        this.initializeProductEvents();
    }

    initializeProductEvents() {
        this.initializeFormSubmission();
        this.initializeRemoveButtons();
        this.initializeEditLinks();
    }

    /**
     * Gestione del form di aggiunta/modifica prodotti
     */
    initializeFormSubmission() {
        const form = document.getElementById('addProductForm');
        if (!form) return;

        form.addEventListener('submit', (event) => {
            event.preventDefault();
            const submitBtn = document.getElementById('submitBtn');
            const isEdit = submitBtn?.textContent === 'Modifica Prodotto';

            if (isEdit) {
                this.updateProduct(form);
            } else {
                this.addProduct(form);
            }
        });
    }

    /**
     * Aggiunta nuovo prodotto
     */
    async addProduct(form) {
        try {
            const formData = new FormData(form);
            const url = `${this.contextPath}/AddProductServlet`;

            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success && data.product) {
                this.addProductToTable(data.product);
                this.showMessage("✅ Prodotto aggiunto con successo", "#4CAF50");
                form.reset();
                this.closeModal();
            } else {
                this.showMessage("❌ Errore nell'aggiunta del prodotto", "#f44336");
            }
        } catch (error) {
            console.error("Errore nell'aggiunta del prodotto:", error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Modifica prodotto esistente
     */
    async updateProduct(form) {
        try {
            const link = document.querySelector('.edit-link');
            if (!link) {
                throw new Error("Nessun elemento di modifica trovato");
            }

            const productId = form.querySelector('[name="productId"]').value;
            const formData = new FormData(form);
            const url = `${this.contextPath}/AddProductServlet?azione=confermaModifica&id=${productId}`;


            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                this.showMessage("✅ Prodotto modificato con successo", "#4CAF50");
                this.closeModal();
                location.reload();
            } else {
                this.showMessage("❌ Errore nella modifica del prodotto", "#f44336");
            }
        } catch (error) {
            console.error("Errore nella modifica del prodotto:", error);
            this.showMessage(`❌ Errore: ${error.message}`, "#f44336");
        }
    }

    /**
     * Aggiunge una nuova riga alla tabella dei prodotti
     */
    addProductToTable(product) {
        const tableBody = document.querySelector('.componentTableBody');
        if (!tableBody) return;

        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td>${product.productId}</td>
            <td>${product.productName}</td>
            <td>${product.price}</td>
            <td>${product.color}</td>
            <td>${product.quantity}</td>
            <td>
                <a href="#" class="edit-link" data-product-id="${product.productId}">Modifica</a>
            </td>
            <td>
                <button type="button" class="remove-button-product remove-item-btn" data-id="${product.productId}">
                    <img src="${this.contextPath}/img/icon/delete.png" class="remove-icon">
                </button>
            </td>
        `;

        tableBody.appendChild(newRow);

        const editLink = newRow.querySelector('.edit-link');
        const removeButton = newRow.querySelector('.remove-button-product');

        if (editLink) this.addEditEventListener(editLink);
        if (removeButton) this.addRemoveEventListener(removeButton);
    }

    /**
     * Gestione dei pulsanti di rimozione
     */
    initializeRemoveButtons() {
        document.querySelectorAll('.remove-button-product').forEach(button => {
            this.addRemoveEventListener(button);
        });
    }

    addRemoveEventListener(button) {
        button.addEventListener('click', async (e) => {
            e.preventDefault();

            if (!confirm('Sei sicuro di voler eliminare questo prodotto?')) {
                return;
            }

            try {
                const productId = button.getAttribute('data-id');
                const url = `${this.contextPath}/RemoveProductServlet?productId=${encodeURIComponent(productId)}`;

                const data = await this.makeRequest(url, { method: 'DELETE' });

                if (data.success) {
                    const productRow = button.closest('tr');
                    if (productRow) {
                        productRow.remove();
                        this.showMessage("✅ Prodotto eliminato con successo", "#4CAF50");
                    }
                } else {
                    this.showMessage("❌ Errore nell'eliminazione del prodotto", "#f44336");
                }
            } catch (error) {
                console.error('Errore nell\'eliminazione del prodotto:', error);
                this.showMessage("❌ Errore nell'eliminazione del prodotto", "#f44336");
            }
        });
    }

    /**
     * Gestione dei link di modifica
     */
    initializeEditLinks() {
        document.querySelectorAll('.edit-link').forEach(link => {
            this.addEditEventListener(link);
        });
        console.log("✅ Event listeners per i link di modifica inizializzati");
    }




    addEditEventListener(link) {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const productId = link.dataset.productId;
            this.loadProductForEdit(productId);
        });

        console.log(`✅ Event listener aggiunto con successo per productId: ${link.dataset.productId}`);
    }

    /**
     * Carica i dati del prodotto per la modifica
     */
    async loadProductForEdit(productId) {
        try {
            const url = `${this.contextPath}/AddProductServlet?productId=${productId}`;

            const response = await fetch(url, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            });

            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                throw new Error('Response is not JSON');
            }

            const data = await response.json();

            if (data.success && data.product) {

                this.populateFormForEdit(data);
                this.openModal();
            } else {
                this.showMessage("❌ Errore nel caricamento del prodotto", "#f44336");
            }
        } catch (error) {
            console.error('Errore nel caricamento del prodotto:', error);
            this.showMessage("❌ Errore nel caricamento del prodotto", "#f44336");
        }
    }

    /**
     * Popola il form con i dati del prodotto per la modifica
     */
    populateFormForEdit(data) {
        const { product, image, images } = data;
        this.setFormValue('productId', product.productId);
        this.setFormValue('productName', product.productName);
        this.setFormValue('price', product.price);
        this.setFormValue('salePrice', product.salePrice);
        this.setFormValue('color', product.color);
        this.setFormValue('description', product.description);
        this.setFormValue('quantity', product.quantity);
        this.setFormValue('material', product.material);
        this.setFormValue('category', product.categoryId);
        this.setFormValue('brand', product.brandId);
        this.setFormValue('descriptionImage', image?.imageDescription);

        this.handleImagePreview(image);
        this.handleImageList(images);
        this.setEditMode();
    }

    handleImagePreview(image) {
        const imagePreview = document.getElementById('imagePreview');
        if (imagePreview && image?.imagePath) {
            imagePreview.src = this.contextPath + image.imagePath;
            imagePreview.style.display = 'block';
            imagePreview.style.marginBottom = "1.5rem";
        }
    }

    handleImageList(images) {
        const imageListDiv = document.getElementById("imageList");
        if (!imageListDiv) return;

        imageListDiv.innerHTML = "";
        imageListDiv.style.display = 'block';

        if (Array.isArray(images)) {
            images.forEach(img => {
                const imageElement = document.createElement("img");
                imageElement.src = this.contextPath + img.imagePath;
                imageElement.alt = img.imageDescription || "immagine prodotto";
                imageElement.style.maxWidth = "150px";
                imageElement.style.margin = "5px";
                imageListDiv.appendChild(imageElement);
            });
        }
    }

    setEditMode() {
        const submitBtn = document.getElementById('submitBtn');
        const modalTitle = document.getElementById('modalTitle');

        if (submitBtn) submitBtn.textContent = 'Modifica Prodotto';
        if (modalTitle) modalTitle.textContent = 'Modifica Prodotto';
    }
}

// Esposizione globale per il sistema
window.ProductManager = ProductManager;
