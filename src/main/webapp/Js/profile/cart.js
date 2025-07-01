document.addEventListener('DOMContentLoaded', function() {
    // --- Quantity Update ---
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function() {
            const productId = this.dataset.productId;
            const quantity = parseInt(this.value);
            const price = parseFloat(this.dataset.price);
            const form = this.closest('.quantity-form');

            if (quantity < 1) {
                this.value = 1; // Ensure minimum quantity is 1
            }

            updateRowTotal(this, quantity, price);
            updateCartTotal();

            if (form) {
                const formData = new URLSearchParams();
                formData.append('productId', productId);
                formData.append('action', 'update');
                formData.append('quantity', this.value);

                fetch(form.action, {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                })
                    .catch(error => {
                        console.error('Error updating quantity:', error);
                    });
            }
        });
    });

    // --- Remove Item ---
    //  For AJAX removal (if you want to prevent page reload)
    fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
        /*(async response => { // Verifica il tipo di contenuto dalla risposta per assicurarsi che sia JSON const contentType = response.headers.get("content-type");
         // Legge il corpo della risposta come testo per debug e parsing const text = await response.text();
          console.log("Raw response:", text);*/
        .then(async response => {
            const contentType = response.headers.get("content-type");
            const text = await response.text();
            console.log("Raw response:", text);

            if (contentType && contentType.includes("application/json")) {
                return JSON.parse(text);
            } else {
                throw new Error("Response is not JSON:\n" + text);
            }
        })
        .then(data => {
            if (data.success) {
                const cartRow = this.closest('.cart-row');
                if (cartRow) {
                    cartRow.remove();
                    updateCartTotal();
                }
            } else {
                console.error('Error removing item:', data.error);
            }
        })
        .catch(error => {
            console.error('Error removing item:', error);
        });



    function updateRowTotal(inputElement, quantity, price) {
        const row = inputElement.closest('.cart-row');
        if (row) {
            const totalElement = row.querySelector('.total-value');
            if (totalElement) {
                const total = quantity * price;
                totalElement.textContent = '€ ' + total.toFixed(2);
            }
        }
    }

    function updateCartTotal() {
        let grandTotal = 0;
        document.querySelectorAll('.cart-row').forEach(row => {
            const totalValueElement = row.querySelector('.total-value');
            if (totalValueElement) {
                // More robust parsing that handles both commas and periods as decimal separators
                const itemTotalText = totalValueElement.textContent
                    .replace('€', '')
                    .replace(/\s/g, '')
                    .trim();

                // Replace comma with period for proper parsing in JavaScript
                const cleanedValue = itemTotalText.replace(',', '.');

                // Parse the value and add to total, defaulting to 0 if parsing fails
                const value = parseFloat(cleanedValue);
                grandTotal += isNaN(value) ? 0 : value;
            }
        });

        const cartTotalElement = document.querySelector('.cart-total-value');
        if (cartTotalElement) {
            cartTotalElement.textContent = '€ ' + grandTotal.toFixed(2);
        }
    }

    // Initial cart total calculation on page load
    updateCartTotal();
});