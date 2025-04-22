package model.Bean;

public class User {
    private int userId;
    private String firstName;
    private String lastName;
    private String phone;
    private String role;
    private String password;
    private String email;


   public User(int idUser, String name, String surname, String number, String role, String password, String email) {
        this.userId = idUser;
        this.firstName = name;
        this.lastName = surname;
        this.phone = number;
        this.role = role;
        this.password = password;
        this.email = email;
    }
    public User() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
}
