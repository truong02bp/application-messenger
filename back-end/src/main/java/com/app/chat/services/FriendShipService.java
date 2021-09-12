package com.app.chat.services;

import com.app.chat.data.entities.FriendShipEntity;

public interface FriendShipService {
    FriendShipEntity findFriendShip(Long userId, Long userId2);
    FriendShipEntity create(FriendShipEntity friendShip);
}
