package com.app.chat.services;

import com.app.chat.data.entities.FriendShipEntity;

public interface FriendShipService {
    FriendShipEntity findFriendShip(Long userId, Long userId2);
    FriendShipEntity create(Long userId, Long friendId);
    FriendShipEntity confirmFriendShip(Long id);
    void delete(Long id);
}
