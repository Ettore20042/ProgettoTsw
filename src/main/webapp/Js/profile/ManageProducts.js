const inputTable = document.getElementById("searchBarTable"); /* campo di testo */
const suggestionBoxTable = document.getElementById("suggestions-for-table"); /* contenitore dove verranno mostrati i suggerimenti */
const searchBarWrapperTable = document.querySelector('.manage-components-container-right_search-bar'); /* usato per applicare stili comuni, comprende sia barra di ricerca che suggerimenti */
const contextPathTable = document.getElementsByTagName("body")[0].dataset.contextPath; /* usato per avere l'URL corretto */
const entity = document.body.dataset.entity;
const submitBtn = document.getElementById("submitBtn");
console.log("submitBtn:", submitBtn.textContent); /* per debug, mostra il testo del pulsante di submit */

let timeoutT = null;

inputTable.addEventListener('input', function (e) {
    /* Cancella qualsiasi timer precedentemente impostato e (vedi fine codice) fa aspettare 300 millisec. Prima di eseguire subito la ricerca */
    clearTimeout(timeout);
    const value = this.value.trim(); /* prende il testo dalla barra e rimuove eventuali spazi bianchi */


    if(value.length === 0) {
        suggestionBoxTable.innerHTML = ''; /* svuota contenitore suggerimenti */
        suggestionBoxTable.classList.remove('active'); /* rimuove la classe active che rende visibile il contenitore */
        searchBarWrapperTable.classList.remove('active');
        return;
    }

    /* prendiamo l'URL corretto */
    const url = `${contextPathTable}/SuggestionsServlet?entity=${entity}&query=${encodeURIComponent(value)}`; /* codifica caratteri speciali per renderli sicuri in un URL */

    /* avvia la richiesta asincrona */
    timeoutT = setTimeout(() => {
        fetch(url)
            .then(response => response.json())
            .then(results => {
                suggestionBoxTable.innerHTML = '';

                /* results conterrà l'array dei suggerimenti*/
                if (results.length === 0) { /* se è vuoto, il box dei suggerimenti viene nascosto */
                    suggestionBoxTable.classList.remove('active');
                    searchBarWrapperTable.classList.remove('active');
                    return;
                }

                /*se ci sono risultati, il box viene reso visibile aggiungendo la classe active */
                suggestionBoxTable.classList.add('active');
                searchBarWrapperTable.classList.add('active');

                /* crea un ciclo per ogni item */
                results.forEach(item => {
                    const div = document.createElement('div');
                    div.textContent = item; /* imposta il testo al div */
                    div.classList.add('suggestion-for-table-item'); /* aggiunge una classe css per stilizzare il div */
                    div.addEventListener('click', () => { /* quando l'utente clicca sul suggerimento*/
                        inputTable.value = item; /* valore della barra di ricerca aggiornato */
                        suggestionBoxTable.innerHTML = ''; /* box suggerimenti svuotato e nascosto */
                        suggestionBoxTable.classList.remove('active');
                        searchBarWrapperTable.classList.remove('active');
                        inputTable.form.submit(); /* sottomette il form a cui appartiene la barra di ricerca, eseguendo la ricerca vera e propria col valore selezionato */
                    });

                    /* il div viene aggiunto al contenitore */
                    suggestionBoxTable.appendChild(div);
                });
            })
            .catch(error => {
                console.error('Errore:', error);
                suggestionBoxTable.classList.remove('active');
                searchBarWrapperTable.classList.remove('active');
            });
    }, 300);
})
function openModal() {
    document.getElementById("productModal").style.display = 'flex';
}

function closeModal() {
    document.getElementById("productModal").style.display = 'none';
    resetForm();
}

// Funzione per aggiungere event listener ai pulsanti di rimozione
function addRemoveEventListener(button) {
    button.addEventListener('click', function (e) {
        e.preventDefault();
        const productId = this.getAttribute('data-id');
        console.log("Deleting productId:", productId);
        const url = `${contextPathTable}/RemoveProductServlet?productId=${encodeURIComponent(productId)}`;

        const clickedButton = this;

        fetch(url, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    const productRow = clickedButton.closest('tr');
                    if (productRow) {
                        productRow.remove();
                    }
                } else {
                    console.error('Error removing product:', data.message || data.error);
                }
            })
            .catch(error => {
                console.error('Error removing product:', error);
            });
    });
}

// Inizializzazione: aggiungi event listener a tutti i pulsanti di rimozione esistenti
document.querySelectorAll('.remove-button-product').forEach(button => {
    addRemoveEventListener(button);
});


