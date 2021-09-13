package com.app.chat.services.impl;

import com.app.chat.common.exceptions.ApiException;
import com.app.chat.data.entities.ChatBoxEntity;
import com.app.chat.data.entities.FriendShipEntity;
import com.app.chat.data.entities.UserEntity;
import com.app.chat.data.repository.ChatBoxRepository;
import com.app.chat.data.repository.FriendShipRepository;
import com.app.chat.data.repository.UserRepository;
import com.app.chat.services.ChatBoxService;
import com.app.chat.services.FriendShipService;
import com.app.chat.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@AllArgsConstructor
@Transactional
public class FriendShipServiceImpl implements FriendShipService {

    private FriendShipRepository friendShipRepository;

    private UserRepository userRepository;

    private ChatBoxService chatBoxService;

    @Override
    public FriendShipEntity findFriendShip(Long userId, Long userId2) {
        return friendShipRepository.findFriendShip(userId, userId2);
    }

    @Override
    public FriendShipEntity create(Long userId, Long friendId) {
        FriendShipEntity friendShip = new FriendShipEntity();
        UserEntity user = userRepository.findById(userId).orElse(null);
        UserEntity friend = userRepository.findById(friendId).orElse(null);
        if (user == null || friend == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("No found the user");
        friendShip.setFriend(friend);
        friendShip.setUser(user);
        friendShip.setAccepted(false);
        return friendShipRepository.save(friendShip);
    }

    @Override
    public FriendShipEntity confirmFriendShip(Long id) {
        FriendShipEntity friendShip = friendShipRepository.findById(id).orElse(null);
        if (friendShip == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("Friend ship not found");
        friendShip.setAccepted(true);
        chatBoxService.create(Stream.of(friendShip.getUser().getId(), friendShip.getFriend().getId()).collect(Collectors.toList()));
        return friendShipRepository.save(friendShip);
    }

    @Override
    public void delete(Long id) {
        friendShipRepository.deleteById(id);
    }
}
