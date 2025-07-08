/* assicura che tutto il codice sia eseguito solo dopo che l'intera pagina html è caricata dal browser */
document.addEventListener("DOMContentLoaded", function() {
    const openNavButton = document.getElementById("openNavButton");
    const closeNavButton = document.getElementById("closeNavButton");
    const profileActionsButton = document.getElementById("userProfileButton");
    const mobileNav = document.getElementById("mobileNav");
    let profileActionsDropdown = document.getElementById("userActionsDropdown"); /* menu a tendina con le azioni utente*/

    function openNav(event) {
        /* serve a impedire che il click sul bottone di apertura si propaghi ad elementi "genitori" altrimenti il menu si chiuderebbe istantaneamente*/
        event.stopPropagation();
        mobileNav.style.width = "65%"; /* mostra il menu impostando la larghezza */
        mobileNav.style.transition = "0.5s"; /* aggiunge un'animazione di mezzo secondo all'apertura*/
    }

    function closeNav() {
        mobileNav.style.width = "0"; /* imposta la larghezza a 0 quindi chiude il menu */
    }

    /* gestisce l'apertura e chiusura del menu a tendina */
    function toggleDropdown() {
        let currentStyle = window.getComputedStyle(profileActionsDropdown); /* ottiene lo stile css applicato all'elemento*/
        console.log(currentStyle.display);

        /* controlla lo stato attuale della proprietà display */
        switch (currentStyle.display) {
            case "none":
                profileActionsDropdown.style.display = "flex";
                break;
            case "flex":
                profileActionsDropdown.style.display = "none";
                break;
            default:
                profileActionsDropdown.style.display = "none";
                break;
        }
    }

    /* chiude i menu aperti se l'utente clicca in un punto qualsiasi della pagina al di fuori dei menu stessi */
    function closeOnClickOutside(event) {
        /* se il menu mobile è aperto e il punto cliccato (event.target) non è all'interno del menu, chiude il menu*/
        if (mobileNav.style.width === "65%" &&
            !mobileNav.contains(event.target)) {
            closeNav();
        }
        /* simile al primo, controlla se il dropdown è visibile e se il click non è avvenuto nè sul bottone che lo apre, nè sul dropdown stesso. Se è vero, chiude il dropdown*/
        if (profileActionsDropdown.style.display === "flex" &&
            !profileActionsButton.contains(event.target) &&
            !profileActionsDropdown.contains(event.target)) {
            toggleDropdown();
        }
    }

    // Add event listeners for navigation
    // collega le funzioni definite sopra a eventi specifici (in questo caso click dell'utente)
    openNavButton.addEventListener("click", openNav);
    closeNavButton.addEventListener("click", closeNav);
    profileActionsButton.addEventListener("click", toggleDropdown);
    document.addEventListener("click", closeOnClickOutside); // associa la funzione a ogni click effettuato sulla pagina, permettendo la logica di chiusura "esterna"
});


// qui è la logica per il funzionamento della barra di ricerca, simile in ManageProducts.js
const input = document.getElementById('searchBar');
const suggestionBox = document.getElementById('suggestions');
const searchBarWrapper = document.querySelector('.main-header_search-bar');
const contextPath = document.getElementsByTagName("header")[0].dataset.contextPath;

let timeout = null;

input.addEventListener('input', function() {
    clearTimeout(timeout);
    const value = this.value.trim();

    if (value.length === 0) {
        suggestionBox.innerHTML = '';
        suggestionBox.classList.remove('active');
        searchBarWrapper.classList.remove('active');
        return;
    }

    const url = `${contextPath}/SuggestionsServlet?entity=products&query=${encodeURIComponent(value)}`;

    timeout = setTimeout(() => {
        fetch(url)
            .then(response => response.json())
            .then(results => {
                suggestionBox.innerHTML = '';

                if (results.length === 0) {
                    suggestionBox.classList.remove('active');
                    searchBarWrapper.classList.remove('active');
                    return;
                }

                suggestionBox.classList.add('active');
                searchBarWrapper.classList.add('active');

                results.forEach(item => {
                    const div = document.createElement('div');
                    div.textContent = item;
                    div.classList.add('suggestion-item');
                    div.addEventListener('click', () => {
                        input.value = item;
                        suggestionBox.innerHTML = '';
                        suggestionBox.classList.remove('active');
                        searchBarWrapper.classList.remove('active');
                        input.form.submit(); // Submit the form with the selected suggestion
                    });

                    suggestionBox.appendChild(div);
                });
            })
            .catch(error => {
                console.error('Errore:', error);
                suggestionBox.classList.remove('active');
                searchBarWrapper.classList.remove('active');
            });
    }, 300);

});
