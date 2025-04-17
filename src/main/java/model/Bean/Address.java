package model.Bean;

public class Address {
    private int idAddress;
    private String city;
    private String street;
    private String number;
    private String postalCode;
    private String country;
    private String province;

    public Address(int idAddress, String province, String country, String postalCode, String number, String street, String city) {
        this.idAddress = idAddress;
        this.province = province;
        this.country = country;
        this.postalCode = postalCode;
        this.number = number;
        this.street = street;
        this.city = city;
    }
    public Address() {
    }

    public int getIdAddress() {
        return idAddress;
    }

    public void setIdAddress(int idAddress) {
        this.idAddress = idAddress;
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

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
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
