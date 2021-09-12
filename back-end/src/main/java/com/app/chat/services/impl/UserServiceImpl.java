package com.app.chat.services.impl;

import com.app.chat.data.dto.UserContact;
import com.app.chat.data.dto.UserDto;
import com.app.chat.data.entities.FriendShipEntity;
import com.app.chat.data.entities.RoleEntity;
import com.app.chat.data.repository.MediaRepository;
import com.app.chat.data.repository.RoleRepository;
import com.app.chat.services.FriendShipService;
import com.app.chat.common.exceptions.ApiException;
import com.app.chat.data.dto.MyUserDetails;
import com.app.chat.data.entities.UserEntity;
import com.app.chat.data.repository.UserRepository;
import com.app.chat.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;

    private MediaRepository mediaRepository;

    private RoleRepository roleRepository;

    private FriendShipService friendShipService;

    @Override
    public UserEntity findById(Long id) {
        UserEntity user = userRepository.findById(id).orElse(null);
        if (user == null)
            throw new ApiException().httpStatus(HttpStatus.NOT_FOUND).message("User with id: " + id + " not found");
        return user;
    }

    @Override
    public UserEntity create(UserDto userDto) {
        List<RoleEntity> roles = new ArrayList<>();
        roles.add(roleRepository.findById((long) 2).get()); // 2 is id of user role
        UserEntity user = UserEntity.builder()
                .email(userDto.getEmail())
                .username(userDto.getUsername())
                .password(userDto.getPassword())
                .name(userDto.getName())
                .active(true)
                .address("")
                .online(false)
                .roles(roles)
                .avatar(mediaRepository.findById((long) 73).get()) // 73 is id of anonymous image
                .build();
        user = userRepository.save(user);
        return user;
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
    public List<UserContact> findUserContact(String name, Long userId, Pageable pageable) {
        List<UserContact> contacts = new ArrayList<>();
        List<UserEntity> users = userRepository.findAllByName(name, pageable);
        for (UserEntity user : users) {
            UserContact userContact = new UserContact();
            FriendShipEntity friendShip = friendShipService.findFriendShip(userId, user.getId());
            userContact.setFriendShip(friendShip);
            userContact.setUser(user);
            contacts.add(userContact);
        }
        return contacts;
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
