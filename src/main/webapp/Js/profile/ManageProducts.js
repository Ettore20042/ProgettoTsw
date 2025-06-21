document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("searchForm");
    const input = document.getElementById("searchBar");
    const tableBody = document.getElementById("productTableBody");

    form.addEventListener("submit", function (e) {
        e.preventDefault(); // Impedisce il reload della pagina

        const query = input.value.trim();

        if (query.length === 0) {
            tableBody.innerHTML = "<tr><td colspan='5'>Inserisci un termine di ricerca</td></tr>";
            return;
        }

        const contextPath = document.body.dataset.contextPath || ""; // nel caso serva
        const url = `${contextPath}/SearchBarServlet?searchQueryTable=${encodeURIComponent(query)}`;

        fetch(url)
            .then(response => response.json())
            .then(products => {
                tableBody.innerHTML = "";

                if (products.length === 0) {
                    tableBody.innerHTML = "<tr><td colspan='5'>Nessun prodotto trovato</td></tr>";
                    return;
                }

                products.forEach(product => {
                    const row = document.createElement("tr");
                    row.innerHTML = `
                        <td>${product.productId}</td>
                        <td>${product.productName}</td>
                        <td>${product.price}</td>
                        <td>${product.color}</td>
                        <td>${product.quantity}</td>
                    `;
                    tableBody.appendChild(row);
                });
            })
            .catch(error => {
                console.error("Errore durante la ricerca:", error);
                tableBody.innerHTML = "<tr><td colspan='5'>Errore durante la ricerca</td></tr>";
            });
    });
});
