// Funzioni per aggiornare la tabella di gestione prodotti admin

/**
 * Aggiorna la tabella dei prodotti con i risultati del filtro
 * @param {Array} products - Array di prodotti da mostrare
 */
function updateProductTable(products) {
    const tableBody = document.querySelector('.componentTableBody');
    tableBody.innerHTML = '';

    if (!tableBody) {
        console.error('Tabella prodotti admin non trovata');
        return;
    }

    if (products.length === 0) {
        showNoProductsRow(tableBody);
        return;
    }

    // Genera righe della tabella per ogni prodotto
    tableBody.innerHTML = products.map(product => createProductRowHTML(product)).join('');

    const manager = window.getCurrentManager(); // Assicurati che getCurrentManager sia definito e restituisca l'istanza corretta
    if (manager && typeof manager.initializeEditLinks === 'function' && typeof manager.initializeRemoveButtons === 'function') {
        /*
        *Controlla se la variabile manager esiste ed è definita
        *Controlla se la proprietà initializeEditLinks di manager esiste ed è una funzione.
        *
        * */

        manager.initializeEditLinks();
        manager.initializeRemoveButtons();
    } else {
        console.error('Manager non trovato o non dispone dei metodi necessari per reinizializzare gli eventi.');
    }
}

/**
 * Crea l'HTML per una riga della tabella prodotti admin
 * @param {Object} product - Dati del prodotto
 * @returns {string} HTML della riga della tabella
 */
function createProductRowHTML(product) {
    const contextPath = document.body.dataset.contextPath;

    return `
        <tr>
            <td>${product.productId}</td>
            <td>${product.productName}</td>
            <td>${product.price}</td>
            <td>${product.color}</td>
            <td>${product.quantity}</td>
            <td><a href="#" class="edit-link" data-product-id="${product.productId}">Modifica</a></td>
            <td><button type="submit" class="remove-button-product remove-item-btn" data-id="${product.productId}" >
                <img src="${contextPath}/img/icon/delete.png" class="remove-icon">
            </button></td>
        </tr>
    `;
}

/**
 * Mostra riga quando non ci sono prodotti
 * @param {HTMLElement} tableBody - Body della tabella
 */
function showNoProductsRow(tableBody) {
    //si prende il numero di colonne
    const columnsCount = document.querySelectorAll('.admin-products-table thead th').length || 9;
    //crea una riga che si espande lungo tutta l'intestazione
    tableBody.innerHTML = `
        <tr class="no-products-row">
            <td colspan="${columnsCount}" class="text-center">
                <div class="no-products-message">
                    <h4>Nessun prodotto trovato</h4>
                    <p>Modifica i filtri per visualizzare altri prodotti</p>
                </div>
            </td>
        </tr>
    `;
}

/**Registra una funzione che viene eseguita quando il DOM è completamente carico
 * Controlla se la variabile ProductFilter esiste e se ha il metodo initFilterEvents
 * Chiama initFilterEvents passando la funzione updateProductTable come callback
 *
 * */
// Inizializzazione per la pagina di gestione admin
document.addEventListener('DOMContentLoaded', function() {
    if (window.ProductFilter && window.ProductFilter.initFilterEvents) {
        console.log(' Collegamento filtri con aggiornatore lista prodotti...');
        window.ProductFilter.initFilterEvents(updateProductTable);
    } else {
        console.error('ProductFilter non disponibile - assicurati che productFilter.js sia caricato prima');
    }
});
