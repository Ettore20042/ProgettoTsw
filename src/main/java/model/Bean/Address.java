package model.Bean;

public class Address {
    private int addressId;
    private String city;
    private String street;
    private String streetNumber;
    private String zipCode;
    private String country;
    private String province;

    public Address(int idAddress, String province, String country, String zipCode, String streetnumber, String street, String city) {
        this.addressId = idAddress;
        this.province = province;
        this.country = country;
        this.zipCode = zipCode;
        this.streetNumber = streetnumber;
        this.street = street;
        this.city = city;
    }
    public Address() {
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getStreetNumber() {
        return streetNumber;
    }

    public void setStreetNumber(String streetNumber) {
        this.streetNumber = streetNumber;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
