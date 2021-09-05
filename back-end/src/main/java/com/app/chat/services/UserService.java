package com.app.chat.services;

import com.app.chat.data.entities.UserEntity;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {
    UserEntity create(UserEntity userEntity);
    UserEntity updateOnline(Long id, boolean online);
}