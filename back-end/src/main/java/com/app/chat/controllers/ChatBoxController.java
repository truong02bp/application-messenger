package com.app.chat.controllers;

import com.app.chat.services.ChatBoxService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
    public ResponseEnitity<Object> create() {
        return null;
    }
}
