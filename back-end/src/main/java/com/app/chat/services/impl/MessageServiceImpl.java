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
    public List<Message> findAllByChatBoxId(Long chatBoxId, Pageable pageable) {
        return messageRepository.findAllByChatBoxId(chatBoxId, pageable);
    }

    @Override
    public Message create(MessageDto messageDto) {
        Message message = new Message();
        if (messageDto.getMediaId() != null) {
            Media media = mediaRepository.findById(messageDto.getMediaId()).orElse(null);
            message.setMedia(media);
        } else {
            message.setContent(messageDto.getContent());
        }
        Messenger messenger = messengerRepository.findById(messageDto.getMessengerId()).orElse(null);
        if (messenger == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("Messenger not found");
        message.setSender(messenger);
        List<MessageDetail> details = new ArrayList<>();
        MessageDetail detail = new MessageDetail();
        detail.setSeenBy(messenger);
        details.add(detail);
        message.setDetails(details);
        message = messageRepository.save(message);
        ChatBox chatBox = chatBoxRepository.findById(messageDto.getChatBoxId()).orElse(null);
        if (chatBox == null)
            throw ApiException.builder().httpStatus(HttpStatus.NOT_FOUND).message("Chat box not found");
        chatBox.setLastMessageId(message.getId());
        chatBoxRepository.save(chatBox);
        return message;
    }

    @Override
    public List<Message> updateSeen(Long messengerId, Long chatBoxId) {
        List<Message> messages = new ArrayList<>();
        Long lastMessageId = messageRepository.findIdLastMessageBySenderId(messengerId);
        List<Message> messageNeedUpdate;
        if (lastMessageId == null)
            messageNeedUpdate = messageRepository.findAllByChatBoxId(chatBoxId);
        else
            messageNeedUpdate = messageRepository.findMessageNeedUpdate(chatBoxId, lastMessageId);
        Messenger seenBy = messengerRepository.findById(messengerId).orElse(null);
        for (Message message : messageNeedUpdate) {
            List<MessageDetail> details = message.getDetails().stream()
                    .filter(messageDetail -> messageDetail.getSeenBy().getId().equals(messengerId))
                    .collect(Collectors.toList());

            if (details.isEmpty()) {
                MessageDetail detail = new MessageDetail();
                detail.setSeenBy(seenBy);
                message.getDetails().add(detail);
                messages.add(messageRepository.save(message));
            }
        }
        return messages;
    }

    @Override
    public Message updateReaction(MessageDto messageDto) {
        Messenger reactBy = messengerRepository.findById(messageDto.getMessengerId()).orElse(null);
        Message message = messageRepository.findById(messageDto.getMessageId()).orElse(null);
        if (message != null && reactBy != null) {
            if (messageDto.getReaction() != null && !messageDto.getReaction().isEmpty()) {
                Reaction reaction = reactionRepository.findByCode(messageDto.getReaction());
                for (MessageDetail detail : message.getDetails()) {
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
