package com.app.chat.data.dto;

import lombok.Data;

@Data
public class UserDto extends BaseDto {

    private String username;
    private String password;
    private String name;
    private String email;

}
