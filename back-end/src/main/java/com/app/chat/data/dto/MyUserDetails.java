package com.app.chat.data.dto;

import com.app.chat.data.entities.User;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class MyUserDetails extends org.springframework.security.core.userdetails.User {

    private User user;

    public MyUserDetails(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities, User user) {
        super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
        this.user = user;
    }

    public User getUserEntity() {
        return user;
    }

    public void setUserEntity(User user) {
        this.user = user;
    }
}
