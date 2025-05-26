document.addEventListener("DOMContentLoaded", function() {
    const toggleBtns = document.querySelectorAll(".toggle-subcategories");



    toggleBtns.forEach(btn => {
        btn.addEventListener("click", function() {
            const categoryCard = this.closest('.category-card');
            const menu = categoryCard.querySelector('.subcategory-menu');

            if (menu.style.display === "none" || menu.style.display === "") {
                // Show menu with animation
                menu.style.display = "flex";
                menu.style.flexDirection = "column";

                // Trigger animation by setting properties after a tiny delay
                setTimeout(() => {
                    menu.style.transform = "translateY(5px)";
                }, 1);

                this.textContent = "▼";
            } else {
                // Hide with animation

                menu.style.transform = "translateY(-5px)";

                // After animation completes, hide the element
                setTimeout(() => {
                    menu.style.display = "none";
                }, 1);

                this.textContent = "▶";
            }
        });
    });
});