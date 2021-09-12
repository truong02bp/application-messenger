package com.app.chat.data.dto;

import com.app.chat.data.entities.FriendShipEntity;
import com.app.chat.data.entities.UserEntity;

public class UserContact {
    UserEntity user;
    FriendShipEntity friendShip;

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

    public FriendShipEntity getFriendShip() {
        return friendShip;
    }

    public void setFriendShip(FriendShipEntity friendShip) {
        this.friendShip = friendShip;
    }
}
