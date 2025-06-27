const inputTable = document.getElementById("searchBarTable"); /* campo di testo */
const suggestionBoxTable = document.getElementById("suggestions-for-table"); /* contenitore dove verranno mostrati i suggerimenti */
const searchBarWrapperTable = document.querySelector('.manage-components-container-right_search-bar'); /* usato per applicare stili comuni, comprende sia barra di ricerca che suggerimenti */
const contextPathTable = document.getElementsByTagName("body")[0].dataset.contextPath; /* usato per avere l'URL corretto */
const entity = document.body.dataset.entity;

let timeoutT = null;

inputTable.addEventListener('input', function (e) {
    /* Cancella qualsiasi timer precedentemente impostato e (vedi fine codice) fa aspettare 300 millisec. prima di eseguire subito la ricerca */
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
    event.preventDefault();
    const formData = new FormData(this);
    const url = `${contextPathTable}/AddProductServlet`;

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
                const tableBody = document.getElementById('componentTableBody');

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
