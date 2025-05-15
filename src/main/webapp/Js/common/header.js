const openNavButton = document.getElementById("openNavButton");
const closeNavButton = document.getElementById("closeNavButton");
const profileActionsButton = document.getElementById("userProfileButton");
const mobileNav = document.getElementById("mobileNav");
let profileActionsDropdown = document.getElementById("userActionsDropdown");

function openNav() {
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



openNavButton.addEventListener("click", openNav);
closeNavButton.addEventListener("click", closeNav);
profileActionsButton.addEventListener("click", toggleDropdown);

document.addEventListener("click", closeOnClickOutside);



