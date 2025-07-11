function addToCart() {
    document.querySelectorAll('.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent default form submission

            const formData = new FormData(this); // Collect form data
            const cartcount = document.querySelector('.cart-count');
            const button = this.querySelector('button[type="submit"]');
            const originalIcon = button.innerHTML;
            const stylebutton=button.style.border; // Save original border style

            // Disable button and show loading state
            button.disabled = true;
            button.innerHTML = '<span class="material-symbols-rounded">hourglass_empty</span>';

            fetch(this.action, {
                method: this.method,
                body: new URLSearchParams(formData),
            })
                .then(res => {
                    if (!res.ok) throw new Error('Errore nella richiesta: ' + res.status);

                    return res.json();
                })
                .then(data => {
                    if(data.status === 'ok') {
                        // Show success icon
                        button.innerHTML = '<span class="material-symbols-rounded">check</span>';
                        button.style.backgroundColor = '#4CAF50'; // Green background
                        button.style.border= '2px solid green'; // Remove border

                        // Show notification
                        const notification = document.createElement('div');
                        notification.className = 'cart-notification';
                        notification.innerHTML = `<span>Prodotto aggiunto al carrello!</span>`;
                        document.body.appendChild(notification);

                        setTimeout(() => {
                            notification.classList.add('show');
                        }, 10);

                        setTimeout(() => {
                            notification.classList.remove('show');
                            setTimeout(() => document.body.removeChild(notification), 300);
                        }, 2000);

                        // Update cart counter
                        if(cartcount) {
                            cartcount.textContent = parseInt(cartcount.textContent, 10) + 1;
                        }

                        // Reset button after 2 seconds
                        setTimeout(() => {
                            button.innerHTML = originalIcon;
                            button.style.backgroundColor = ''; // Reset background color
                            button.disabled = false;
                            button.style.border = stylebutton; // Reset border
                        }, 2000);

                    } else {
                        throw new Error('Risposta inaspettata dal server');
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert('Errore durante l\'aggiunta al carrello');

                    // Reset button immediately on error
                    button.innerHTML = originalIcon;
                    button.disabled = false;
                });
        });
    });
}


document.addEventListener('DOMContentLoaded', addToCart); //The function will be called when the listener is added, ensuring that the DOM is fully loaded before executing the function
window.addToCart = addToCart; // Expose function globally if needed //In Js we can call a function before it is defined, so we need to expose it globally if we want to use it in other scripts