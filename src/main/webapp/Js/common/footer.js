const mediaQueryDesktop = window.matchMedia("(min-width: 992px)");
/* Controlla se matcha con la media query*/

function openDisclosureBox(){
    let disclosureBoxes = document.querySelectorAll("details.disclosure-box");

    if (mediaQueryDesktop.matches) {
        disclosureBoxes.forEach(box => {
            if (!box.open){
                box.open = true;
            }

        })
    } else{
        disclosureBoxes.forEach(box => {
            box.open = false;
        })
    }

}

openDisclosureBox();

mediaQueryDesktop.addEventListener("change", openDisclosureBox);