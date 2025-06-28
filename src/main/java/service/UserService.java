package service;

import jakarta.servlet.ServletContext;
import model.Bean.Product;
import model.Bean.User;
import model.DAO.UserDAO;

import java.util.ArrayList;
import java.util.List;

public class UserService {
    private final UserDAO userDAO;
    private final ServletContext context;

    public UserService(ServletContext context){
        this.userDAO = new UserDAO();
        this.context = context;
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

}
