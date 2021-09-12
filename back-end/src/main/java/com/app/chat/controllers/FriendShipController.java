package com.app.chat.controllers;

import com.app.chat.data.entities.FriendShipEntity;
import com.app.chat.services.FriendShipService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/friend-ship")
@AllArgsConstructor
public class FriendShipController {

    private FriendShipService friendShipService;

    @PostMapping
    public ResponseEntity<FriendShipEntity> create(@RequestBody FriendShipEntity shipEntity) {
        shipEntity = friendShipService.create(shipEntity);
        return ResponseEntity.ok(shipEntity);
    }
}
