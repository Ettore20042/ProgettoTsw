<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="product-filter">
    <button class="product-filter_open-btn">Filtra e ordina</button>
    <div class="product-filter_mobile-wrapper">
        <div class="product-filter_wrapper">
            <div class="product-filter_heading">
                <span class="material-symbols-rounded" id="close-filter-btn">close</span>
                <h2 class="product-filter_title">Filtra</h2>
            </div>


            <details class="product-filter_details-box product-filter_price">
                <summary class="product-filter_details-summary">Prezzo</summary>
                <div class="product-filter_details-content">
                    <button class="product-filter_details-reset">Ripristina</button>
<%--                    <input type="range" class="product-filter_price-range" min="0">--%>
                    <div class="product-filter_price-box">
                        <span class="product-filter_price-range-value">Prezzo: 0 - 0</span>
                        <input type="number" class="product-filter_price-min" placeholder="0" min="0">
                        <span class="material-symbols-rounded">check_indeterminate_small</span>
                        <input type="number" class="product-filter_price-max" placeholder="0" min="0">
                    </div>

                </div>
            </details>

            <details class="product-filter_details-box product-filter_brand">
                <summary class="product-filter_details-summary">Brand</summary>
                <div class="product-filter_details-content">
                    <button class="product-filter_details-reset">Ripristina</button>
                    <ul class="product-filter_list product-filter_list-brand">
                        <!-- Esempio struttura per CSS - verrà sostituito da JavaScript -->
                        <li>
                            <input type="checkbox" name="brand" id="brand_example" value="1"
                                   class="product-filter_checkbox" data-brand-id="1">
                            <label for="brand_example" class="product-filter_label"></label>
                        </li>
                    </ul>
                </div>
            </details>

            <details class="product-filter_details-box">
                <summary class="product-filter_details-summary">Colore</summary>
                <div class="product-filter_details-content">
                    <button class="product-filter_details-reset">Ripristina</button>
                    <ul class="product-filter_list product-filter_list-color">
                        <!-- Esempio struttura per CSS - verrà sostituito da JavaScript -->
                        <li style="display: none;">
                            <input type="checkbox" name="color" id="color_example" value="rosso"
                                   class="product-filter_checkbox" data-color-id="rosso">
                            <label for="color_example" class="product-filter_label"></label>
                        </li>
                    </ul>
                </div>
            </details>

            <details class="product-filter_details-box">
                <summary class="product-filter_details-summary">Materiali</summary>
                <div class="product-filter_details-content">
                    <button class="product-filter_details-reset">Ripristina</button>
                    <ul class="product-filter_list product-filter_list-material">
                        <!-- Esempio struttura per CSS - verrà sostituito da JavaScript -->
                        <li style="display: none;">
                            <input type="checkbox" name="material" id="material_example" value=""
                                   class="product-filter_checkbox" data-material-id="">
                            <label for="material_example" class="product-filter_label"></label>
                        </li>
                    </ul>
                </div>
            </details>
            <div class="product-filter_buttons-event-box">
                <button class="product-filter_buttons-event product-filter_reset-all">Cancella tutto</button>
                <button class="product-filter_buttons-event product-filter_apply">Applica filtri</button>
            </div>

        </div>
    </div>
</section>


