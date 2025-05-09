const openNavButton = document.getElementById("openNavButton");
const closeNavButton = document.getElementById("closeNavButton");
const profileActionsButton = document.getElementById("userProfileButton");


function openNav() {
    document.getElementById("mobileNav").style.width = "65%";
    document.getElementById("mobileNav").style.transition = "0.5s";
}

function closeNav() {
    document.getElementById("mobileNav").style.width = "0";
}


function toggleDropdown() {
    let profileActionsDropdown =
        document.getElementById("userActionsDropdown");
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



openNavButton.addEventListener("click", openNav);
closeNavButton.addEventListener("click", closeNav);
profileActionsButton.addEventListener("click", toggleDropdown);



