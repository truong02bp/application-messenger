package com.app.chat.controllers;

import com.app.chat.data.dto.MediaDto;
import com.app.chat.data.dto.MyUserDetails;
import com.app.chat.data.dto.UserContact;
import com.app.chat.data.dto.UserDto;
import com.app.chat.data.entities.User;
import com.app.chat.services.MailService;
import com.app.chat.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
class UserController {

    private UserService userService;

    private BCryptPasswordEncoder bCryptPasswordEncoder;

    private MailService mailService;


    @GetMapping("/user")
    public ResponseEntity<Object> getCurrentUser() {
        MyUserDetails user = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return ResponseEntity.ok(user.getUserEntity());
    }
    @GetMapping("/user/key")
    public ResponseEntity<Object> findUserContact(@RequestParam(name = "name") String name,@RequestParam("userId") Long userId, Pageable pageable) {
        List<UserContact> users = userService.findUserContact(name, userId, pageable);
        return ResponseEntity.ok(users);
    }

    @PostMapping("/user")
    public ResponseEntity<Object> create(@RequestBody UserDto userDto) {
        userDto.setPassword(bCryptPasswordEncoder.encode(userDto.getPassword()));
        return ResponseEntity.ok(userService.create(userDto));
    }

    @PutMapping("/user/avatar")
    public ResponseEntity<User> updateAvatar(@RequestParam("userId") Long userId, @RequestBody MediaDto avatar) {
        User user = userService.updateAvatar(userId, avatar);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/user/update-online")
    public ResponseEntity<User> updateOnline(@RequestParam("id") Long id, @RequestParam("online") boolean online) {
        return ResponseEntity.ok(userService.updateOnline(id, online));
    }

    @PostMapping("/user/validate")
    public ResponseEntity<List<String>> validate(@RequestParam("username") String username, @RequestParam("email") String email) {
        List<String> errors = userService.validate(username, email);
        return ResponseEntity.ok(errors);
    }

    @PostMapping("/user/otp")
    public ResponseEntity<String> sendOtp(@RequestParam("email") String email,
                                          @RequestParam("name") String name) {
        String otp = mailService.sendOtp(name, email);
        return ResponseEntity.ok(otp);
    }
}
