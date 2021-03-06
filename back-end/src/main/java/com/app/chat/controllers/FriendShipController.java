package com.app.chat.controllers;

import com.app.chat.data.entities.FriendShip;
import com.app.chat.services.FriendShipService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/friend-ship")
@AllArgsConstructor
public class FriendShipController {

    private FriendShipService friendShipService;

    @GetMapping
    public ResponseEntity<List<FriendShip>> getFriendShipByUserIdAndName(@RequestParam("userId") Long userId,
                                                                         @RequestParam("name") String name,
                                                                         Pageable pageable) {
        List<FriendShip> friendShips = friendShipService.findFriendShipByUserIdAndName(userId, name, pageable);
        return ResponseEntity.ok(friendShips);
    }

    @PostMapping
    public ResponseEntity<FriendShip> create(@RequestParam(name = "userId") Long userId, @RequestParam(name = "friendId") Long friendId) {
        FriendShip friendShip = friendShipService.create(userId, friendId);
        return ResponseEntity.ok(friendShip);
    }

    @DeleteMapping
    public void deleteFriendShip(@RequestParam("id") Long id) {
        friendShipService.delete(id);
    }

    @PutMapping("/confirm")
    public ResponseEntity<FriendShip> create(@RequestParam("id") Long id) {
        FriendShip friendShip = friendShipService.confirmFriendShip(id);
        return ResponseEntity.ok(friendShip);
    }
}
