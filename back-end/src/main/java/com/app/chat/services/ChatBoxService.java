package com.app.chat.services;

import com.app.chat.data.dto.ChatBoxDto;

import java.util.List;

public interface ChatBoxService {
    List<ChatBoxDto> findAllByUserId(Long userId);
}