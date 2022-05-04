package com.app.chat.services.impl;

import com.app.chat.common.exceptions.ApiException;
import com.app.chat.data.entities.FriendShip;
import com.app.chat.data.entities.User;
import com.app.chat.data.repository.FriendShipRepository;
import com.app.chat.data.repository.UserRepository;
import com.app.chat.services.ChatBoxService;
import com.app.chat.services.FriendShipService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
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
    public List<FriendShip> findFriendShipByUserIdAndName(Long userId, String name, Pageable pageable) {
        return friendShipRepository.findAllByUserIdAndName(userId, name, pageable);
    }

    @Override
    public FriendShip findFriendShip(Long userId, Long userId2) {
        return friendShipRepository.findFriendShip(userId, userId2);
    }

    @Override
    public FriendShip create(Long userId, Long friendId) {
        FriendShip friendShip = new FriendShip();
        User user = userRepository.findById(userId).orElse(null);
        User friend = userRepository.findById(friendId).orElse(null);
        if (user == null || friend == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("No found the user");
        friendShip.setFriend(friend);
        friendShip.setUser(user);
        friendShip.setAccepted(false);
        return friendShipRepository.save(friendShip);
    }

    @Override
    public FriendShip confirmFriendShip(Long id) {
        FriendShip friendShip = friendShipRepository.findById(id).orElse(null);
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
