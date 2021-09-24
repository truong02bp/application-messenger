package com.app.chat.services.impl;

import com.app.chat.data.entities.UserEntity;
import com.app.chat.data.repository.MessageRepository;
import com.app.chat.data.repository.MessengerRepository;
import com.app.chat.data.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.app.chat.data.dto.ChatBoxDto;
import com.app.chat.data.entities.ChatBoxEntity;
import com.app.chat.data.entities.MessengerEntity;
import com.app.chat.data.repository.ChatBoxRepository;
import com.app.chat.services.ChatBoxService;
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

    private MessengerRepository messengerRepository;

    private UserRepository userRepository;

    private ObjectMapper mapper;

    private MessageRepository messageRepository;

    @Override
    public void create(List<Long> userIds) {
        ChatBoxEntity chatBox = new ChatBoxEntity();
        chatBox = chatBoxRepository.save(chatBox);
        List<UserEntity> users = userRepository.findByUserIds(userIds);
        chatBox.setGroup(users.size() > 2);
        List<MessengerEntity> messengers = new ArrayList<>();
        StringBuilder name = new StringBuilder();
        for (UserEntity user : users) {
            MessengerEntity messenger = new MessengerEntity();
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
    public List<ChatBoxDto> findAllByUserId(Long userId) {
        List<ChatBoxDto> rs = new ArrayList<>();
        List<ChatBoxEntity> chatBoxEntities = chatBoxRepository.findByUserId(userId);
        for (ChatBoxEntity chatBoxEntity : chatBoxEntities) {
            ChatBoxDto dto = mapper.convertValue(chatBoxEntity,ChatBoxDto.class);
            if (chatBoxEntity.getLastMessageId() != null)
                dto.setLastMessage(messageRepository.findById(chatBoxEntity.getLastMessageId()).orElse(null));
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
        rs.sort((c1, c2) -> {
            if (c1.getLastMessage() != null && c2.getLastMessage() != null) {
                if (c1.getLastMessage().getCreatedDate().isAfter(c2.getLastMessage().getCreatedDate()))
                    return -1;
                return 1;
            }
            if (c1.getLastMessage() == null && c2.getLastMessage() != null) {
                if (c1.getCreatedDate().isAfter(c2.getLastMessage().getCreatedDate()))
                    return -1;
                return 1;
            }
            if (c1.getLastMessage() != null && c2.getLastMessage() == null) {
                if (c1.getLastMessage().getCreatedDate().isAfter(c2.getCreatedDate()))
                    return -1;
                return 1;
            }
            return 0;
        });
        return rs;
    }
}
