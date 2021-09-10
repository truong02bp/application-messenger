package com.app.chat.services.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.app.chat.common.exceptions.ApiException;
import com.app.chat.data.dto.MyUserDetails;
import com.app.chat.data.entities.UserEntity;
import com.app.chat.data.repository.UserRepository;
import com.app.chat.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;

    private ObjectMapper mapper;

    @Override
    public UserEntity create(UserEntity userEntity) {
        return userRepository.save(userEntity);
    }

    @Override
    public UserEntity updateOnline(Long id, boolean online) {
        System.out.println(id + " " + online);
        UserEntity user = userRepository.findById(id).orElse(null);
        if (user == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("No found the user");
        user.setOnline(online);
        if (!user.isOnline())
            user.setLastOnline(Instant.now());
        return userRepository.save(user);
    }

    @Override
    public List<String> validate(String username, String email) {
        List<String> errors = new ArrayList<>();
        if (userRepository.findByUsername(username) != null) {
            errors.add("Username: " + username + " is existed");
        }
        if (userRepository.findByEmail(username) != null) {
            errors.add("Email: " + email + " is existed");
        }
        return errors;
    }

    @Override
    @Transactional
    public MyUserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity user = userRepository.findByUsername(username);
        if (user == null)
            throw new UsernameNotFoundException("Not found username : " + username);
        List<GrantedAuthority> authorities = new ArrayList<>();
        user.getRoles().forEach(role -> authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getCode())));
        return new MyUserDetails(user.getUsername(), user.getPassword(), true, true, true, true, authorities, user);
    }
}
