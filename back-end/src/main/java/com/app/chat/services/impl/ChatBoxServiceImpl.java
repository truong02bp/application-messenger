package com.app.chat.services.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.app.chat.data.dto.ChatBoxDto;
import com.app.chat.data.entities.ChatBoxEntity;
import com.app.chat.data.entities.MessengerEntity;
import com.app.chat.data.repository.ChatBoxRepository;
import com.app.chat.services.ChatBoxService;
import com.app.chat.services.MessageService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
@Transactional
public class ChatBoxServiceImpl implements ChatBoxService {

    private ChatBoxRepository chatBoxRepository;

    private ObjectMapper mapper;

    private  MessageService messageService;

    @Override
    public List<ChatBoxDto> findAllByUserId(Long userId) {
        List<ChatBoxDto> rs = new ArrayList<>();
        List<ChatBoxEntity> chatBoxEntities = chatBoxRepository.findByUserId(userId);
        for (ChatBoxEntity chatBoxEntity : chatBoxEntities){
            ChatBoxDto dto = mapper.convertValue(chatBoxEntity,ChatBoxDto.class);
            dto.setLastMessage(messageService.findLastMessageByChatBoxId(dto.getId()));
            List<MessengerEntity> guestUser = new ArrayList<>();
            for (MessengerEntity messenger : chatBoxEntity.getMessengers()) {
                if (Objects.equals(messenger.getUser().getId(), userId)) {
                    dto.setCurrentUser(messenger);
                }
                else
                    guestUser.add(messenger);
            }
            dto.setGuestUser(guestUser);
            rs.add(dto);
        }
        return rs;
    }
}
