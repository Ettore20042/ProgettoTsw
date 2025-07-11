
// Funzioni di scroll rinominate per evitare conflitti con proprietà DOM native
    function scrollToLeft() {
    const container = document.getElementById('featured');
    if (container) {
    container.scrollBy({ //sposta la la visuale del contenitore di una quantità relativa alla posizione attuale
    left: -300,
    behavior: 'smooth' //scorrimento con animazione fluida invece che uno scatto istantaneo
});
    // Aggiorna lo stato dei pulsanti dopo lo scroll
    setTimeout(() => updateButtonsState(), 100);
}
}

    function scrollToRight() {
    const container = document.getElementById('featured');
    if (container) {
    container.scrollBy({
    left: 300,
    behavior: 'smooth'
});
    // Aggiorna lo stato dei pulsanti dopo lo scroll
    setTimeout(() => updateButtonsState(), 100);
}
}

    // Funzione per aggiornare lo stato dei pulsanti
    function updateButtonsState() {
    //seleziona il contenitore e i due pulsanti
    const container = document.getElementById('featured');
    const scrollLeftBtn = document.querySelector('.scroll-button.left');
    const scrollRightBtn = document.querySelector('.scroll-button.right');

    if (!container || !scrollLeftBtn || !scrollRightBtn) return;

    // Ottiene tre proprietà importanti per la logica di scorrimento
    const scrollLeft = container.scrollLeft;
    const scrollWidth = container.scrollWidth;
    const clientWidth = container.clientWidth;



    // Disabilita il pulsante sinistro se siamo all'inizio
    scrollLeftBtn.disabled = scrollLeft <= 0;

    // Disabilita il pulsante destro se siamo alla fine
    scrollRightBtn.disabled = scrollLeft + clientWidth >= scrollWidth - 1;
}

    // Inizializza quando il documento è pronto
    document.addEventListener('DOMContentLoaded', function() {
    const container = document.getElementById('featured');

    if (container) {
    // Inizializza lo stato dei pulsanti
    setTimeout(() => updateButtonsState(), 300);

    // Aggiungi listener per gli scroll manuali
    //la funzione viene chiamata ovni volta che l'utente scrolla il contenitore manualmente. Senza di esso i pulsanti si aggiornerebbero solo quando vengono cliccati
    container.addEventListener('scroll', function() {
    updateButtonsState();
});
}
});

