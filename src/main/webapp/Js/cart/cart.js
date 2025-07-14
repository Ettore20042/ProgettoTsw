/**
 * Funzioni dello script:
 * -permettere all'utente di modificare la quantità di un prodotto direttamente nella pagina del carrello
 * e vedere subito i dati aggiornati, senza ricaricare la pagina
 *
 * -comunica la modifica al server per renderla permanente
 * -carica dinamicamente la quantità massima disponibile per ogni prodotto
 */

document.addEventListener('DOMContentLoaded', function() {

    /**
     * Funzione principale che gestisce tutti gli input quantity del carrello
     * Itera una sola volta su tutti gli input per efficienza
     */
    function initializeQuantityInputs() {
        const quantityInputs = document.querySelectorAll('.quantity-input');

        quantityInputs.forEach(input => {
            // Verifica se l'attributo max è già stato settato
            if (!input.hasAttribute('data-max-loaded')) {
                // Se non è settato, carica prima la quantità massima
                loadMaxQuantityForInput(input);
                addChangeListenerToInput(input);
            } else {
                // Se è già settato, aggiunge direttamente il listener
                addChangeListenerToInput(input);
            }
        });
    }

    /**
     * Carica la quantità massima per un singolo input
     */
    function loadMaxQuantityForInput(input) {
        const productId = input.closest('tr').dataset.productId;
        const contextPath = document.body.dataset.contextPath;

        fetch(`${contextPath}/ProductServlet?action=getStock&productId=${productId}`)
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Errore recupero stock');
                }
            })
            .then(data => {
                // Imposta il max con la quantità disponibile
                input.setAttribute('max', data.stock);
                input.setAttribute('data-max-loaded', 'true');
                console.log(`Max quantity loaded for product ${productId}: ${data.stock}`);
            })
            .catch(error => {
                console.warn(`Error loading stock for product ${productId}:`, error);
                // Fallback: mantiene il max di default
                input.setAttribute('max', 30000);
                input.setAttribute('data-max-loaded', 'true');
            });
    }

    /**
     * Aggiunge il listener di change a un singolo input
     * Contiene la logica originale di updateQuantityInput
     */
    function addChangeListenerToInput(input) {
        input.addEventListener('change', (e) => {
            //prende la nuova quantità inserita
            const quantity = e.target.value;
            //prende il productId associato a quella riga
            const productId = e.target.closest('tr').dataset.productId;
            const contextPath = document.body.dataset.contextPath;
            const formData = new URLSearchParams();

            formData.append('productId', productId);
            formData.append('quantity', quantity);
            formData.append('update', 'true');

            //invia una richiesta POST asincrona alla CartServlet
            fetch(`${contextPath}/CartServlet`, {
                method: 'POST',
                body: formData,
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    //converte la risposta in oggetto js
                    return response.json();
                }).then(data => {
                const lastQuantity = parseInt(data.lastQuantity, 10);
                const quantityDifference = quantity - lastQuantity;
                console.log(lastQuantity);
                //aggiorna l'icona del carrello
                const cartcount = document.querySelector('.cart-count');
                if (cartcount) {
                    cartcount.textContent = parseInt(cartcount.textContent, 10) + quantityDifference; //incrementa il contatore del carrello
                }
            });

            //chiama le due funzioni di aggiornamento
            updateRowTotal(e.target.closest('tr'), quantity, parseFloat(e.target.dataset.price));
            updateCartTotal();
        });
    }

    //aggiorna il subtotale di una singola riga
    function updateRowTotal(row, quantity, price) {
        // const row = inputElement.closest('.cart-row');//trova la riga genitore dell'input
        quantity = parseInt(quantity, 10); //assicurati che la quantità sia un numero intero
        if (row) {
            //al suo interno cerca l'elemento che mostra il totale (.total-value)
            const totalElement = row.querySelector('.total-value');
            if (totalElement) {
                //calcola il totale aggiornando il suo testo e formattandolo con due cifre decimali
                const total = quantity * price;
                totalElement.textContent = '€ ' + total.toFixed(2);
            }
        } else {
            console.error('Riga non trovata per l\'aggiornamento del totale.');
        }
    }

    //ricalcola e aggiorna il totale generale del carrello
    function updateCartTotal() {
        let grandTotal = 0;
        document.querySelectorAll('.cart-row').forEach(row => {//seleziona tutte le righe del carrello rimaste sulla pagina
            const totalValueElement = row.querySelector('.total-value');//per ogni riga legge il valore del suo subtotale
            if (totalValueElement) {
                //pulisce il testo per avere solo il numero
                const itemTotalText = totalValueElement.textContent
                    .replace('€', '')
                    .replace(/\s/g, '')
                    .trim();

                // Replace comma with period for proper parsing in JavaScript
                const cleanedValue = itemTotalText.replace(',', '.');

                // Parse the value and add to total, defaulting to 0 if parsing fails
                const value = parseFloat(cleanedValue);
                grandTotal += isNaN(value) ? 0 : value; //aggiunge il numero al totale generale
            }
        });

        //trova l'elemento html che mostra il totale del carrello
        const cartTotalElement = document.querySelector('.cart-total-value');
        if (cartTotalElement) {
            //aggiorna il suo testo con il nuovo totale calcolato
            cartTotalElement.textContent = '€ ' + grandTotal.toFixed(2);
        }
    }

    //la funzione viene chiamata alla fine dello script per assicurarsi che
    //al caricamento della pagina il totale del carrello sia calcolato e visualizzato correttamente
    updateCartTotal();

    // Inizializza tutti gli input quantity con un'unica iterazione
    initializeQuantityInputs();
});