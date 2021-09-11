package com.app.chat.services;

import com.app.chat.data.dto.UserDto;
import com.app.chat.data.entities.UserEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    UserEntity create(UserDto userDto);
    UserEntity updateOnline(Long id, boolean online);
    List<String> validate(String username, String email);
    List<UserEntity> findByName(String name, Pageable pageable);
}