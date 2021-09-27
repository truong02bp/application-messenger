package com.app.chat.services.impl;

import com.app.chat.common.exceptions.ApiException;
import com.app.chat.data.entities.*;
import com.app.chat.data.repository.*;
import com.app.chat.data.dto.MessageDto;
import com.app.chat.services.MessageService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@Transactional
@AllArgsConstructor
public class MessageServiceImpl implements MessageService {

    private MessageRepository messageRepository;

    private MessengerRepository messengerRepository;

    private ReactionRepository reactionRepository;

    private MediaRepository mediaRepository;

    private ChatBoxRepository chatBoxRepository;

    @Override
    public List<MessageEntity> findAllByChatBoxId(Long chatBoxId, Pageable pageable) {
        return messageRepository.findAllByChatBoxId(chatBoxId, pageable);
    }

    @Override
    public MessageEntity create(MessageDto messageDto) {
        MessageEntity message = new MessageEntity();
        if (messageDto.getMediaId() != null) {
            MediaEntity media = mediaRepository.findById(messageDto.getMediaId()).orElse(null);
            message.setMedia(media);
        } else {
            message.setContent(messageDto.getContent());
        }
        MessengerEntity messenger = messengerRepository.findById(messageDto.getMessengerId()).orElse(null);
        if (messenger == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("Messenger not found");
        message.setSender(messenger);
        List<MessageDetailEntity> details = new ArrayList<>();
        MessageDetailEntity detail = new MessageDetailEntity();
        detail.setSeenBy(messenger);
        details.add(detail);
        message.setDetails(details);
        message = messageRepository.save(message);
        ChatBoxEntity chatBox = chatBoxRepository.findById(messageDto.getChatBoxId()).orElse(null);
        if (chatBox == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("Chat box not found");
        chatBox.setLastMessageId(message.getId());
        chatBoxRepository.save(chatBox);
        return message;
    }

    @Override
    public List<MessageEntity> updateSeen(Long messengerId, Long chatBoxId) {
        List<MessageEntity> messages = new ArrayList<>();
        Long lastMessageId = messageRepository.findIdLastMessageBySenderId(messengerId);
        List<MessageEntity> messageNeedUpdate;
        if (lastMessageId == null)
            messageNeedUpdate = messageRepository.findAllByChatBoxId(chatBoxId);
        else
            messageNeedUpdate = messageRepository.findMessageNeedUpdate(chatBoxId, lastMessageId);
        MessengerEntity seenBy = messengerRepository.findById(messengerId).orElse(null);
        for (MessageEntity message : messageNeedUpdate) {
            List<MessageDetailEntity> details = message.getDetails().stream()
                    .filter(messageDetailEntity -> messageDetailEntity.getSeenBy().getId().equals(messengerId))
                    .collect(Collectors.toList());

            if (details.isEmpty()) {
                MessageDetailEntity detail = new MessageDetailEntity();
                detail.setSeenBy(seenBy);
                message.getDetails().add(detail);
                messages.add(messageRepository.save(message));
            }
        }
        return messages;
    }

    @Override
    public MessageEntity updateReaction(MessageDto messageDto) {
        MessengerEntity reactBy = messengerRepository.findById(messageDto.getMessengerId()).orElse(null);
        MessageEntity message = messageRepository.findById(messageDto.getMessageId()).orElse(null);
        if (message != null && reactBy != null) {
            if (messageDto.getReaction() != null && !messageDto.getReaction().isEmpty()) {
                ReactionEntity reaction = reactionRepository.findByCode(messageDto.getReaction());
                for (MessageDetailEntity detail : message.getDetails()) {
                    if (Objects.equals(detail.getSeenBy().getId(), reactBy.getId())) {
                        if (detail.getReaction() != null && detail.getReaction().getId().equals(reaction.getId()))
                            detail.setReaction(null);
                        else
                            detail.setReaction(reaction);
                    }
                }
            }
            return messageRepository.save(message);
        }
        return null;
    }
}