document.getElementById('addProductForm').addEventListener('submit', function(event) {
    console.log("submitBtn:", submitBtn.textContent); /* per debug, mostra il testo del pulsante di submit */
    event.preventDefault();
    const formData = new FormData(this);
    const url = `${contextPathTable}/AddProductServlet`;
    console.log("submitBtn:", submitBtn.textContent); /* per debug, mostra il testo del pulsante di submit */
     if(submitBtn.textContent === 'Aggiungi Prodotto') {
         fetch(url, {
             method: 'POST',
             body: formData
         })
             .then(response => {
                 if (!response.ok) {
                     throw new Error(`HTTP error! status: ${response.status}`);
                 }
                 return response.json();
             })
             .then(data => {
                 const messageElement = document.getElementById("message");

                 if (data.success && data.product) { // Controlla se i dati sono validi, la risposta e se ce un oggetto prodotto
                     const tableBody = document.querySelector('.componentTableBody');

                     // Aggiunta riga nuova alla tabella
                     const newRow = document.createElement('tr');
                     newRow.innerHTML = `
                <td>${data.product.productId}</td>
                <td>${data.product.productName}</td>
                <td>${data.product.price}</td>
                <td>${data.product.color}</td>
                <td>${data.product.quantity}</td>
                <td><a href="#">Modifica</a></td>
                <td>
                    <button type="button" class="remove-button-product remove-item-btn" data-id="${data.product.productId}">
                        <img src="${contextPathTable}/img/icon/delete.png" class="remove-icon">
                    </button>
                </td>
            `;

                     tableBody.appendChild(newRow);

                     // Aggiunta event listener per rimozione (se definito)
                     const newButton = newRow.querySelector('.remove-button-product');
                     if (typeof addRemoveEventListener === 'function') {
                         addRemoveEventListener(newButton);
                     }

                     // Mostra messaggio di successo
                     mostraMessaggio("✅ Caricamento riuscito", "#4CAF50");
                     this.reset(); // reset del form
                 } else {
                     console.warn("Dati non validi:", data);
                     mostraMessaggio("❌ Caricamento fallito", "#f44336");
                 }

                 closeModal();

             })
             .catch(error => {
                 console.error("Errore nella richiesta:", error);
                 mostraMessaggio(`❌ Errore: ${error.message}`, "#f44336");
             });
     }else if (submitBtn.textContent === 'Modifica Prodotto') {
         console.log("[DEBUG] Modalità: Modifica Prodotto");

         const link = document.querySelector('.edit-link');
         if (!link) {
             console.error("[ERRORE] Nessun elemento con classe .edit-link trovato!");
             return;
         }
         const productId = link.dataset.productId;
         console.log("[DEBUG] productId estratto:", productId);
         const url = `${contextPathTable}/AddProductServlet?azione=confermaModifica&id=${productId}`;
         console.log("[DEBUG] URL della fetch:", url);

         fetch(url, {
             method: 'POST',
             body: formData
         })
             .then(response => {
                 console.log("[DEBUG] Risposta fetch ricevuta:", response);
                 if (!response.ok) {
                     throw new Error(`HTTP error! status: ${response.status}`);
                 }
                 return response.json();
             })
             .then(data => {
                 console.log("[DEBUG] Risposta JSON parsata:", data);
                 if (data.success) {
                     console.log("[SUCCESS] Modifica avvenuta con successo.");
                     mostraMessaggio("✅ Modifica riuscita", "#4CAF50");
                     closeModal();
                     location.reload();
                 } else {
                     console.warn("[WARNING] Modifica fallita, messaggio server:", data.message || data.error || data);
                     mostraMessaggio("❌ Modifica fallita", "#f44336");
                 }
             })
             .catch(error => {
                 console.error("[ERRORE] Errore durante la fetch:", error);
                 mostraMessaggio(`❌ Errore: ${error.message}`, "#f44336");
             });
     }

    // Funzione per mostrare il messaggio
    function mostraMessaggio(testo, coloreSfondo) {
        const messageElement = document.getElementById("message");
        Object.assign(messageElement.style, {
            display: 'flex',
            position: 'fixed',
            top: '20px',
            right: '20px',
            backgroundColor: coloreSfondo,
            color: 'white',
            padding: '15px',
            borderRadius: '5px',
            boxShadow: '0 4px 8px rgba(0,0,0,0.2)',
            opacity: '1',
            transform: 'translateY(0)',
            transition: 'all 0.3s ease',
            zIndex: '1000'
        });

        messageElement.innerText = testo;

        // Rimuove il messaggio dopo 2 secondi
        setTimeout(() => {
            messageElement.style.opacity = '0';
            messageElement.style.transform = 'translateY(-20px)';
        }, 2000);
    }
});
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.edit-link').forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault(); // previeni il comportamento di default
            const productId = this.dataset.productId;
            loadProductForEdit(productId);
        });
    });
});

