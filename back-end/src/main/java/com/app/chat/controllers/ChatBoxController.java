package com.app.chat.controllers;

import com.app.chat.data.entities.ChatBoxEntity;
import com.app.chat.services.ChatBoxService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
class ChatBoxController {
    private ChatBoxService chatBoxService;

    @GetMapping("/chat-box")
    public ResponseEntity<Object> getChatBoxByUserId(@RequestParam("userId") Long userId){
        return ResponseEntity.ok(chatBoxService.findAllByUserId(userId));
    }
    @PostMapping("/chat-box")
    public void create(@RequestParam("userIds") List<Long> userIds) {
        chatBoxService.create(userIds);
    }
}
