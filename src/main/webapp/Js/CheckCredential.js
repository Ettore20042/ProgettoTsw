/**
 * Validates password strength according to security requirements:
 * - Length between 8-20 characters
 * - Contains lowercase letter
 * - Contains uppercase letter
 * - Contains a number
 * - Contains a special character ($@#&!)
 * - No invalid characters
 * @param {string} password - The password to validate
 * @return {boolean} True if password meets all requirements
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

function validatePasswordField() {
    var password = document.getElementById("password").value;
    return checkCredential(password);
}

function validateEmailField(){
    var email = document.getElementById("email").value;
    var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email);
}

// Form validation function
function validateForm() {
    let isValid = true;

    if (!validateEmailField()) {
        document.getElementById("emailError").style.paddingBottom = "4%";
        document.getElementById("emailError").style.display = "block";
        document.getElementById("emailError").innerHTML = "Please enter a valid email address";
        isValid = false;
    } else {
        document.getElementById("emailError").style.display = "none";
    }

    if (!validatePasswordField()) {
        document.getElementById("passwordError").style.display = "block";
        document.getElementById("passwordError").innerHTML = "Password must be between 8-20 characters, contain at least one uppercase letter, one lowercase letter, one number, and one special character ($@#&!)";
        isValid = false;
    } else {
        document.getElementById("passwordError").style.display = "none";
    }

    return isValid;
}

// Initialize event listeners when DOM is loaded
document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("loginForm");
    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    }

    const registerForm = document.getElementById("registerForm");
    if (registerForm) {
        registerForm.addEventListener("submit", function(event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    }
})