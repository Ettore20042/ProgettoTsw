document.addEventListener('DOMContentLoaded', function() {
    const addAddressBtn = document.getElementById('addAddressBtn');
    const addressModal = document.getElementById('addressModal');
    const closeModalBtn = document.getElementById('close-address-modal');
    const addAddressForm = document.getElementById('addAddressForm');
    const contextPath = '/' + window.location.pathname.split('/')[1];

    // Gestione metodi di pagamento
    const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
    const creditCardForm = document.getElementById('credit-card-form');

    paymentMethods.forEach(method => {
        method.addEventListener('change', function() {
            if (this.value === 'credit_card') {
                creditCardForm.style.display = 'block';
                // Rendi obbligatori i campi della carta
                document.getElementById('cardNumber').required = true;
                document.getElementById('cardHolder').required = true;
                document.getElementById('expiryDate').required = true;
                document.getElementById('cvv').required = true;
            } else {
                creditCardForm.style.display = 'none';
                // Rimuovi l'obbligo per i campi della carta
                document.getElementById('cardNumber').required = false;
                document.getElementById('cardHolder').required = false;
                document.getElementById('expiryDate').required = false;
                document.getElementById('cvv').required = false;
            }
        });
    });

    // Formattazione numero carta di credito
    const cardNumberInput = document.getElementById('cardNumber');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');// Rimuovi spazi e caratteri non numerici
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;// Aggiungi uno spazio ogni 4 cifre
            e.target.value = formattedValue;
        });
    }

    // Formattazione data di scadenza
    const expiryDateInput = document.getElementById('expiryDate');
    if (expiryDateInput) { // Aggiungi un listener per la formattazione della data di scadenza
        expiryDateInput.addEventListener('input', function(e) { // Rimuovi tutti i caratteri non numerici
            let value = e.target.value.replace(/\D/g, '');// Rimuovi tutti i caratteri non numerici
            if (value.length >= 2) {// Aggiungi lo slash dopo i primi due caratteri
                value = value.substring(0, 2) + '/' + value.substring(2, 4);// Limita la lunghezza a 5 caratteri (MM/AA)
            }
            e.target.value = value;
        });
    }

    // Validazione CVV (solo numeri)
    const cvvInput = document.getElementById('cvv');
    if (cvvInput) {
        cvvInput.addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/[^0-9]/g, '');// Rimuovi tutti i caratteri non numerici
        });
    }

    // Gestione pulsanti di navigazione
    const btnBack = document.querySelector('.btn-back');
    const btnConfirmOrder = document.querySelector('.btn-confirm-order');

    if (btnBack) {
        btnBack.addEventListener('click', function() {
            window.history.back(); // Torna alla pagina precedente
        });
    }

    if (btnConfirmOrder) {
        btnConfirmOrder.addEventListener('click', function() {
            // Qui andrà la logica per confermare l'ordine
            if (validateCheckoutForm()) {
                processOrder();
            }
        });
    }

    // Apri il modal quando si clicca sul pulsante "Aggiungi nuovo indirizzo"
    if (addAddressBtn) {
        addAddressBtn.addEventListener('click', function() {
            addressModal.style.display = 'block';
        });
    }

    // Chiudi il modal quando si clicca sulla X
    if (closeModalBtn) {
        closeModalBtn.addEventListener('click', function() {
            addressModal.style.display = 'none';
            // Reset del form quando si chiude il modal
            if (addAddressForm) {
                addAddressForm.reset();
            }
        });
    }

    // Chiudi il modal quando si clicca fuori dal contenuto
    window.addEventListener('click', function(event) {
        if (event.target === addressModal) {
            addressModal.style.display = 'none';
            // Reset del form quando si chiude il modal
            if (addAddressForm) {
                addAddressForm.reset();
            }
        }
    });

    // Gestione submit del form indirizzi
    if (addAddressForm) {
        addAddressForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent the default form submission

            // Disabilita il pulsante di submit per evitare doppi invii
            const submitBtn = document.getElementById('submitAddressBtn');
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.textContent = 'Salvataggio...';
            }

            // Get the form data as FormData (not JSON)
            const formData = new FormData(event.target);



            // Send the FormData directly (not JSON)
            fetch(`${contextPath}/AddAddressServlet`, {
                method: 'POST',
                body: formData // Remove Content-Type header, let browser set it
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    showMessage('Indirizzo aggiunto con successo!', 'success');

                    // Chiudi il modal
                    addressModal.style.display = 'none';
                    // Reset del form
                    addAddressForm.reset();
                    // Ricarica la pagina dopo un breve delay per mostrare il messaggio
                    setTimeout(() => {
                        window.location.reload(); // Ricarica la pagina per aggiornare gli indirizzi
                    }, 2000);
                } else {
                    showMessage(data.message || 'Errore durante il salvataggio dell\'indirizzo.', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showMessage('Si è verificato un errore durante il salvataggio dell\'indirizzo.', 'error');
            })
            .finally(() => {
                // Riabilita il pulsante di submit
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Aggiungi Indirizzo';
                }
            });
        });
    }
});
// Funzione per validare il form di checkout
function validateCheckoutForm() {
    // Verifica che sia selezionato un indirizzo di spedizione
    const shippingAddress = document.querySelector('input[name="shippingAddressId"]:checked');
    if (!shippingAddress) {
        showMessage('Seleziona un indirizzo di spedizione', 'error');
        return false;
    }

    // Verifica che sia selezionato un indirizzo di fatturazione
    const billingAddress = document.querySelector('input[name="billingAddressId"]:checked');
    if (!billingAddress) {
        showMessage('Seleziona un indirizzo di fatturazione', 'error');
        return false;
    }

    // Verifica che sia selezionato un metodo di pagamento
    const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
    if (!paymentMethod) {
        showMessage('Seleziona un metodo di pagamento', 'error');
        return false;
    }

    // Se è selezionata la carta di credito, verifica i dati
    if (paymentMethod.value === 'credit_card') {
        const cardNumber = document.getElementById('cardNumber').value;
        const cardHolder = document.getElementById('cardHolder').value;
        const expiryDate = document.getElementById('expiryDate').value;
        const cvv = document.getElementById('cvv').value;

        if (!cardNumber || !cardHolder || !expiryDate || !cvv) {
            showMessage('Compila tutti i dati della carta di credito', 'error');
            return false;
        }

        // Validazione formato data scadenza
        const expiryPattern = /^(0[1-9]|1[0-2])\/\d{2}$/;
        if (!expiryPattern.test(expiryDate)) {
            showMessage('Formato data scadenza non valido (MM/AA)', 'error');
            return false;
        }

        // Validazione CVV
        if (cvv.length < 3 || cvv.length > 4) {
            showMessage('CVV deve essere di 3 o 4 cifre', 'error');
            return false;
        }
    }

    return true;
}
function processOrder() {
    const confirmBtn = document.querySelector('.btn-confirm-order');
    if (confirmBtn) {
        confirmBtn.disabled = true;
        confirmBtn.textContent = 'Elaborazione in corso...';
    }

    // Raccolta dati dell'ordine
    const orderData = {
        shippingAddressId: document.querySelector('input[name="shippingAddressId"]:checked').value,
        billingAddressId: document.querySelector('input[name="billingAddressId"]:checked').value,
        totalAmount: document.getElementById('total').value,


    };



    // Chiamata AJAX per processare l'ordine
    fetch(`${contextPath}/ProcessOrderServlet`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: orderData
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                showMessage('Ordine confermato con successo!', 'success');

                // Redirect alla pagina di conferma ordine
                setTimeout(() => {
                    window.location.href = `${contextPath}/orderConfirmation.jsp?orderId=${data.orderId}`;
                }, 2000);
            } else {
                showMessage(data.message || 'Errore durante l\'elaborazione dell\'ordine', 'error');
                // Riabilita il pulsante in caso di errore
                confirmBtn.disabled = false;
                confirmBtn.textContent = 'Conferma Ordine';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showMessage('Si è verificato un errore durante l\'elaborazione dell\'ordine', 'error');

            // Riabilita il pulsante in caso di errore
            confirmBtn.disabled = false;
            confirmBtn.textContent = 'Conferma Ordine';
        });
}
// Mostra un messaggio di successo o errore
function showMessage(message, type) {
    const messageBox = document.getElementById('message');
    messageBox.textContent = message;
    messageBox.className = type === 'success' ? 'alert alert-success show' : 'alert alert-danger show';
    messageBox.style.display = 'block';

    // Scroll to message
    messageBox.scrollIntoView({ behavior: 'smooth', block: 'center' });

    // Hide the message after 5 seconds for success, 7 seconds for error
    const timeout = type === 'success' ? 5000 : 7000;
    setTimeout(() => {
        messageBox.style.display = 'none';
        messageBox.className = ''; // Reset classes
    }, timeout);
}

