document.addEventListener("DOMContentLoaded", function() {
    const openNavButton = document.getElementById("openNavButton");
    const closeNavButton = document.getElementById("closeNavButton");
    const profileActionsButton = document.getElementById("userProfileButton");
    const mobileNav = document.getElementById("mobileNav");
    let profileActionsDropdown = document.getElementById("userActionsDropdown");

    function openNav(event) {
        event.stopPropagation();
        mobileNav.style.width = "65%";
        mobileNav.style.transition = "0.5s";
    }

    function closeNav() {
        mobileNav.style.width = "0";
    }

    function toggleDropdown() {
        let currentStyle = window.getComputedStyle(profileActionsDropdown);
        console.log(currentStyle.display);

        switch (currentStyle.display) {
            case "none":
                profileActionsDropdown.style.display = "flex";
                break;
            case "flex":
                profileActionsDropdown.style.display = "none";
                break;
            default:
                profileActionsDropdown.style.display = "none";
                break;
        }
    }

    function closeOnClickOutside(event) {
        if (mobileNav.style.width === "65%" &&
            !mobileNav.contains(event.target)) {
            closeNav();
        }
        if (profileActionsDropdown.style.display === "flex" &&
            !profileActionsButton.contains(event.target) &&
            !profileActionsDropdown.contains(event.target)) {
            toggleDropdown();
        }
    }

    // Add event listeners for navigation
    openNavButton.addEventListener("click", openNav);
    closeNavButton.addEventListener("click", closeNav);
    profileActionsButton.addEventListener("click", toggleDropdown);
    document.addEventListener("click", closeOnClickOutside);
});

const input = document.getElementById('searchBar');
const suggestionBox = document.getElementById('suggestions');
const searchBarWrapper = document.querySelector('.main-header_search-bar');

let timeout = null;

input.addEventListener('input', function() {
    clearTimeout(timeout);
    const value = this.value.trim();

    if (value.length === 0) {
        suggestionBox.innerHTML = '';
        suggestionBox.classList.remove('active');
        searchBarWrapper.classList.remove('active');
        return;
    }

    const url = `${contextPath}/SuggestionsServlet?q=${encodeURIComponent(value)}`;

    timeout = setTimeout(() => {
        fetch(url)
            .then(response => response.json())
            .then(results => {
                suggestionBox.innerHTML = '';

                if (results.length === 0) {
                    suggestionBox.classList.remove('active');
                    searchBarWrapper.classList.remove('active');
                    return;
                }

                suggestionBox.classList.add('active');
                searchBarWrapper.classList.add('active');

                results.forEach(item => {
                    const div = document.createElement('div');
                    div.textContent = item;
                    div.classList.add('suggestion-item');
                    div.addEventListener('click', () => {
                        input.value = item;
                        suggestionBox.innerHTML = '';
                        suggestionBox.classList.remove('active');
                        searchBarWrapper.classList.remove('active');
                        input.form.submit(); // Submit the form with the selected suggestion
                    });

                    suggestionBox.appendChild(div);
                });
            })
            .catch(error => {
                console.error('Errore:', error);
                suggestionBox.classList.remove('active');
                searchBarWrapper.classList.remove('active');
            });
    }, 300);
});
