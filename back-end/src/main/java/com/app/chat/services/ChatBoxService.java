package com.app.chat.services;

import com.app.chat.data.dto.ChatBoxDto;
import com.app.chat.data.entities.ChatBoxEntity;

import java.util.List;

public interface ChatBoxService {
    void create(List<Long> userIds);
    List<ChatBoxDto> findAllByUserId(Long userId);
}