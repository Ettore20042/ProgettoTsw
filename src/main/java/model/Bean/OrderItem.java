package model.Bean;


    public class OrderItem {
        private int productId;
        private int orderId;
        private int quantity;
        private float unitPrice;

        public OrderItem(int productId, int orderId, int quantity, float unitPrice) {
            this.productId = productId;
            this.orderId = orderId;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
        }
        public OrderItem() {
        }

        public int getProductId() {
            return productId;
        }

        public void setProductId(int productId) {
            this.productId = productId;
        }

        public float getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(float unitPrice) {
            this.unitPrice = unitPrice;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public int getOrderId() {
            return orderId;
        }

        public void setOrderId(int orderId) {
            this.orderId = orderId;
        }
    }


