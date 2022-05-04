package com.app.chat.services;

import com.app.chat.data.entities.FriendShip;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface FriendShipService {
    List<FriendShip> findFriendShipByUserIdAndName(Long userId, String name, Pageable pageable);
    FriendShip findFriendShip(Long userId, Long userId2);
    FriendShip create(Long userId, Long friendId);
    FriendShip confirmFriendShip(Long id);
    void delete(Long id);
}
