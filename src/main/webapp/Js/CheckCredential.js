/**
 * Validates password strength
 */
function checkCredential(password) {
    if (password.length < 8) return false;
    if (password.length > 20) return false;
    if (password.search(/[a-z]/) < 0) return false;
    if (password.search(/[A-Z]/) < 0) return false;
    if (password.search(/[0-9]/) < 0) return false;
    if (password.search(/[$@#&!]/) < 0) return false;
    if (password.search(/[^a-zA-Z0-9$@#&!]/) >= 0) return false;
    return true;
}

function validateEmailField() {
    const emailInput = document.querySelector('input[name="email"]');
    if (!emailInput) return false;
    const email = emailInput.value.trim();
    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email);
}

function validatePasswordField() {
    const passwordInput = document.querySelector('input[name="password"]');
    if (!passwordInput) return false;
    return checkCredential(passwordInput.value);
}

function validatePasswordMatch() {
    const passwordInput = document.querySelector('input[name="password"]');
    const confirmInput = document.querySelector('input[name="confirmPassword"]');
    if (!confirmInput) return true; // Non presente nel login
    return passwordInput.value === confirmInput.value;
}

function validateNameFields() {
    const nameInput = document.querySelector('input[name="name"]');
    const surnameInput = document.querySelector('input[name="surname"]');
    if (!nameInput || !surnameInput) return true; // Non presente nel login
    return nameInput.value.trim() !== "" && surnameInput.value.trim() !== "";
}

function validatePhoneField() {
    const phoneInput = document.querySelector('input[name="phone"]');
    if (!phoneInput) return true; // Non presente nel login
    const phone = phoneInput.value.trim();
    // Validazione base per numero di telefono (almeno 8 cifre)
    const phoneRegex = /^\d{8,15}$/;
    return phoneRegex.test(phone);
}

function togglePassword(iconElement) {
    // Trova l'input password nel contenitore padre
    const passwordInput = iconElement.parentElement.querySelector('input[type="password"], input[type="text"]');
    if (!passwordInput) return;

    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        iconElement.src = iconElement.src.replace('eye.png', 'view.png');
        iconElement.alt = "Nascondi password";
    } else {
        passwordInput.type = "password";
        iconElement.src = iconElement.src.replace('view.png', 'eye.png');
        iconElement.alt = "Mostra password";
    }
}

function showErrors(errors) {
    const form = document.getElementById("loginForm") || document.getElementById("registerForm");
    if (!form) return;

    // Rimuovi container errori precedente
    let errorContainer = document.getElementById("formErrorContainer");
    if (errorContainer) {
        errorContainer.remove();
    }

    if (errors.length > 0) {
        errorContainer = document.createElement("div");
        errorContainer.id = "formErrorContainer";
        errorContainer.style.cssText = `
            color: #fff;
            background-color: #e74c3c;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
            animation: slideDown 0.3s ease-out;
        `;
        errorContainer.innerHTML = errors.join("<br>");

        // Inserisci all'inizio del form
        form.insertBefore(errorContainer, form.firstChild);

        // Scroll smooth verso l'errore
        errorContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });

        // Auto-rimozione dopo 5 secondi
        setTimeout(() => {
            if (errorContainer && errorContainer.parentNode) {
                errorContainer.style.opacity = '0';
                errorContainer.style.transition = 'opacity 0.3s ease-out';
                setTimeout(() => errorContainer.remove(), 300);
            }
        }, 5000);
    }
}

function validateForm() {
    const errors = [];
    const isRegistrationForm = !!document.getElementById("registerForm");

    // Validazione email
    if (!validateEmailField()) {
        errors.push("Email non valida");
    }

    // Validazione password
    if (!validatePasswordField()) {
        errors.push("La password deve contenere tra 8-20 caratteri, almeno una lettera maiuscola, una minuscola, un numero e un carattere speciale ($@#&!)");
    }

    // Validazioni specifiche per la registrazione
    if (isRegistrationForm) {
        // Validazione nome e cognome
        if (!validateNameFields()) {
            errors.push("Inserisci nome e cognome");
        }

        // Validazione telefono
        if (!validatePhoneField()) {
            errors.push("Inserisci un numero di telefono valido (8-15 cifre)");
        }

        // Validazione conferma password
        if (!validatePasswordMatch()) {
            errors.push("Le password non corrispondono");
        }
    }

    // Mostra errori se presenti
    if (errors.length > 0) {
        showErrors(errors);
        return false;
    }

    return true;
}



// Event listeners principali
document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");

    // Setup validazione form
    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    }

    if (loginForm) {
        loginForm.addEventListener("submit", function (event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    }

    // Setup toggle password
    document.querySelector('.auth-form-container__icon-password')
        .addEventListener('click', function () {
            const input = document.getElementById('password')
            if (input) {
                togglePassword(input.name);
            }
        });

});
