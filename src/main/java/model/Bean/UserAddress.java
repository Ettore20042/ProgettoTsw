package model.Bean;

public class UserAddress {
    private int userId; // ✅ Campo mancante
    private Address address;
    private String addressType; // "shipping" o "billing"
    private boolean isPrimary;
    private String addressNickname;

    public UserAddress() {
    }

    // ✅ Getter e setter mancanti
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getAddressType() {
        return addressType;
    }

    public void setAddressType(String addressType) {
        this.addressType = addressType;
    }

    public boolean isPrimary() {
        return isPrimary;
    }

    public void setPrimary(boolean primary) {
        isPrimary = primary;
    }

    public String getAddressNickname() {
        return addressNickname;
    }

    public void setAddressNickname(String addressNickname) {
        this.addressNickname = addressNickname;
    }
}