// Gestione rimozione indirizzi
// Aggiungi event listener a tutte le icone delete
document.addEventListener('DOMContentLoaded', function() {
    // Seleziona tutte le icone delete
    const deleteIcons = document.querySelectorAll('.delete-icon');

    deleteIcons.forEach(icon => {
        icon.addEventListener('click', function(event) {
            // Ferma la propagazione per evitare di selezionare il radio button
            event.stopPropagation();
            event.preventDefault();

            // Trova l'indirizzo associato
            const addressElement = this.closest('.checkout-address');
            const radioButton = addressElement.querySelector('input[type="radio"]');
            const addressId = radioButton.value;
            const addressType = radioButton.name.includes('shipping') ? 'shipping' : 'billing';

            // Conferma eliminazione
            if (confirm('Sei sicuro di voler eliminare questo indirizzo?')) {
                deleteAddress(addressId, addressType, addressElement);
            }
        });
    });
});

function deleteAddress(addressId, addressType, addressElement) {
     console.log(`Deleting address with ID: ${addressId}, Type: ${addressType}`);

    // Chiamata AJAX per eliminare l'indirizzo
    fetch(`${contextPath}/AddAddressServlet?addressId=${addressId}&addressType=${addressType}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',

        }

    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Rimuovi l'elemento dal DOM
                addressElement.remove();

                // Se era selezionato, seleziona il primo disponibile
                checkAndSelectFirstAddress(addressType);

                showMessage('Indirizzo eliminato con successo!', 'success');
            } else {
                showMessage('Errore durante l\'eliminazione dell\'indirizzo', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showMessage('Errore durante l\'eliminazione dell\'indirizzo', 'error');
        });
}

function checkAndSelectFirstAddress(addressType) {
    const container = addressType === 'shipping'
        ? document.querySelector('.shipping-addresses')
        : document.querySelector('.billing-addresses');

    const firstRadio = container.querySelector('input[type="radio"]');
    if (firstRadio) {
        firstRadio.checked = true;
    }
}

