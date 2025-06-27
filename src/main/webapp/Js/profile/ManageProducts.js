const inputTable = document.getElementById("searchBarTable"); /* campo di testo */
const suggestionBoxTable = document.getElementById("suggestions-for-table"); /* contenitore dove verranno mostrati i suggerimenti */
const searchBarWrapperTable = document.querySelector('.manage-components-container-right_search-bar'); /* usato per applicare stili comuni, comprende sia barra di ricerca che suggerimenti */
const contextPathTable = document.body.dataset.contextPath; /* usato per avere l'URL corretto */
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
    document.getElementById("productModal").style.display = 'flex'; /* l'elemento è nascosto di default, ma con il cambio di stile diventa visibile */
}


function closeModal() {
    document.getElementById("productModal").style.display = 'none';
}



// Funzione per aggiungere event listener ai pulsanti di rimozione
function addRemoveEventListener(button) {
    button.addEventListener('click', function (e) {
        /* impedisce il comportamento predefinito del pulsante */
        e.preventDefault();
        const productId = this.getAttribute('data-id');/* recupera l'id del prodotto da eliminare*/
        console.log("Deleting productId:", productId);
        const url = `${contextPathTable}/RemoveProductServlet?productId=${encodeURIComponent(productId)}`; /* costruisce l'URL della servlet che si occuperà della cancellazione*/

        const clickedButton = this;

        /* richiesta asincrona al server */
        fetch(url, {
            method: 'DELETE', /* specifica che si tratta di un'operazione di cancellazione*/
            headers: {
                'Content-Type': 'application/json',
            }
        })
            /*restituisce una Promise*/
            .then(response => { /* gestisce la risposta http del server */
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            /* se la rispost http era valida, il secondo .then processa i dati JSON inviati dal server */
            .then(data => {
                if (data.success) {
                    /* cerca il genitore più vicino che sia una riga di tabella <tr>. */
                    const productRow = clickedButton.closest('tr');
                    if (productRow) {
                        productRow.remove(); /*rimuove l'intera riga della tabella dal DOM, dando un feedback visivo immediato della cancellazione*/
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

// Gestione del form di aggiunta prodotto
document.getElementById('addProductForm').addEventListener('submit', function(event) {
    /* impedisce il comportamento tradizionale del form, che causerebbe un ricaricamento completo della pagina */
    event.preventDefault();
    const formData = new FormData(this); /* crea oggetto FormData che ci permette di gestire tutti i dati inseriti nei campi del form */
    const url = `${contextPathTable}/AddProductServlet`;

    fetch(url, {
        method: 'POST', /* metodo POST per inviare nuovi dati per la creazione di una risorsa*/
        body: formData /* invia i dati del form nel corpo della richiesta*/
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            const messageElement = document.getElementById("message");

            if (data.success) {
                const tableBody = document.getElementById('componentTableBody'); /* trova il corpo della tabella dove verranno inserite le nuove righe*/
                if (tableBody && data.product) {
                    const newRow = document.createElement('tr'); /* crea un nuovo elemento riga in memoria*/
                    /* popola la nuova riga usando i dati del prodotto (data.product) restituiti dal server nel JSON di risposta */
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

                    tableBody.appendChild(newRow); /* aggiunge la nuova riga alla tabella rendendola visibile nella pagina*/

                    // Aggiungi event listener al nuovo pulsante di rimozione
                    const newButton = newRow.querySelector('.remove-button-product');
                    addRemoveEventListener(newButton);
                }

                // Mostra messaggio di successo
                Object.assign(messageElement.style, {
                    display: 'flex',
                    position: 'fixed',
                    top: '20px',
                    right: '20px',
                    backgroundColor: '#4CAF50',
                    color: 'white',
                    padding: '15px',
                    borderRadius: '5px',
                    boxShadow: '0 4px 8px rgba(0,0,0,0.2)',
                    opacity: '1',
                    transform: 'translateY(0)',
                    transition: 'all 0.3s ease',
                    zIndex: '1000'
                });

                messageElement.innerText = '✅ Caricamento riuscito';

                // Resetta il form perparandolo per un nuovo inserimento
                this.reset();

            } else {
                // Messaggio di errore
                Object.assign(messageElement.style, {
                    display: 'flex',
                    position: 'fixed',
                    top: '20px',
                    right: '20px',
                    backgroundColor: '#f44336',
                    color: 'white',
                    padding: '15px',
                    borderRadius: '5px',
                    boxShadow: '0 4px 8px rgba(0,0,0,0.2)',
                    opacity: '1',
                    transform: 'translateY(0)',
                    transition: 'all 0.3s ease',
                    zIndex: '1000'
                });

                messageElement.innerText = '❌ Caricamento fallito';
            }

            closeModal();

            // Nasconde il messaggio dopo 2 secondi con animazione
            setTimeout(() => {
                messageElement.style.opacity = '0';
                messageElement.style.transform = 'translateY(-20px)';
            }, 2000);
        })
        .catch(error => {
            const messageElement = document.getElementById("message");

            Object.assign(messageElement.style, {
                display: 'flex',
                position: 'fixed',
                top: '20px',
                right: '20px',
                backgroundColor: '#f44336', // rosso errore
                color: 'white',
                padding: '15px',
                borderRadius: '5px',
                boxShadow: '0 4px 8px rgba(0,0,0,0.2)',
                opacity: '1',
                transform: 'translateY(0)',
                transition: 'all 0.3s ease',
                zIndex: '1000'
            });

            messageElement.innerText = `❌ Errore: ${error.message}`;

            setTimeout(() => {
                messageElement.style.opacity = '0';
                messageElement.style.transform = 'translateY(-20px)';
            }, 2000);
        });
});