document.addEventListener('DOMContentLoaded', () => {

    //contenitore principale di tutta la galleria
    const sliderContainer = document.querySelector('.product-card_gallery');
    // Se non c'è uno slider in questa pagina, esci per non causare errori.
    if (!sliderContainer) {
        return;
    }

    //il container interno che avrà tutte le immagini affiancate e verrà spostato a sx e dx
    const sliderTrack = sliderContainer.querySelector('.product-card_gallery-track');
    //array di singole immagini
    const slides = Array.from(sliderTrack.children);
    //frecce per andare avanti e indietro
    const nextButton = sliderContainer.querySelector('.product-card_arrow--next');
    const prevButton = sliderContainer.querySelector('.product-card_arrow--prev');
    //contenitore dei pallini di navigazione
    const dotsNav = sliderContainer.querySelector('.product-card_gallery-dots');

    // Se non ci sono slide, non fare nulla
    if (slides.length === 0) {
        return;
    }

    // Se c'è solo una o nessuna immagine, nascondere la navigazione.
    if (slides.length <= 1) {
        if(nextButton) nextButton.style.display = 'none';
        if(prevButton) prevButton.style.display = 'none';
        if(dotsNav) dotsNav.style.display = 'none';
        return;
    }

    // --- SETUP INIZIALE ---
    //calcola la latghezza esatta della prima slide
    const slideWidth = slides[0].getBoundingClientRect().width;
    let currentIndex = 0;

    // Creiamo i pallini di navigazione
    dotsNav.innerHTML = ''; // Pulisci eventuali pallini esistenti
    slides.forEach((_, index) => {
        //a ogni bottone/pallino viene aggiunto un evento click che chiama la funzione per spostarsi direttamente a quella slide.
        const button = document.createElement('button');
        button.classList.add('slider-nav--dot');
        button.addEventListener('click', () => {
            moveToSlide(index);
        });
        dotsNav.appendChild(button);
    });
    const dots = Array.from(dotsNav.children);

    // --- FUNZIONI PRINCIPALI ---

    // Funzione centrale per muovere lo slider a un indice specifico
    const moveToSlide = (targetIndex) => {
        // Applica la transizione CSS per un movimento fluido
        sliderTrack.style.transition = 'transform 0.5s ease-in-out';

        //calcola la distanza totale da spostare
        const amountToMove = targetIndex * slideWidth;
        //applica lo spostamento
        sliderTrack.style.transform = `translateX(-${amountToMove}px)`;

        // Aggiorna lo stato corrente
        currentIndex = targetIndex;

        // Aggiorna la UI (frecce e pallini)
        updateNav();
    };

    // Funzione per aggiornare lo stato visivo delle frecce e dei pallini
    const updateNav = () => {
        // Gestione delle frecce
        //se siamo sulla prima slide, nasconde la freccia "indietro"
        prevButton.classList.toggle('is-hidden', currentIndex === 0);
        //se siamo all'ultima slide, nasconde la freccia "avanti"
        nextButton.classList.toggle('is-hidden', currentIndex === slides.length - 1);

        // Gestione dei pallini
        dots.forEach((dot, index) => {
            //evidenzia il pallino corrispondente alla slide corrente
            //togliendo l'evidenziazione a tutti gli altri
            dot.classList.toggle('current-slide', index === currentIndex);
        });
    };

    // --- GESTIONE EVENTI FRECCE ---
    //quando si clicca "avanti" chiama moveToSlide con l'indice successivo
    nextButton.addEventListener('click', () => {
        if (currentIndex < slides.length - 1) {
            moveToSlide(currentIndex + 1);
        }
    });

    //quanso si clicca "indietro" chiama moveToSlide con l'indice precedente
    prevButton.addEventListener('click', () => {
        if (currentIndex > 0) {
            moveToSlide(currentIndex - 1);
        }
    });

    // --- LOGICA PER LO SWIPE (TOUCH E MOUSE) ---
    let isDragging = false;
    let startPos = 0;
    let currentTranslate = 0;

    const getPositionX = (event) => {
        return event.type.includes('mouse') ? event.pageX : event.touches[0].clientX;
    };

    //quando l'utente inizia a trascinare
    const dragStart = (event) => {
        isDragging = true;
        //registra la posizione iniziale del cursore
        startPos = getPositionX(event);
        // Rimuovi la transizione CSS durante il drag per un movimento immediato
        sliderTrack.style.transition = 'none';
    };

    //mentre l'utente trascina
    const dragMove = (event) => {
        if (isDragging) {
            const currentPosition = getPositionX(event);
            // Calcola lo spostamento rispetto all'inizio del drag
            const dragOffset = currentPosition - startPos;
            // La nuova posizione è la posizione della slide corrente più lo spostamento
            currentTranslate = (currentIndex * -slideWidth) + dragOffset;
            //aggiorna la posizione dello sliderTrack in tempo reale per farlo
            //corrispondere al movimento
            sliderTrack.style.transform = `translateX(${currentTranslate}px)`;
        }
    };

    //quando l'utente smette di trascinare
    const dragEnd = (event) => {
        if (!isDragging) return;
        isDragging = false;

        //calcola quanto è lungo lo swipe
        const movedBy = currentTranslate - (currentIndex * -slideWidth);
        const swipeThreshold = slideWidth * 0.2; // Soglia: 20% della larghezza della slide

        // se lo swipe ha superato la soglia, si sposterà alla pagina successiva/precedente
        //altrimenti moveToSlide riporterà la slide alla sua posizione originale
        if (movedBy < -swipeThreshold && currentIndex < slides.length - 1) {
            // Swipe a sinistra -> vai alla prossima slide
            moveToSlide(currentIndex + 1);
        } else if (movedBy > swipeThreshold && currentIndex > 0) {
            // Swipe a destra -> vai alla slide precedente
            moveToSlide(currentIndex - 1);
        } else {
            // Swipe non sufficiente, torna alla slide corrente con animazione
            moveToSlide(currentIndex);
        }
    };

    // Aggiungi event listeners al contenitore principale dello slider
    sliderTrack.addEventListener('mousedown', dragStart);
    sliderTrack.addEventListener('touchstart', dragStart, { passive: true });

    document.addEventListener('mousemove', dragMove);
    document.addEventListener('touchmove', dragMove, { passive: true });

    document.addEventListener('mouseup', dragEnd);
    document.addEventListener('touchend', dragEnd);

    // Prevenire il comportamento di default del drag delle immagini che può interferire
    slides.forEach(slide => {
        slide.querySelector('img').addEventListener('dragstart', (e) => e.preventDefault());
    });

    // --- INIZIALIZZAZIONE ---
    updateNav(); // Imposta lo stato iniziale corretto per frecce e pallini
});

// Funzione per sincronizzare la quantità selezionata con tutti i form
function copyQuantity() {
    const selectedQuantity = document.getElementById('quantity').value;

    // Aggiorna il campo per il carrello
    const cartQuantity = document.getElementById('cartQuantity');
    if (cartQuantity) {
        cartQuantity.value = selectedQuantity;
    }

    // Aggiorna il campo per "Acquista Ora" (utenti non loggati)
    const buyNowQuantityGuest = document.getElementById('buyNowQuantityGuest');
    if (buyNowQuantityGuest) {
        buyNowQuantityGuest.value = selectedQuantity;
    }

    // Aggiorna il campo per "Acquista Ora" (utenti loggati)
    const buyNowQuantityUser = document.getElementById('buyNowQuantityUser');
    if (buyNowQuantityUser) {
        buyNowQuantityUser.value = selectedQuantity;
    }
}
