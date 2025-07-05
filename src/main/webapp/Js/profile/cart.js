document.addEventListener('DOMContentLoaded', function() {
 /*   // --- Quantity Update ---
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function(event) {
            event.preventDefault();
            //a ciascun campo di input viene associato questo ascoltatore che eseguirà la funzione ogni volta che il valore del campo cambia
            //this si riferisce all'elemento di input che l'utente ha modificato
            const productId = this.dataset.productId;
            const quantity = parseInt(this.value);
            const price = parseFloat(this.dataset.price);
            const form = this.closest('.quantity-form'); //trova il form genitore più vicino all'input

            if (quantity < 1) {
                this.value = 1; // Ensure minimum quantity is 1
            }

            updateRowTotal(this, quantity, price); //funzione per aggiornare il totale della specifica riga del carrello
            updateCartTotal(); //funzione per calcolare e aggiornare il totale generale del carrello

            if (form) {
                const formData = new URLSearchParams(); //creiamo un oggetto per contenere i dati da inviare, nel formato chiave=valore&chiave2=valore2
                //aggiungiamo i dati necessari
                formData.append('productId', productId);
                formData.append('action', 'update');
                formData.append('quantity', this.value);

                console.log(formData);
                console.log(form.action);
                //eseguiamo la richiesta
                fetch(form.action, { //URL della servlet che gestirà la richiesta
                    method: 'POST',
                    body: formData, //dati da inviare
                    headers: { //informazioni aggiuntive per il server
                        'X-Requested-With': 'XMLHttpRequest',
                        'Content-Type': 'application/x-www-form-urlencoded' //dice come interpretare i dati nel body
                    }
                })
                    .then(response => {
                        if (!response.ok) {
                            return; //se la risposta è ok, la convertiamo in JSON
                        }
                        const cartcount = document.querySelector('.cart-count');
                        if (cartcount) {
                            cartcount.textContent = parseInt(cartcount.textContent, 10) + 1; //decrementa il contatore del carrello
                        }
                    })
                    .catch(error => {
                        console.error('Error updating quantity:', error);
                    });
            }
        });
    });

    // --- Remove Item ---
    //  For AJAX removal (if you want to prevent page reload)
    fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
        /!*(async response => { // Verifica il tipo di contenuto dalla risposta per assicurarsi che sia JSON const contentType = response.headers.get("content-type");
         // Legge il corpo della risposta come testo per debug e parsing const text = await response.text();
          console.log("Raw response:", text);*!/
        .then(async response => {
            const contentType = response.headers.get("content-type");
            const text = await response.text();
            console.log("Raw response:", text);

            if (contentType && contentType.includes("application/json")) {
                return JSON.parse(text);
            } else {
                throw new Error("Response is not JSON:\n" + text);
            }
        })
        //se la risposta JSON è analizzata con successo
        .then(data => {
            if (data.success) {
                //se la rimozione è avvenuta con successo, trova la riga (.cart-row) del prodotto e la elimina direttamente dalla pagina HTML
                const cartRow = this.closest('.cart-row');
                if (cartRow) {
                    cartRow.remove();
                    updateCartTotal();//ricalcola il totale del carrello dopo la rimozione dell'articolo
                }
            } else {
                console.error('Error removing item:', data.error);
            }
        })
        .catch(error => {
            console.error('Error removing item:', error);
        });

*/

    //aggiorna il subtotale di una singola riga
    function updateRowTotal(inputElement, quantity, price) {
        const row = inputElement.closest('.cart-row');//trova la riga genitore dell'input
        if (row) {
            //al suo interno cerca l'elemento che mostra il totale (.total-value)
            const totalElement = row.querySelector('.total-value');
            if (totalElement) {
                //calcola il totale aggiornando il suo testo e formattandolo con due cifre decimali
                const total = quantity * price;
                totalElement.textContent = '€ ' + total.toFixed(2);
            }
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
});