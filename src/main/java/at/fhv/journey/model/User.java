package at.fhv.journey.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name ="user", schema ="journey")
public class User {

    private int _user_id;
    private String _username;
    private String _email;
    private String _password;

    public User(){

    }

    public User(int userId, String username, String email, String password) {
        this._user_id = userId;
        this._username = username;
        this._email = email;
        this._password = password;
    }

    @Id
    @Column(name = "user_id")
    public int getUser_id(){
        return _user_id;
    }

    public void setUser_id(int userId){
        _user_id = userId;
    }

    @Column(name ="username")
    public String getUsername(){
        return _username;
    }

    public void setUsername(String username){
        _username = username;
    }

    @Column(name = "email")
    public String getEmail(){
        return _email;
    }

    public void setEmail(String email){
        _email = email;
    }

    @Column(name = "password")
    public String getPassword(){
        return _password;
    }

    public void setPassword(String password){
        _password = password;
    }
}