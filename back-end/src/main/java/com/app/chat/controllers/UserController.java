package com.app.chat.controllers;

import com.app.chat.data.dto.MyUserDetails;
import com.app.chat.data.entities.UserEntity;
import com.app.chat.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
class UserController {

    private UserService userService;

    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @GetMapping("/user")
    public ResponseEntity<Object> getCurrentUser() {
        MyUserDetails user = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return ResponseEntity.ok(user.getUserEntity());
    }

    @PostMapping("/user")
    public ResponseEntity<Object> create(@RequestBody UserEntity userEntity) {
        userEntity.setPassword(bCryptPasswordEncoder.encode(userEntity.getPassword()));
        return ResponseEntity.ok(userService.create(userEntity));
    }

    @PostMapping("/user/update-online")
    public ResponseEntity<UserEntity> updateOnline(@RequestParam("id") Long id, @RequestParam("online") boolean online) {
        return ResponseEntity.ok(userService.updateOnline(id, online));
    }
}
