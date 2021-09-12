package com.app.chat.controllers;

import com.app.chat.data.entities.FriendShipEntity;
import com.app.chat.services.FriendShipService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/friend-ship")
@AllArgsConstructor
public class FriendShipController {

    private FriendShipService friendShipService;

    @PostMapping
    public ResponseEntity<FriendShipEntity> create(@RequestParam(name = "userId") Long userId, @RequestParam(name = "friendId") Long friendId) {
        FriendShipEntity friendShip = friendShipService.create(userId, friendId);
        return ResponseEntity.ok(friendShip);
    }

    @DeleteMapping
    public void deleteFriendShip(@RequestParam("id") Long id){
        friendShipService.delete(id);
    }

    @PutMapping("/confirm")
    public ResponseEntity<FriendShipEntity> create(@RequestParam("id") Long id) {
        FriendShipEntity friendShip = friendShipService.confirmFriendShip(id);
        return ResponseEntity.ok(friendShip);
    }
}
