package com.app.chat.controllers;

import com.app.chat.data.dto.MessageDto;
import com.app.chat.data.entities.MessageEntity;
import com.app.chat.services.MessageService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@AllArgsConstructor
class MessageController {

    private MessageService messageService;
    private SimpMessagingTemplate template;

//    @MessageMapping("/chat-register")
//    @SendTo("/topic/public")
//    MessageEntity register(@Payload MessageEntity chatMessage, SimpMessageHeaderAccessor headerAccessor) {
//        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender())
//        return chatMessage
//    }

    @MessageMapping("/message/send")
    public MessageEntity sendMessage(@Payload MessageDto messageDto) {
        MessageEntity messageEntity = messageService.create(messageDto);
        this.template.convertAndSend("/topic/"+messageEntity.getSender().getChatBoxId(), messageEntity);
        return messageEntity;
    }

    @MessageMapping("/message/update/seen")
    public List<MessageEntity> updateSeen(@Payload MessageDto messageDto) {
        List<MessageEntity> messages = messageService.updateSeen(messageDto.getMessengerId(), messageDto.getChatBoxId());
        this.template.convertAndSend("/topic/update/seen", messages);
        return messages;
    }

    @MessageMapping("/message/update/reaction")
    public MessageEntity updateReaction(@Payload MessageDto messageDto) {
        MessageEntity message = messageService.updateReaction(messageDto);
        this.template.convertAndSend("/topic/update/reaction", message);
        return message;
    }

    @GetMapping("/api/message")
    public ResponseEntity<Object> getMessageByChatBoxId(@RequestParam("chatBoxId") Long chatBoxId, Pageable pageable) {
        return ResponseEntity.ok(messageService.findAllByChatBoxId(chatBoxId,pageable));
    }
}
