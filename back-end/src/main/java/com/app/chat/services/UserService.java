package com.app.chat.services;

import com.app.chat.data.dto.MediaDto;
import com.app.chat.data.dto.UserContact;
import com.app.chat.data.dto.UserDto;
import com.app.chat.data.entities.User;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    User findById(Long id);
    User create(UserDto userDto);
    User updateOnline(Long id, boolean online);
    List<String> validate(String username, String email);
    List<UserContact> findUserContact(String name, Long userId, Pageable pageable);
    User updateAvatar(Long id, MediaDto avatar);
}