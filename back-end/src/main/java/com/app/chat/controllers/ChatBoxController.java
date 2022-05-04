package com.app.chat.controllers;

import com.app.chat.data.dto.ChatBoxDto;
import com.app.chat.services.ChatBoxService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
class ChatBoxController {
    private ChatBoxService chatBoxService;

    @GetMapping("/chat-box/{id}")
    public ResponseEntity<ChatBoxDto> getChatBoxById(@PathVariable Long id, @RequestParam("userId") Long userId) {
        return ResponseEntity.ok(chatBoxService.findById(id, userId));
    }

    @GetMapping("/chat-box")
    public ResponseEntity<Object> getChatBox(@RequestParam("userId") Long userId, Pageable pageable){
        return ResponseEntity.ok(chatBoxService.findAllByUserId(userId, pageable));
    }

    @GetMapping("/chat-box/most-message")
    public ResponseEntity<Object> getChatBoxMostMessage(@RequestParam("userId") Long userId, Pageable pageable){
        return ResponseEntity.ok(chatBoxService.findMostMessage(userId, pageable));
    }

    @PostMapping("/chat-box")
    public void create(@RequestParam("userIds") List<Long> userIds) {
        chatBoxService.create(userIds);
    }
}
