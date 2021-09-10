package com.app.chat.services;

import com.app.chat.data.entities.UserEntity;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    UserEntity create(UserEntity userEntity);
    UserEntity updateOnline(Long id, boolean online);
    List<String> validate(String username, String email);
}