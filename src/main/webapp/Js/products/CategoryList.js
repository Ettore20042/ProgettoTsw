/**
 * gestione dell'apertura/chiusura dei menu delle sottocategorie
 */



document.addEventListener("DOMContentLoaded", function() {
    //seleziona tutti gli elementi della pagina con questa classe (pulsanti) e per ognuno di essi esegue il codice nel ciclo
    const toggleBtns = document.querySelectorAll(".toggle-subcategories");

    toggleBtns.forEach(btn => {
        //associa a ogni pulsante una funzione che si attiverà con il click dell'utente
        btn.addEventListener("click", function() {
            const categoryCard = this.closest('.category-card'); //parte dal pulsante e trova il suo "antenato" più vicino che ha la classe .category-card
            const menu = categoryCard.querySelector('.subcategory-menu'); //trovata la scheda giusta, cerca al suo interno l'elemento con questa classe, che è il menu da mostrare/nascondere

            //controlla se il menu è nascosto, se sì lo rende visibile
            if (menu.style.display === "none" || menu.style.display === "") {
                menu.style.display = "flex";
                menu.style.flexDirection = "column";
                //per creare un'animazione fluida e di "discesa"
                setTimeout(() => {
                    menu.style.transform = "translateY(5px)";
                }, 1);
                //cambia il testo del pulsante per indicare che ora si può chiudere
                this.textContent = "▼";
            } else {
                //applica la trasformazione inversa per l'animazione di "risalita"
                menu.style.transform = "translateY(-5px)";
                setTimeout(() => {
                    menu.style.display = "none";
                }, 1);
                this.textContent = "▶";
            }
        });
    });


    /**
     * Gestione del form "aggiungi al carrello"
     */

    // Improved cart form handling
    document.querySelectorAll('.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            const formData = new FormData(this);
            const productName = this.closest('.category-product-item').querySelector('.category-product-item_name--title').textContent;
            const cartcount = document.querySelector('.cart-count');
            const button = this.querySelector('button[type="submit"]');
            button.disabled = true;
            button.textContent = 'Aggiunto al carrello';
            button.style.backgroundColor = '#4CAF50'; // Green background
            button.classList.add('added-to-cart');
            setTimeout(() => {
                button.disabled = false;
                button.textContent = 'Aggiungi al carrello';
                button.classList.remove('added-to-cart');
                button.style.backgroundColor = ''; // Reset background color
            }, 1000);  // 2000 ms = 2 secondi
            fetch(this.action, {
                method: this.method,
                body: new URLSearchParams(formData),
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',

                }
            })
                .then(res => {
                    if (!res.ok) throw new Error('Errore nella richiesta: ' + res.status);
                    return res.text();
                })
                .then(text => {
                    if(text === 'ok') {
                        // Show a nicer notification instead of alert
                        const notification = document.createElement('div');
                        notification.className = 'cart-notification';
                        notification.innerHTML = `<span>Aggiunto al carrello!</span>`;
                        document.body.appendChild(notification);

                        setTimeout(() => {
                            notification.classList.add('show');
                        }, 10);

                        setTimeout(() => {
                            notification.classList.remove('show');
                            setTimeout(() => document.body.removeChild(notification), 300);
                        }, 2000);
                    } else {
                        throw new Error('Risposta inaspettata dal server');
                    }
                    if(cartcount) {
                        cartcount.textContent = parseInt(cartcount.textContent, 10) + 1; //prende il testo del contatore del carrello e lo incrementa di 1 (10) perche la conversione va fatta in decimale

                    }
                })
                .catch(err => {
                    console.error(err);
                    alert('Errore durante l\'aggiunta al carrello');
                });
        });
    });
});