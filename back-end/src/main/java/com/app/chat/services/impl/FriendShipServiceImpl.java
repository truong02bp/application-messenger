package com.app.chat.services.impl;

import com.app.chat.data.entities.FriendShipEntity;
import com.app.chat.data.repository.FriendShipRepository;
import com.app.chat.services.FriendShipService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class FriendShipServiceImpl implements FriendShipService {

    private FriendShipRepository friendShipRepository;

    @Override
    public FriendShipEntity findFriendShip(Long userId, Long userId2) {
        return friendShipRepository.findFriendShip(userId, userId2);
    }

    @Override
    public FriendShipEntity create(FriendShipEntity friendShip) {
        friendShip.setAccepted(false);
        return friendShipRepository.save(friendShip);
    }
}
