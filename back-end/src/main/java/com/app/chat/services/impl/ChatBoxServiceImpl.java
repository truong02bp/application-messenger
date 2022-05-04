package com.app.chat.services.impl;

import com.app.chat.common.exceptions.ApiException;
import com.app.chat.data.entities.User;
import com.app.chat.data.repository.MessageRepository;
import com.app.chat.data.repository.MessengerRepository;
import com.app.chat.data.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.app.chat.data.dto.ChatBoxDto;
import com.app.chat.data.entities.ChatBox;
import com.app.chat.data.entities.Messenger;
import com.app.chat.data.repository.ChatBoxRepository;
import com.app.chat.services.ChatBoxService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
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

    private MessengerRepository messengerRepository;

    private UserRepository userRepository;

    private ObjectMapper mapper;

    private MessageRepository messageRepository;

    @Override
    public ChatBoxDto findById(Long id, Long userId) {
        ChatBox chatBox = chatBoxRepository.findById(id).orElse(null);
        if (chatBox == null)
            throw ApiException.builder().message("Chat box not found with id: " + id).httpStatus(HttpStatus.NOT_FOUND);
        ChatBoxDto dto = toDto(chatBox, userId);
        return dto;
    }

    @Override
    public void create(List<Long> userIds) {
        ChatBox chatBox = new ChatBox();
        chatBox = chatBoxRepository.save(chatBox);
        List<User> users = userRepository.findByUserIds(userIds);
        chatBox.setGroup(users.size() > 2);
        List<Messenger> messengers = new ArrayList<>();
        StringBuilder name = new StringBuilder();
        for (User user : users) {
            Messenger messenger = new Messenger();
            name.append(user.getName().substring(user.getName().lastIndexOf(" ")+1)).append(", ");
            messenger.setUser(user);
            messenger.setChatBoxId(chatBox.getId());
            messengers.add(messengerRepository.save(messenger));
        }
        chatBox.setName(name.substring(0,name.length()-1));
        chatBox.setMessengers(messengers);
        chatBoxRepository.save(chatBox);
    }

    @Override
    public List<ChatBoxDto> findAllByUserId(Long userId, Pageable pageable) {
        List<ChatBoxDto> rs = new ArrayList<>();
        List<ChatBox> chatBoxEntities = chatBoxRepository.findByUserId(userId, pageable);
        for (ChatBox chatBox : chatBoxEntities) {
            ChatBoxDto dto = toDto(chatBox, userId);
            rs.add(dto);
        }
        return rs;
    }

    @Override
    public List<ChatBoxDto> findMostMessage(Long userId, Pageable pageable) {
        List<ChatBoxDto> rs = new ArrayList<>();
        List<Long> ids = chatBoxRepository.findMostMessage(userId, pageable);
        for (Long id : ids) {
            ChatBox chatBox = chatBoxRepository.findById(id).orElse(null);
            ChatBoxDto dto = toDto(chatBox, userId);
            rs.add(dto);
        }
        return rs;
    }

    private ChatBoxDto toDto(ChatBox chatBox, Long userId) {
        ChatBoxDto dto = mapper.convertValue(chatBox,ChatBoxDto.class);
        if (chatBox.getLastMessageId() != null)
            dto.setLastMessage(messageRepository.findById(chatBox.getLastMessageId()).orElse(null));
        List<Messenger> guestUser = new ArrayList<>();
        for (Messenger messenger : chatBox.getMessengers()) {
            if (Objects.equals(messenger.getUser().getId(), userId)) {
                dto.setCurrentUser(messenger);
            }
            else
                guestUser.add(messenger);
        }
        dto.setGuestUser(guestUser);
        return dto;
    }

}
