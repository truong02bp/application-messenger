package com.app.chat.services;

import com.app.chat.data.entities.Message;
import com.app.chat.data.dto.MessageDto;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface MessageService {

    List<Message> findAllByChatBoxId(Long chatBoxId, Pageable pageable);

    Message create(MessageDto messageDto);

    List<Message> updateSeen(Long messengerId, Long chatBoxId);

    Message updateReaction(MessageDto messageDto);

}