const mediaQueryDesktop = window.matchMedia("(min-width: 992px)");

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