package service;

import jakarta.servlet.ServletContext;
import model.Bean.User;
import model.DAO.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Service che gestisce l'autenticazione e la registrazione degli utenti
 */
public class AuthenticationService {

    private final UserDAO userDAO;

    public AuthenticationService(ServletContext context) {
        this.userDAO = new UserDAO();
    }

    /**
     * Autentica un utente con email e password
     * @param email l'email dell'utente
     * @param password la password in chiaro
     * @return l'utente autenticato o null se le credenziali sono errate
     */
    public User authenticateUser(String email, String password) {
        return userDAO.doLogin(email, password);
    }

    /**
     * Verifica se un'email è già stata utilizzata
     * @param email l'email da verificare
     * @return true se l'email è già in uso, false altrimenti
     */
    public boolean isEmailAlreadyUsed(String email) {
        return userDAO.isEmailAlreadyUsed(email);
    }

    /**
     * Registra un nuovo utente
     * @param name nome dell'utente
     * @param surname cognome dell'utente
     * @param phone telefono dell'utente
     * @param email email dell'utente
     * @param password password in chiaro che verrà hashata
     * @return l'utente registrato o null se la registrazione è fallita
     */
    public User registerUser(String name, String surname, String phone, String email, String password) {
        // Hash della password per sicurezza
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Salva l'utente e restituisce direttamente il risultato
        return userDAO.doSaveUser(name, surname, phone, hashedPassword, email);
    }
}