function loadProductForEdit(productId) {
    fetch(`${contextPathTable}/AddProductServlet?azione=modifica&productId=${productId}`, {
        method: 'GET',
        headers: {
            'Accept': 'application/json'
        }
    })
        .then(response => {


            // Controlla se la risposta è effettivamente JSON
            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                throw new Error('Response is not JSON');
            }

            return response.json();
        })
        .then(data => {
            if(data.success && data.product) {
                const product = data.product;
                const image=data.image;

                // Questi dovrebbero funzionare
                document.getElementById('productName').value = product.productName || '';
                document.getElementById('price').value = product.price || '';
                document.getElementById('salePrice').value = product.salePrice || '';
                document.getElementById('color').value = product.color || '';
                document.getElementById('description').value = product.description || '';
                document.getElementById('quantity').value = product.quantity || '';
                document.getElementById('material').value = product.material || '';
                document.getElementById('category').value = product.categoryId || '';
                document.getElementById('brand').value = product.brandId || '';
                document.getElementById('descriptionImage').value = image.imageDescription || '';




                const imagePreview = document.getElementById('imagePreview');
                imagePreview.style.display = 'block'; // Assicurati che il preview sia visibile
                if (image && image.imagePath && imagePreview) {

                    imagePreview.src = contextPathTable+image.imagePath;
                    imagePreview.style.marginBottom = "1.5rem"; // Imposta una larghezza massima per il preview
                }



                const imageListDiv = document.getElementById("imageList");
                imageListDiv.innerHTML = ""; // Pulisce vecchie immagini
                imageListDiv.style.display = 'block'; // Assicurati che il contenitore sia visibile

                if (Array.isArray(data.images)) {
                    data.images.forEach(img => {
                        const imageElement = document.createElement("img");
                        imageElement.src = contextPath + img.imagePath;
                        imageElement.alt = img.imageDescription || "immagine prodotto";
                        imageElement.style.maxWidth = "150px";
                        imageElement.style.margin = "5px";

                        imageListDiv.appendChild(imageElement);

                        console.log("Aggiunta immagine:", imageElement.src);
                    });
                } else {
                    console.warn("Nessuna lista immagini trovata");
                }






                const submitBtn = document.getElementById('submitBtn');
                if (submitBtn) {
                    submitBtn.textContent = 'Modifica Prodotto';
                }

                // Cambia anche il titolo del modal se ne hai uno
                const modalTitle = document.getElementById('modalTitle');
                if (modalTitle) {
                    modalTitle.textContent = 'Modifica Prodotto';
                }
                // Ora apri il modal (se usi modal)
                openModal();
            } else {
                alert("Errore nel caricamento del prodotto");
            }
        })
        .catch(err => console.error('Fetch error:', err));
}
function resetForm ()  {
    document.getElementById('productName').value = '';
    document.getElementById('price').value = '';
    document.getElementById('salePrice').value = '';
    document.getElementById('color').value = '';
    document.getElementById('description').value = '';
    document.getElementById('quantity').value = '';
    document.getElementById('material').value = '';
    document.getElementById('category').value = '';
    document.getElementById('brand').value = '';

    const submitBtn = document.getElementById('submitBtn');
    if (submitBtn) {
        submitBtn.textContent = 'Aggiungi Prodotto';
    }

    // Cambia anche il titolo del modal se ne hai uno
    const modalTitle = document.getElementById('modalTitle');
    if (modalTitle) {
        modalTitle.textContent = 'Aggiungi Prodotto';
    }
    const imagePreview = document.getElementById('imagePreview');
    imagePreview.style.display = 'none'; // Nascondi il preview dell'immagine
    imagePreview.src = ''; // Resetta la sorgente dell'immagine

    const imageListDiv = document.getElementById("imageList");
    imageListDiv.innerHTML = ""; // Pulisce vecchie immagini
    imageListDiv.style.display = 'none'; // Nascondi il contenitore delle immagini

}

// In ManageProducts.js - Fix the fetch call





function mostraMessaggio(testo, coloreSfondo) {
    const notifica = document.getElementById("message");
    notifica.textContent = testo;
    notifica.style.backgroundColor = coloreSfondo;
    notifica.style.color = "white";
    notifica.style.display = "block";

    // Nascondi dopo 3 secondi
    setTimeout(() => {
        notifica.style.display = "none";
    }, 3000);
}

