const inputTable = document.getElementById("searchBarTable"); /* campo di testo */
const suggestionBoxTable = document.getElementById("suggestions-for-table"); /* contenitore dove verranno mostrati i suggerimenti */
const searchBarWrapperTable = document.querySelector('.manage-components-container-right_search-bar'); /* usato per applicare stili comuni, comprende sia barra di ricerca che suggerimenti */
const contextPathTable = document.getElementsByTagName("body")[0].dataset.contextPath; /* usato per avere l'URL corretto */

let timeoutT = null;

inputTable.addEventListener('input', function (e) {
    /* cancella qualsiasi timer precedentemente impostato e (vedi fine codice) fa aspettare 300 millisec. prima di eseguire subito la ricerca */
    clearTimeout(timeout);
    const value = this.value.trim(); /* prende il testo dalla barra e rimuove eventuali spazi bianchi */


    if(value.length === 0) {
        suggestionBoxTable.innerHTML = ''; /* svuota contenitore suggerimenti */
        suggestionBoxTable.classList.remove('active'); /* rimuove la classe active che rende visibile il contenitore */
        searchBarWrapperTable.classList.remove('active');
        return;
    }

    /* prendiamo l'URL corretto */
    const url = `${contextPathTable}/SuggestionsTableServlet?searchQueryTable=${encodeURIComponent(value)}`; /* codifica caratteri speciali per renderli sicuri in un URL */

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

            // Applica le proprietà stile "cart-notification"
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

            messageElement.innerText = data.success ? '✅ Caricamento riuscito' : '❌ Caricamento fallito';

            closeModal();

            // Nasconde il messaggio dopo 2 secondi con animazione inversa
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
