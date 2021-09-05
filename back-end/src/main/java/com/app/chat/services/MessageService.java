package com.app.chat.services;

import com.app.chat.data.entities.MessageEntity;
import com.app.chat.data.dto.MessageDto;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface MessageService {

    List<MessageEntity> findAllByChatBoxId(Long chatBoxId, Pageable pageable);

    MessageEntity findLastMessageByChatBoxId(Long chatBoxId);

    MessageEntity create(MessageDto messageDto);

    List<MessageEntity> updateSeen(MessageDto messageDto);

    MessageEntity updateReaction(MessageDto messageDto);

}