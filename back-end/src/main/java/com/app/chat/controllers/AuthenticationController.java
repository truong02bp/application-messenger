package com.app.chat.controllers;

import com.app.chat.services.UserService;
import com.app.chat.common.ultils.JwtUtils;
import com.app.chat.data.dto.AuthenticationRequest;
import com.app.chat.data.dto.MyUserDetails;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/authenticate")
class AuthenticationController {

    AuthenticationManager authenticationManager;

    UserService userService;

    @PostMapping
    ResponseEntity<String> authenticate(@RequestBody AuthenticationRequest request){
        try {
            /* UsernamePasswordAuthenticationToken to the default AuthenticationProvider,
             which will use the userDetailsService to get the user based on username and compare that user's password
             with the one in the authentication token
             */
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword()));
        }
        catch (BadCredentialsException e) {
            throw new BadCredentialsException("Invalid username " + request.getUsername());
        }
        MyUserDetails myUserDetails = (MyUserDetails) userService.loadUserByUsername(request.getUsername());
        String jwt = JwtUtils.generateToken(myUserDetails);
        return ResponseEntity.ok(jwt);
    }
}
