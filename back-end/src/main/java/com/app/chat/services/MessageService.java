package com.app.chat.services;

import com.app.chat.data.entities.MessageEntity;
import com.app.chat.data.dto.MessageDto;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface MessageService {

    List<MessageEntity> findAllByChatBoxId(Long chatBoxId, Pageable pageable);

    MessageEntity create(MessageDto messageDto);

    List<MessageEntity> updateSeen(Long messengerId, Long chatBoxId);

    MessageEntity updateReaction(MessageDto messageDto);

}