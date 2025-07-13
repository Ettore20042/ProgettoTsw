// Wrappa tutto il codice del filtro in una funzione auto-invocante per evitare conflitti globali
(function() {
    'use strict';

    // ========================================
    // VARIABILI E CONFIGURAZIONE
    // ========================================

    let filterData = null; // Cache per i dati dei filtri
    const contextPath = document.body.dataset.contextPath || '';

    // ========================================
    // SEZIONE 1: CARICAMENTO INIZIALE DEI DATI
    // ========================================

    /**
     * Carica i dati iniziali per i filtri (brand, colori, materiali, prezzo max)
     * @returns {Promise<Object>} Dati dei filtri
     */
    async function loadFilterData() {
        if (filterData) {
            return filterData; // Usa la cache se già caricata
        }

        try {
            console.log(' Caricamento dati filtri...');
            //chiediamo al server di inviarci tutti le opzioni per i filtri
            const response = await fetch(`${contextPath}/FilterServlet?action=loadData`);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            //usiamo questa variabile per mettere in cache i dati
            filterData = await response.json();
            console.log('Dati filtri caricati:', filterData);
            return filterData;

        } catch (error) {
            console.error(' Errore nel caricamento dei dati filtri:', error);
            throw error;
        }
    }

    /**
     * Popola il filtro brand con i dati ricevuti dal server
     * @param {Object} brands - Mappa dei brand {id: {brandName: "..."}}
     */
    function populateBrandFilter(brands) {
        const brandList = document.querySelector('.product-filter_list-brand');
        const brandIdPage = document.body.dataset.brandId;
        if (!brandList || !brands) {
            console.warn('Brand filter container non trovato o dati brand mancanti');
            return;
        }

        console.log(' Popolamento filtro brand...');
        brandList.innerHTML = '';

        Object.entries(brands).forEach(([id, brand]) => {
            const li = document.createElement('li');
            li.classList.add('product-filter_list-item');

            // Verifica se questo brand corrisponde al brandIdPage
            const isCurrentBrand = brandIdPage && id === brandIdPage;
            const checkedAttribute = isCurrentBrand ? 'checked' : '';

            li.innerHTML = `
                
                <input type="checkbox" name="brand" id="brand_${id}" value="${id}"
                       class="product-filter_checkbox" data-brand-id="${id}" ${checkedAttribute}>
                <label for="brand_${id}" class="product-filter_label">${brand.brandName}</label>
            `;
            brandList.appendChild(li);
        });

        console.log(` Popolati ${Object.keys(brands).length} brand`);
    }

    /**
     * Popola il filtro colori con i dati ricevuti dal server
     * @param {Array} colors - Array di stringhe colori ["rosso", "blu", ...]
     */
    function populateColorFilter(colors) {
        const colorList = document.querySelector('.product-filter_list-color')

        if (!colorList || !colors || colors.length === 0) {
            console.warn('Color filter container non trovato o dati colori mancanti');
            return;
        }

        console.log(' Popolamento filtro colori...');
        colorList.innerHTML = '';

        colors.forEach((color, index) => {
            const li = document.createElement('li');
            li.classList.add('product-filter_list-item');
            li.innerHTML = `
                <input type="checkbox" name="color" id="color_${index}" value="${color}"
                       class="product-filter_checkbox" data-color-id="${color}">
                <label for="color_${index}" class="product-filter_label">${color}</label>
            `;
            colorList.appendChild(li);
        });

        console.log(` Popolati ${colors.length} colori`);
    }

    /**
     * Popola il filtro materiali con i dati ricevuti dal server
     * @param {Array} materials - Array di stringhe materiali ["legno", "metallo", ...]
     */
    function populateMaterialFilter(materials) {
        const materialsList = document.querySelector('.product-filter_list-material')

        if (!materialsList || !materials || materials.length === 0) {
            console.warn(' Material filter container non trovato o dati materiali mancanti');
            return;
        }

        console.log(' Popolamento filtro materiali...');
        materialsList.innerHTML = '';

        materials.forEach((material, index) => {
            const li = document.createElement('li');
            li.classList.add('product-filter_list-item');
            li.innerHTML = `
                <input type="checkbox" name="material" id="material_${index}" value="${material}"
                       class="product-filter_checkbox" data-material-id="${material}">
                <label for="material_${index}" class="product-filter_label">${material}</label>
            `;
            materialsList.appendChild(li);
        });

        console.log(`Popolati ${materials.length} materiali`);
    }

    /**
     * Imposta il filtro prezzo con il valore massimo
     * @param {number} maxPrice - Prezzo massimo dai dati del server
     */
    function setupPriceFilter(maxPrice) {
        const priceMin = document.getElementById('price-min');
        const priceMax = document.getElementById('price-max');
        // const priceRange = document.querySelector('.product-filter_price-range');
        const priceRangeValue = document.querySelector('.product-filter_price-range-value');

        console.log(' Configurazione filtro prezzo, max:', maxPrice);

        if (priceMax) {
            priceMax.placeholder = maxPrice;
            priceMax.max = maxPrice;
            priceMax.value = maxPrice; // Imposta il valore massimo come predefinito
        }

        const priceDinamicRange = () => {
            if (priceMin && priceMax) {
                const min = priceMin.value || 0;
                const max = priceMax.value || maxPrice;

                // Aggiorna il range dinamicamente
                if (priceRangeValue) {
                    priceRangeValue.textContent = `Prezzo: ${min} - ${max}`;
                }
            }
        }

        priceMin.addEventListener('input', priceDinamicRange);
        priceMax.addEventListener('input', priceDinamicRange);
        console.log(' Filtro prezzo configurato');
    }

    /**
     * Gestisce l'apertura e la chiusura del pannello dei filtri
     * su dispositivi mobili
     */

    function setupToggleFilterSideView() {
        const openButtons = document.querySelectorAll('.product-filter_open-btn');
        const closeButton = document.getElementById("close-filter-btn");
        const mediaQueryDesktop = window.matchMedia('(min-width: 992px)');
        const applyButton = document.querySelector('.product-filter_apply');
        const filterMobileWrapper = document.querySelector('.product-filter_mobile-wrapper');

        openButtons.forEach( button => {
            button.addEventListener('click', (e) => {
                e.stopPropagation();
                filterMobileWrapper.style.width = '100%';
                filterMobileWrapper.style.transition = '0.3s';
                document.body.classList.add('no-scroll'); // Aggiungi classe per disabilitare lo scroll del body
            });
        })

        closeButton.addEventListener('click', (e) => {
            e.stopPropagation();
            filterMobileWrapper.style.width = '0';
            filterMobileWrapper.style.transition = '0.3s';
            document.body.classList.remove('no-scroll'); // Rimuovi classe per abilitare lo scroll del body
        });

        //per gestire il comportamento in base alla larghezza dello schermo
        applyButton.addEventListener('click', (e) => {
            if (!mediaQueryDesktop.matches){
                e.stopPropagation();
                filterMobileWrapper.style.width = '0';
                filterMobileWrapper.style.transition = '0.3s';
                document.body.classList.remove('no-scroll'); // Rimuovi classe per abilitare lo scroll del body
            }
        })

        mediaQueryDesktop.addEventListener('change', (e) => {// Rileva il cambiamento della media query
            if (mediaQueryDesktop.matches){
                e.stopPropagation();
                filterMobileWrapper.style.width = '100%';
            } else {
                e.stopPropagation();
                filterMobileWrapper.style.width = '0';
                document.body.classList.remove('no-scroll'); // Rimuovi classe per abilitare lo scroll del body
            }
        })
    }


    /**
     * Inizializza tutti i filtri con i dati caricati dal server
     */
    async function initializeFilters() {
        try {
            console.log(' Inizializzazione filtri...');
            //ottiene prima i dati e poi, una volta ricevuti, chiama le varie funzioni
            //per costruire l'interfaccia dei filtri
            const data = await loadFilterData();

            // Popola tutti i filtri in parallelo per migliori performance
            populateBrandFilter(data.brands);
            populateColorFilter(data.colors);
            populateMaterialFilter(data.materials);
            setupPriceFilter(data.priceMax);
            setupToggleFilterSideView();

            console.log(' Filtri inizializzati con successo!');

        } catch (error) {
            console.error(' Errore nell inizializzazione dei filtri:', error);
            showErrorMessage('Errore nel caricamento dei filtri. Ricarica la pagina.');
        }
    }

    // ========================================
    // SEZIONE 2: GESTIONE RICHIESTE DI FILTRAGGIO
    // ========================================

    /**
     * Raccoglie tutti i dati dei filtri dai form selezionati dall'utente
     * @returns {Object} Oggetto con i parametri dei filtri
     */
    function collectFilterData() {
        //scorre tutte le checkbox e raccoglie i valori di quelle selezionate
        const brands = Array.from(document.querySelectorAll('input[name="brand"]:checked'))
            .map(input => input.value);

        const colors = Array.from(document.querySelectorAll('input[name="color"]:checked'))
            .map(input => input.value);

        const materials = Array.from(document.querySelectorAll('input[name="material"]:checked'))
            .map(input => input.value);

        // const categoryId = document.querySelector('input[name="categoryId"]')?.value;
        const categoryId = document.body.dataset.categoryId;
        const offersParam = document.body.dataset.offersPage;
        const minPrice = document.querySelector('.product-filter_price-min')?.value;
        const maxPrice = document.querySelector('.product-filter_price-max')?.value;

        //restituisce un oggetto contenente tutte le scelte dell'utente
        const filterData = {
            brands,
            colors,
            materials,
            categoryId,
            offersParam,
            minPrice,
            maxPrice
        };

        console.log(' Dati filtri raccolti:', filterData);
        return filterData;
    }

    /**
     * Costruisce l'URL con i parametri per la FilterServlet
     * @param {Object} filterData - Dati dei filtri raccolti dall'utente
     * @returns {string} URL completo con parametri di query
     */
    function buildFilterUrl(filterData) {
        const params = new URLSearchParams();

        // Aggiungi parametri multipli (array)
        filterData.brands.forEach(brand => params.append('brandId', brand));
        filterData.colors.forEach(color => params.append('color', color));
        filterData.materials.forEach(material => params.append('material', material));

        // Aggiungi parametri singoli se presenti
        if (filterData.categoryId) params.append('categoryId', filterData.categoryId);
        if (filterData.offersParam) params.append('offers', filterData.offersParam);
        if (filterData.minPrice && filterData.minPrice.trim()) params.append('minPrice', filterData.minPrice);
        if (filterData.maxPrice && filterData.maxPrice.trim()) params.append('maxPrice', filterData.maxPrice);

        const url = `${contextPath}/FilterServlet?${params.toString()}`;
        console.log(' URL filtro costruito:', url);

        return url;
    }

    /**
     * Esegue la chiamata AJAX alla FilterServlet per ottenere i prodotti filtrati
     * @param {Object} filterData - Dati dei filtri dell'utente
     * @returns {Promise<Array>} Promise con i prodotti filtrati
     */
    async function fetchFilteredProducts(filterData) {
        try {
            console.log(' Ricerca prodotti con filtri...');
            const url = buildFilterUrl(filterData);
            const response = await fetch(url);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const products = await response.json();
            console.log(` Trovati ${products.length} prodotti`);
            return products;

        } catch (error) {
            console.error(' Errore nel caricamento dei prodotti:', error);
            throw error;
        }
    }

    /**
     * Applica i filtri selezionati dall'utente e aggiorna l'interfaccia
     * @param {Function} updateCallback - Funzione per aggiornare l'UI specifica (griglia o tabella)
     */
    async function applyFilters(updateCallback) {
        try {
            console.log('Applicazione filtri...');

            const filterData = collectFilterData();
            const products = await fetchFilteredProducts(filterData);

            if (typeof updateCallback === 'function') {
                updateCallback(products);
                console.log(' UI aggiornata con i risultati');
            } else {
                console.warn(' Callback di aggiornamento UI non fornito');
            }

        } catch (error) {
            console.error(' Errore nell\'applicazione dei filtri:', error);
            showErrorMessage('Errore nella ricerca. Riprova.');
        }
    }

    // ========================================
    // SEZIONE 3: GESTIONE EVENTI E UTILITY
    // ========================================

    /**
     * Inizializza gli event listener per i controlli dei filtri
     * @param {Function} updateCallback - Funzione per aggiornare l'UI quando si applicano i filtri
     */
    function initFilterEvents(updateCallback) {
        console.log(' Inizializzazione event listeners...');

        // Event listener per il pulsante "Applica filtri"
        const applyButton = document.querySelector('.product-filter_apply');
        if (applyButton) {
            applyButton.addEventListener('click', () => {
                console.log(' Click su "Applica filtri"');
                applyFilters(updateCallback);

            });
        } else {
            console.warn('Pulsante "Applica filtri" non trovato');
        }

        // Event listener per i pulsanti "Ripristina"
        document.querySelectorAll('.product-filter_details-reset, .product-filter_reset-all').forEach(button => {
            button.addEventListener('click', (e) => {
                console.log(' Reset sezione filtro');
                if (button.classList.contains('product-filter_reset-all')) {
                    // --- LOGICA PER CANCELLARE TUTTI I FILTRI ---
                    console.log(' Reset di tutti i filtri');
                    const filterContainer = button.closest('.product-filter_wrapper') || document; // Trova il contenitore principale dei filtri se non esiste usa il document come valore di fallback

                    // Deseleziona tutte le checkbox
                    const allCheckboxes = filterContainer.querySelectorAll('input[type="checkbox"]');
                    allCheckboxes.forEach(cb => cb.checked = false);

                    // Resetta i campi prezzo
                    const priceMin = filterContainer.querySelector('#price-min');
                    const priceMax = filterContainer.querySelector('#price-max');
                    if (priceMin) priceMin.value = '0';
                    if (priceMax) priceMax.value = priceMax.max || parseFloat(priceMax.placeholder) || 0;

                    // Aggiorna il display del range prezzo
                    const priceRangeValue = filterContainer.querySelector('.product-filter_price-range-value');
                    if (priceRangeValue && priceMax) {
                        priceRangeValue.textContent = `Prezzo: 0 - ${priceMax.placeholder || 0}`;
                    }

                } else {
                    // --- LOGICA ESISTENTE PER RIPRISTINARE UNA SEZIONE ---
                    console.log('Reset sezione filtro');
                    const detailsBox = e.target.closest('.product-filter_details-box');
                    if (!detailsBox) return;

                    // Deseleziona tutte le checkbox nella sezione
                    const checkboxes = detailsBox.querySelectorAll('input[type="checkbox"]');
                    checkboxes.forEach(cb => cb.checked = false);

                    // Resetta tutti gli input numerici e range nella sezione
                    const priceMin = detailsBox.querySelector('#price-min');
                    const priceMax = detailsBox.querySelector('#price-max');
                    if (priceMin) priceMin.value = '0';
                    if (priceMax) priceMax.value = priceMax.max || parseFloat(priceMax.placeholder) || 0;

                    // Se c'è un range slider del prezzo, aggiorna anche il display
                    const priceRangeValue = detailsBox.querySelector('.product-filter_price-range-value');
                    if (priceRangeValue) {
                        priceRangeValue.textContent = `Prezzo: 0 - ${priceMax.placeholder || 0}`;
                    }
                }
                applyFilters(updateCallback);
            });
        });

        console.log(' Event listeners configurati');
    }



    /**
     * Mostra un messaggio di errore all'utente
     * @param {string} message - Messaggio da mostrare
     */
    function showErrorMessage(message) {

        console.error('Errore UI:', message);
        alert(message);
    }



    // ========================================
    // SEZIONE 4: INIZIALIZZAZIONE E API PUBBLICA
    // ========================================

    /**
     * Inizializzazione automatica quando il DOM è pronto
     */
    document.addEventListener('DOMContentLoaded', () => {
        initializeFilters();
    });

    /**
     * API pubblica del modulo filtri
     * Espone solo le funzioni necessarie per l'uso esterno
     */
    window.ProductFilter = {
        // Funzioni per l'interazione esterna
        initFilterEvents,
    };
})();
