package com.app.chat.services;

import com.app.chat.data.dto.ChatBoxDto;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ChatBoxService {
    ChatBoxDto findById(Long id, Long userId);
    void create(List<Long> userIds);
    List<ChatBoxDto> findAllByUserId(Long userId, Pageable pageable);
    List<ChatBoxDto> findMostMessage(Long userId, Pageable pageable);
}