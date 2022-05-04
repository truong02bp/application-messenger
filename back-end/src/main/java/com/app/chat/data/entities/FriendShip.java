package com.app.chat.data.entities;

import javax.persistence.*;

@Entity
@Table(name = "friend_ship")
public class FriendShip extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;
    @ManyToOne
    @JoinColumn(name = "friend_id", nullable = false)
    User friend;
    @Column(name = "accepted", nullable = false)
    boolean accepted;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getFriend() {
        return friend;
    }

    public void setFriend(User friend) {
        this.friend = friend;
    }

    public boolean isAccepted() {
        return accepted;
    }

    public void setAccepted(boolean accepted) {
        this.accepted = accepted;
    }
}
