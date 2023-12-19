package at.fhv.journey.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "comment", schema = "journey")
public class Comment {

    private int _comment_id;
    private User _user;
    private Hike _hike;
    private String _comment_text;
    private LocalDate _comment_date;
    private int _timestamp_hour;
    private int _timestamp_min;

    public Comment() {

    }

    public Comment(User user, Hike hike, String comment_text, LocalDate comment_date,
                   int timestamp_hour, int timestamp_min) {
        _user = user;
        _hike = hike;
        _comment_text = comment_text;
        _comment_date = comment_date;
        _timestamp_hour = timestamp_hour;
        _timestamp_min = timestamp_min;
    }

    @Id
    @Column(name = "comment_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getComment_id() {
        return _comment_id;
    }

    public void setComment_id(int comment_id) {
        _comment_id = comment_id;
    }

    @ManyToOne
    @JoinColumn(name = "user_id")
    public User getUser() {
        return _user;
    }

    public void setUser(User user) {
        _user = user;
    }

    @ManyToOne
    @JoinColumn(name = "hike_id")
    public Hike getHike() {
        return _hike;
    }

    public void setHike(Hike hike) {
        _hike = hike;
    }

    @Column(name = "comment_text")
    public String getComment_text() {
        return _comment_text;
    }

    public void setComment_text(String comment_text) {
        _comment_text = comment_text;
    }

    @Column(name = "comment_date")
    public LocalDate getComment_date() {
        return _comment_date;
    }

    public void setComment_date(LocalDate comment_date) {
        _comment_date = comment_date;
    }

    @Column(name = "timestamp_hour")
    public int getTimestamp_hour() {
        return _timestamp_hour;
    }

    public void setTimestamp_hour(int timestamp_hour) {
        _timestamp_hour = timestamp_hour;
    }

    @Column(name = "timestamp_min")
    public int getTimestamp_min() {
        return _timestamp_min;
    }

    public void setTimestamp_min(int timestamp_min) {
        _timestamp_min = timestamp_min;
    }
}
