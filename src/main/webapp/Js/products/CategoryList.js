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


});