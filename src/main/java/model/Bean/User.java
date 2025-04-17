package model.Bean;

public class User {
    private int idUser;
    private String name;
    private String surname;
    private String number;
    private String role;
    private String email;
    private String password;

    public User(int idUser, String email, String password, String role, String number, String surname, String name) {
        this.idUser = idUser;
        this.email = email;
        this.password = password;
        this.role = role;
        this.number = number;
        this.surname = surname;
        this.name = name;
    }
    public User() {
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
