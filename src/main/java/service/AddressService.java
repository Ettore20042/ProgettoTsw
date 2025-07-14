package service;

import jakarta.servlet.ServletContext;
import model.Bean.Address;
import model.Bean.UserAddress;
import model.DAO.AddressDAO;

/**
 * Service che gestisce gli indirizzi degli utenti
 */
public class AddressService {

    private final AddressDAO addressDAO;
    private final UserService userService;

    public AddressService(ServletContext context) {
        this.addressDAO = new AddressDAO();
        this.userService = new UserService(context);
    }

    /**
     * Crea un nuovo indirizzo
     * @param city città
     * @param street via
     * @param streetNumber numero civico
     * @param zipCode codice postale
     * @param country paese
     * @param province provincia
     * @return l'indirizzo salvato o null se fallito
     */
    public Address createAddress(String city, String street, String streetNumber,
                                String zipCode, String country, String province) {

        // Creazione Address
        Address newAddress = new Address();
        newAddress.setCity(city);
        newAddress.setStreet(street);
        newAddress.setStreetNumber(streetNumber);
        newAddress.setZipCode(zipCode);
        newAddress.setCountry(country);
        newAddress.setProvince(province);

        // Salvataggio Address
        return addressDAO.doSave(newAddress);
    }

    /**
     * Aggiunge un indirizzo a un utente
     * @param userId ID dell'utente
     * @param address indirizzo da associare
     * @param addressType tipo di indirizzo
     * @return l'associazione UserAddress salvata o null se fallita
     */
    public UserAddress addAddressToUser(int userId, Address address, String addressType) {

        // Creazione UserAddress
        UserAddress userAddress = new UserAddress();
        userAddress.setUserId(userId);
        userAddress.setAddress(address);
        userAddress.setAddressType(addressType);
        userAddress.setPrimary(false);

        // Salvataggio UserAddress tramite UserService
        return userService.addUserAddress(userAddress);
    }

    /**
     * Crea un nuovo indirizzo e lo associa all'utente in una singola operazione
     * @param userId ID dell'utente
     * @param city città
     * @param street via
     * @param streetNumber numero civico
     * @param zipCode codice postale
     * @param country paese
     * @param province provincia
     * @param addressType tipo di indirizzo
     * @return l'associazione UserAddress salvata o null se fallita
     */
    public UserAddress createAndAddAddressToUser(int userId, String city, String street, String streetNumber,
                                                 String zipCode, String country, String province, String addressType) {

        // Prima crea l'indirizzo
        Address savedAddress = createAddress(city, street, streetNumber, zipCode, country, province);

        if (savedAddress == null) {
            return null;
        }

        // Poi lo associa all'utente
        return addAddressToUser(userId, savedAddress, addressType);
    }

    /**
     * Elimina un indirizzo
     * @param addressId ID dell'indirizzo
     * @param addressType tipo di indirizzo
     * @return true se eliminato con successo, false altrimenti
     */
    public boolean deleteAddress(String addressId, String addressType) {
        return addressDAO.deleteAddress(addressId, addressType);
    }
}
