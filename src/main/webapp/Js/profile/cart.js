document.addEventListener('DOMContentLoaded', function() {

    function updateQuantityInput() {
        const quantityInput = document.querySelectorAll('.quantity-input');

        quantityInput.forEach(input => {
            input.addEventListener('change', (e) => {
                const quantity = e.target.value;
                const productId = e.target.closest('tr').dataset.productId;
                const contextPath = document.body.dataset.contextPath;
                const formData = new URLSearchParams();

                formData.append('productId', productId);
                formData.append('quantity', quantity);
                formData.append('update', 'true');

                fetch(`${contextPath}/CartServlet`, {
                    method: 'POST',
                    body: formData,
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        return response.json();
                    }).then( data => {
                    const lastQuantity = parseInt(data.lastQuantity, 10);
                    console.log(lastQuantity);
                    const cartcount = document.querySelector('.cart-count');
                    if (cartcount) {
                        if (lastQuantity < quantity) {
                            cartcount.textContent = parseInt(cartcount.textContent, 10) + 1; //decrementa il contatore del carrello
                        }else {
                            cartcount.textContent = parseInt(cartcount.textContent, 10) - 1; //incrementa il contatore del carrello
                        }
                    }
                });
                updateRowTotal(e.target.closest('tr'), quantity, parseFloat(e.target.dataset.price));
                updateCartTotal();
            })
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
    updateQuantityInput();
});