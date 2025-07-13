const mediaQueryDesktop = window.matchMedia("(min-width: 992px)");
/* Controlla se matcha con la media query*/

//per aprire e chiudere i box
function openDisclosureBox(){
    let disclosureBoxes = document.querySelectorAll("details.disclosure-box");

    //se siamo su desktop
    if (mediaQueryDesktop.matches) {
        disclosureBoxes.forEach(box => {
            if (!box.open){
                box.open = true; //apre ogni box che è chiuso
            }

        })
        //se siamo su mobile/tablet
    } else{
        disclosureBoxes.forEach(box => {
            box.open = false; //chiude tutti i box
        })
    }

}

openDisclosureBox();

mediaQueryDesktop.addEventListener("change", openDisclosureBox);