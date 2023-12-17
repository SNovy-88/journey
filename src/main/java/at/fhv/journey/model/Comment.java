package at.fhv.journey.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "comment", schema = "journey")
public class Comment {

    private int _commentId;
    private User _user_id;
    private Hike _hike_id;
    private String _commentText;
    private LocalDate _commentDate;
    private int _timestampHour;
    private int _timestampMin;

    @Id
    @Column(name = "comment_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getCommentId() {
        return _commentId;
    }

    public void setCommentId(int commentId) {
        _commentId = commentId;
    }

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    public User getUser() {
        return _user_id;
    }

    public void setUser(User user) {
        _user_id = user;
    }

    @ManyToOne
    @JoinColumn(name = "hike_id", nullable = false)
    public Hike getHike() {
        return _hike_id;
    }

    public void setHike(Hike hike) {
        _hike_id = hike;
    }

    @Column(name = "comment_text")
    public String getCommentText() {
        return _commentText;
    }

    public void setCommentText(String commentText) {
        _commentText = commentText;
    }

    @Column(name = "comment_date")
    public LocalDate getCommentDate() {
        return _commentDate;
    }

    public void setCommentDate(LocalDate commentDate) {
        _commentDate = commentDate;
    }

    @Column(name = "timestamp_hour")
    public int getTimestampHour() {
        return _timestampHour;
    }

    public void setTimestampHour(int timestampHour) {
        _timestampHour = timestampHour;
    }

    @Column(name = "timestamp_min")
    public int getTimestampMin() {
        return _timestampMin;
    }

    public void setTimestampMin(int timestampMin) {
        _timestampMin = timestampMin;
    }
}
