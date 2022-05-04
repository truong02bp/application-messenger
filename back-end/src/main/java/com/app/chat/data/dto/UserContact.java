package com.app.chat.data.dto;

import com.app.chat.data.entities.FriendShip;
import com.app.chat.data.entities.User;

public class UserContact {
    User user;
    FriendShip friendShip;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public FriendShip getFriendShip() {
        return friendShip;
    }

    public void setFriendShip(FriendShip friendShip) {
        this.friendShip = friendShip;
    }
}
