/**
 * Validates password strength
 */

//controlliamo i dati inseriti dall'utente direttamente nel browser, prima che il form venga inviato al server

//controlla la robustezza della password
function checkCredential(password) {
    if (password.length < 8) return false;
    if (password.length > 20) return false;
    if (password.search(/[a-z]/) < 0) return false;
    if (password.search(/[A-Z]/) < 0) return false;
    if (password.search(/[0-9]/) < 0) return false;
    if (password.search(/[$@#&!]/) < 0) return false;
    if (password.search(/[^a-zA-Z0-9$@#&!]/) >= 0) return false; //cerca qualsiasi carattere che non sia una lettera, un numero o uno dei caratteri speciali ammessi
    return true;
}

//usa una regex per verificare che il formato dell'email sia corretto (es. testo@dominio.com)
function validateEmailField() {
    const emailInput = document.querySelector('input[name="email"]');
    if (!emailInput) return false;
    const email = emailInput.value.trim();
    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email);
}

//chiama la funzione checkCredential() per verificare la robustezza della password
function validatePasswordField() {
    const passwordInput = document.querySelector('input[name="password"]');
    if (!passwordInput) return false;
    return checkCredential(passwordInput.value);
}

//controlla che il valore del campo "password" sia identico a quello del campo "confirmPassword"
function validatePasswordMatch() {
    const passwordInput = document.querySelector('input[name="password"]');
    const confirmInput = document.querySelector('input[name="confirmPassword"]');
    if (!confirmInput) return true; // Non presente nel login
    return passwordInput.value === confirmInput.value;
}


//si assicura che i campi nome e cognome non siano vuoti.
function validateNameFields() {
    const nameInput = document.querySelector('input[name="name"]');
    const surnameInput = document.querySelector('input[name="surname"]');
    if (!nameInput || !surnameInput) return true; // Non presente nel login
    return nameInput.value.trim() !== "" && surnameInput.value.trim() !== "";
}


//usa una regex per controllare che il numero di telefono contenga solo cifre e abbia lunghezza compresa tra 8 e 15
function validatePhoneField() {
    const phoneInput = document.querySelector('input[name="phone"]');
    if (!phoneInput) return true; // Non presente nel login
    const phone = phoneInput.value.trim();
    // Validazione base per numero di telefono (almeno 8 cifre)
    const phoneRegex = /^\d{8,15}$/;
    return phoneRegex.test(phone);
}



/**
 * funzioni per migliorare l'interazione dell'utente con il form
 */

//permette all'utente di mostrare/nascondere la password cliccando sull'icona
function togglePassword(iconElement) {
    // Trova l'input password nel contenitore padre
    const passwordInput = iconElement.parentElement.querySelector('input[type="password"], input[type="text"]');
    if (!passwordInput) return;

    //controlla il type attuale dell'input, se è password lo cambia in text (rendendo visibile il testo) e cambia l'immagine dell'icona, se è text fa l'inverso
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

//mostra all'utente una lista di tutti gli errori di validazione trovati in modo chiaro e visibile
function showErrors(errors) {
    //trova il form
    const form = document.getElementById("loginForm") || document.getElementById("registerForm");
    if (!form) return;

    // Rimuovi container errori precedente
    let errorContainer = document.getElementById("formErrorContainer");
    if (errorContainer) {
        errorContainer.remove();
    }

    //se ci sono errori
    if (errors.length > 0) {
        //crea un div e applica stile css direttamente tramite JavaScript
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

        // fa scorrere la pagina automaticamente per portare il messaggio di errore al centro della visuale dell'utente
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


//chiama tutte le singole funzioni di validazione e decide se il form è valido
function validateForm() {
    const errors = [];
    const isRegistrationForm = !!document.getElementById("registerForm"); //verifica se si trova in un form di registrazione

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



/**
 * Migliora l'accessibilità degli elementi toggle password
 * Aggiunge supporto per navigazione da tastiera (Enter e Spazio)
 */
function setupPasswordToggleAccessibility() {
    document.querySelectorAll('.auth-form-container__icon').forEach(icon => {
        icon.addEventListener('keypress', function(e) {
            // Supporta sia Enter che Spazio per attivare il toggle
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                this.click();
            }
        });
    });
}

/**
 * Rimuove automaticamente i messaggi del server dopo 5 secondi
 * Migliora l'UX nascondendo i messaggi con una transizione smooth
 */
function setupAutoHideServerMessages() {
    const serverMessages = document.querySelectorAll('.server-error-message, .server-success-message');

    serverMessages.forEach(message => {
        setTimeout(() => {
            message.style.opacity = '0';
            message.style.transition = 'opacity 0.5s ease-out';

            // Rimuove completamente l'elemento dopo la transizione
            setTimeout(() => {
                if (message.parentNode) {
                    message.remove();
                }
            }, 500);
        }, 5000);
    });
}

// Event listeners principali
document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");

    // Setup validazione form
    if (registerForm) {
        // Setup elementi del button per la registrazione
        const registerButtonElements = setupLoadingButton(registerForm);

        registerForm.addEventListener("submit", function (event) {
            if (!validateForm()) { //se questo restituisce false (cioè ci sono errori), viene eseguito event.preventDefault()
                event.preventDefault();  //impedisce l'azione predefinita, che in questo caso è l'invio del form al server
            } else {
                // Se la validazione è passata, mostra il loading
                showLoadingState(registerButtonElements);
            }
        });
    }

    if (loginForm) {
        // Setup elementi del button per il login
        const loginButtonElements = setupLoadingButton(loginForm);

        loginForm.addEventListener("submit", function (event) {
            if (!validateForm()) {
                event.preventDefault();
            } else {
                // Se la validazione è passata, mostra il loading
                showLoadingState(loginButtonElements);
            }
        });
    }

    // Setup toggle password con supporto accessibilità migliorato
    const passwordToggle = document.querySelector('.auth-form-container__icon-password');
    if (passwordToggle) {
        passwordToggle.addEventListener('click', function () {
            const input = document.getElementById('password');
            if (input) {
                togglePassword(this);
            }
        });
    }

    // Inizializza le funzionalità UX aggiuntive
    setupPasswordToggleAccessibility();
    setupAutoHideServerMessages();
});
