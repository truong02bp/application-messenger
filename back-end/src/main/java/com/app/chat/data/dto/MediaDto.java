package com.app.chat.data.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MediaDto {
    private String name;
    private String contentType;
    private String url;
    private boolean isAvatar;
    private Long userId;
    private byte[] bytes;
}
