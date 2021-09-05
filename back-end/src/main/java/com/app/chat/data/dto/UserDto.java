package com.app.chat.data.dto;

import com.app.chat.data.entities.RoleEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class UserDto extends BaseDto {

    private String username;
    private  String password;
    private String name;
    private List<RoleEntity> roles;
}
