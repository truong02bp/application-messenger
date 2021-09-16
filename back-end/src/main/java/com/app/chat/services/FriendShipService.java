package com.app.chat.services;

import com.app.chat.data.entities.FriendShipEntity;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface FriendShipService {
    List<FriendShipEntity> findFriendShipByUserIdAndName(Long userId, String name, Pageable pageable);
    FriendShipEntity findFriendShip(Long userId, Long userId2);
    FriendShipEntity create(Long userId, Long friendId);
    FriendShipEntity confirmFriendShip(Long id);
    void delete(Long id);
}
