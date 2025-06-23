/**
 * Validates password strength
 */
function checkCredential(password) {
    if(password.length < 8) return false;
    if(password.length > 20) return false;
    if(password.search(/[a-z]/i) < 0) return false;
    if(password.search(/[0-9]/) < 0) return false;
    if(password.search(/[$@#&!]/) < 0) return false;
    if(password.search(/[A-Z]/) < 0) return false;
    if(password.search(/[^a-zA-Z0-9$@#&!]/) >= 0) return false;
    return true;
}

function validateEmailField(){
    const emailInput = document.querySelector('input[name="email"]');
    const email = emailInput.value;
    const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email);
}

function validatePasswordField() {
    const passwordInput = document.querySelector('input[name="password"]');
    return checkCredential(passwordInput.value);
}

function validatePasswordMatch() {
    const passwordInput = document.querySelector('input[name="password"]');
    const confirmInput = document.querySelector('input[name="confirmPassword"]');

    if (!confirmInput) return true; // Skip if not on registration page
    return passwordInput.value === confirmInput.value;
}

function togglePassword(fieldName = 'password') {
    const passwordInput = document.querySelector(`input[name="${fieldName}"]`);
    if (!passwordInput) return;

    const eyeIcon = passwordInput.parentElement.querySelector('.auth-form-container__icon');

    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        if (eyeIcon) {
            eyeIcon.src = eyeIcon.src.replace('eye.png', 'view.png');
            eyeIcon.alt = "Nascondi password";
        }
    } else {
        passwordInput.type = "password";
        if (eyeIcon) {
            eyeIcon.src = eyeIcon.src.replace('view.png', 'eye.png');
            eyeIcon.alt = "Mostra password";
        }
    }
}

function validateForm() {
    let isValid = true;
    const errors = [];
    const isRegistrationForm = !!document.getElementById("registerForm");

    // Validate email
    if (!validateEmailField()) {
        errors.push("Email non valida");
        isValid = false;
    }

    // Validate password
    if (!validatePasswordField()) {
        errors.push("La password deve contenere tra 8-20 caratteri, almeno una lettera maiuscola, una minuscola, un numero e un carattere speciale ($@#&!)");
        isValid = false;
    }

    // Only validate password match on registration form
    if (isRegistrationForm && !validatePasswordMatch()) {
        errors.push("Le password non corrispondono");
        isValid = false;
    }

    // Display errors in a centralized container
    const form = document.getElementById("loginForm") || document.getElementById("registerForm");
    let errorContainer = document.getElementById("formErrorContainer");

    // Remove existing error container if it exists
    if (errorContainer) {
        errorContainer.remove();
    }

    if (!isValid && errors.length > 0) {
        errorContainer = document.createElement("div");
        errorContainer.id = "formErrorContainer";
        errorContainer.style.color = "#fff";
        errorContainer.style.backgroundColor = "#e74c3c";
        errorContainer.style.padding = "15px";
        errorContainer.style.borderRadius = "5px";
        errorContainer.style.marginBottom = "20px";
        errorContainer.style.fontWeight = "bold";
        errorContainer.style.textAlign = "center";
        errorContainer.innerHTML = errors.join("<br>");

        // Insert at the top of the form
        form.insertBefore(errorContainer, form.firstChild);

        // Scroll to error container
        errorContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    return isValid;
}

// Real-time validation helper
function showFormErrors(errors) {
    const form = document.getElementById("loginForm") || document.getElementById("registerForm");
    let errorContainer = document.getElementById("formErrorContainer");

    // Remove existing error container if it exists
    if (errorContainer) {
        errorContainer.remove();
    }

    if (errors.length > 0) {
        errorContainer = document.createElement("div");
        errorContainer.id = "formErrorContainer";
        errorContainer.style.color = "#fff";
        errorContainer.style.backgroundColor = "#e74c3c";
        errorContainer.style.padding = "15px";
        errorContainer.style.borderRadius = "5px";
        errorContainer.style.marginBottom = "20px";
        errorContainer.style.fontWeight = "bold";
        errorContainer.style.textAlign = "center";
        errorContainer.innerHTML = errors.join("<br>");

        // Insert at the top of the form
        form.insertBefore(errorContainer, form.firstChild);

        // Scroll to error container
        errorContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
}

// Initialize event listeners
document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");

    // Form submission validation
    if (registerForm) {
        registerForm.addEventListener("submit", function(event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    }

    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    }

    // Real-time validation for email
    const emailInput = document.querySelector('input[name="email"]');
    if (emailInput) {
        emailInput.addEventListener('blur', function() {
            const errors = [];
            if (this.value && !validateEmailField()) {
                errors.push("Email non valida");
            }
            showFormErrors(errors);
        });
    }

    // Real-time validation for password
    const passwordInput = document.querySelector('input[name="password"]');
    if (passwordInput) {
        passwordInput.addEventListener('blur', function() {
            const errors = [];
            if (this.value && !checkCredential(this.value)) {
                errors.push("La password deve contenere tra 8-20 caratteri, almeno una lettera maiuscola, una minuscola, un numero e un carattere speciale ($@#&!)");
            }
            showFormErrors(errors);
        });
    }

    // Real-time validation for password confirmation
    const confirmPasswordInput = document.querySelector('input[name="confirmPassword"]');
    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener('blur', function() {
            const errors = [];
            if (this.value && !validatePasswordMatch()) {
                errors.push("Le password non corrispondono");
            }
            showFormErrors(errors);
        });
    }
});