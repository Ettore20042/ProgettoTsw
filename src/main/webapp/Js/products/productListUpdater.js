// Funzioni per aggiornare la griglia dei prodotti nella lista utente

/**
 * Aggiorna la griglia dei prodotti con i risultati del filtro
 * @param {Array} products - Array di prodotti da mostrare
 */
function updateProductList(products) {
    const productListContainer = document.querySelector('.product-list_cards');
    productListContainer.innerHTML = '';

    if (!productListContainer) {
        console.error('Container productCard non trovato');
        return;
    }

    if (products.length === 0) {
        console.error('Lista prodotti vuota!');
        showNoProductsMessage(productListContainer)
        return;
    }

    // Genera HTML per ogni prodotto
    productListContainer.innerHTML = products.map(product => createProductCardHTML(product)).join('');

    // Reinizializza eventuali script per le card prodotti
    // initProductCardEvents();
}

/**
 * Crea l'HTML per una singola card prodotto
 * @param {Object} product - Dati del prodotto
 * @returns {string} HTML della card prodotto
 */
function createProductCardHTML(product) {
    const contextPath = document.body.dataset.contextPath;
    const salePrice = product.salePrice > 0 ? product.salePrice : null;
    const originalPrice = product.price > 0 ? product.price : null;

    let priceHTML = salePrice > 0
        ? `<p class="product-card_price--sale">${salePrice.toLocaleString('en-US', {style: 'currency', currency: 'EUR'})}</p>
            <p class="product-card_price--original-in-sale">${originalPrice.toLocaleString('en-US', {style: 'currency', currency: 'EUR'})}</p>`
        : `<p class="product-card_price--original">${originalPrice.toLocaleString('en-US', {style: 'currency', currency: 'EUR'})}</p>`;

    let availableHTML = product.quantity > 0
        ? `<p class="product-card_stock-status--available">Disponibilità immediata</p>
            <form action="${contextPath}/CartServlet" class="add-to-cart-form" data-product-id="${product.productId}" method="post" style="display: contents;">
                <input type="hidden" name="productId" value="${product.productId}" />
                <input type="hidden" name="quantity" value="1" />
                <button type="submit" class="product-card_button product-card_button--add-to-cart-icon">
                    <span class="material-symbols-rounded">shopping_cart</span>
                </button>
            </form>`
        : `<p class="product-card_stock-status--not-available">Non disponibile momentaneamente</p>`;



    return `
        <section class="product-card">
        <a href="${contextPath}/ProductServlet?productId=${product.productId}" class="product-card_link">
            <div class="product-card_gallery">
                <div class="product-card_gallery-item">
                    <img src="${contextPath}/ImageServlet?productId=${product.productId}" alt="Image of ${product.productName}" class="product-card_image">
                </div>
            </div>
            <div class="product-card_header-info">
                <h2 class="product-card_brand">${product.brand.brandName}</h2>
                <h1 class="product-card_name">${product.productName}</h1>
            </div>
        </a>

        <div class="product-card_details">
            <div class="product-card_price">`
                + priceHTML +
            `</div>`
            + availableHTML +
        `</div>
    </section>
    `;
}

/**
 * Mostra il messaggio quando non ci sono prodotti
 * @param {HTMLElement} container - Container dei prodotti
 */
function showNoProductsMessage(container) {
    container.innerHTML = `
        <div class="no-products-message">
            <h3>Nessun prodotto trovato</h3>
            <p>Prova a modificare i filtri di ricerca</p>
        </div>
    `;
}

// Inizializzazione per la pagina lista prodotti
document.addEventListener('DOMContentLoaded', function() {
    // Ora initFilterEvents è esposta tramite window.ProductFilter
    if (window.ProductFilter && window.ProductFilter.initFilterEvents) {
        console.log('🔗 Collegamento filtri con aggiornatore lista prodotti...');
        window.ProductFilter.initFilterEvents(updateProductList);
    } else {
        console.error('❌ ProductFilter non disponibile - assicurati che productFilter.js sia caricato prima');
    }
});
// Improved cart form handling


