package service;

import jakarta.servlet.ServletContext;
import model.Bean.Address;
import model.Bean.User;
import model.DAO.AddressDAO;
import model.DAO.UserDAO;

import java.util.ArrayList;
import java.util.List;


public class UserService {

    private final UserDAO userDAO;

    public UserService(ServletContext context){
        this.userDAO = new UserDAO();
    }

    public List<User> searchUsers(String query) {
	    return userDAO.findByEmailLike(query);
    }

    public List<User> getAllUsers() {
	    return userDAO.doRetrieveAll();
    }

    public List<String> getUserEmails(String email) {
        List<User> userList = userDAO.findByEmailLike(email);
        List<String> emailList = new ArrayList<>();
        for(User user : userList){
            emailList.add(user.getEmail());
        }
        return emailList;
    }
   public boolean updateAdmin(String userId, boolean isAdmin) {
       try {
           int id = Integer.parseInt(userId);
           User user = userDAO.doRetrieveById(id);
           if (user != null) {
               user.setAdmin(isAdmin);
               return userDAO.doUpdateAdminStatus(user);
           }
       } catch (NumberFormatException e) {
           System.err.println("Errore conversione userId: " + userId + " - " + e.getMessage());

       } catch (Exception e) {
           System.err.println("Errore aggiornamento admin status: " + e.getMessage());
           e.printStackTrace(); // Stampa lo stack trace completo

       }
       return false;
   }
    public List<Address> getUserAddresses(int userid){
        AddressDAO addressDAO = new AddressDAO();
        try {
            return addressDAO.doRetrieveByUserId(userid);
        } catch (Exception e) {
            System.err.println("Errore recupero indirizzi utente: " + e.getMessage());
            e.printStackTrace(); // Stampa lo stack trace completo
            return new ArrayList<>(); // Ritorna una lista vuota in caso di errore
        }
    }
}

