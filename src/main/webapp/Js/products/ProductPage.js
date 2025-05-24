document.addEventListener('DOMContentLoaded', () => {
    // Seleziona tutti i caroselli di immagini dei prodotti sulla pagina
    // Questo permette di avere più caroselli indipendenti
    const productCarousels = document.querySelectorAll('.product-card_images');

    productCarousels.forEach(carouselViewport => {
        const slideTrack = carouselViewport.querySelector('.product-card_slider-track');

        if (!slideTrack) {
            console.error("Elemento .product-card_slider-track non trovato dentro:", carouselViewport);
            return; // Salta questo carosello se il track non c'è
        }

        let isDragging = false;
        let startX;
        let scrollLeftStart;

        // --- Eventi Mouse ---
        carouselViewport.addEventListener('mousedown', (e) => {
            isDragging = true;
            // startX è la posizione iniziale del mouse SULLA PAGINA
            startX = e.pageX;
            // scrollLeftStart è quanto il track è già scrollato all'inizio del drag
            scrollLeftStart = slideTrack.scrollLeft;
            carouselViewport.classList.add('active-dragging'); // Per feedback visivo (opzionale)
            // Non preveniamo il default qui per permettere lo scroll verticale se necessario
        });

        carouselViewport.addEventListener('mouseleave', () => {
            // Se il mouse esce dall'area del carosello mentre si trascina, interrompi il drag
            if (isDragging) {
                isDragging = false;
                carouselViewport.classList.remove('active-dragging');
            }
        });

        window.addEventListener('mouseup', () => {
            // Se il pulsante del mouse viene rilasciato ovunque, interrompi il drag
            if (isDragging) {
                isDragging = false;
                carouselViewport.classList.remove('active-dragging');
            }
        });

        window.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            e.preventDefault(); // Previene la selezione del testo durante il drag

            // Posizione corrente del mouse SULLA PAGINA
            const currentX = e.pageX;
            // Di quanto il mouse si è spostato dall'inizio del drag
            const walk = currentX - startX;

            // La nuova posizione di scroll è dove era all'inizio, meno lo spostamento
            // (segno negativo perché scrollLeft aumenta verso destra,
            // ma un drag verso destra dovrebbe mostrare contenuto più a destra, quindi scrollare a sinistra)
            let newScrollLeft = scrollLeftStart - walk;

            // Applica i limiti (non necessario se vuoi lo "snap" ai bordi nativo, ma utile per evitare overscroll visivo strano)
            // const trackWidth = slideTrack.scrollWidth;
            // const viewportWidth = carouselViewport.offsetWidth;
            // const maxScroll = trackWidth - viewportWidth;
            // if (newScrollLeft < 0) newScrollLeft = 0;
            // if (newScrollLeft > maxScroll && maxScroll > 0) newScrollLeft = maxScroll;


            slideTrack.scrollLeft = newScrollLeft;
        });

        // --- Eventi Touch (per mobile) ---
        carouselViewport.addEventListener('touchstart', (e) => {
            isDragging = true;
            startX = e.touches[0].pageX;
            scrollLeftStart = slideTrack.scrollLeft;
            carouselViewport.classList.add('active-dragging');
            // Potrebbe essere necessario un event.preventDefault() qui se lo swipe
            // interferisce con lo scroll verticale della pagina in modo indesiderato,
            // ma fai attenzione perché potrebbe bloccare anche lo scroll verticale intenzionale.
        }, { passive: true }); // { passive: true } può aiutare con la performance dello scroll

        window.addEventListener('touchend', () => {
            if (isDragging) {
                isDragging = false;
                carouselViewport.classList.remove('active-dragging');
            }
        });

        window.addEventListener('touchmove', (e) => {
            if (!isDragging) return;
            // e.preventDefault(); // Decommenta con cautela, vedi nota sopra

            const currentX = e.touches[0].pageX;
            const walk = currentX - startX;
            // Potresti voler aggiungere i limiti anche qui come per mousemove
            // const trackWidth = slideTrack.scrollWidth;
            // const viewportWidth = carouselViewport.offsetWidth;
            // const maxScroll = trackWidth - viewportWidth;
            // if (newScrollLeft < 0) newScrollLeft = 0;
            // if (newScrollLeft > maxScroll && maxScroll > 0) newScrollLeft = maxScroll;

            slideTrack.scrollLeft = scrollLeftStart - walk;
        }, { passive: false }); // { passive: false } se usi e.preventDefault()
    });
});