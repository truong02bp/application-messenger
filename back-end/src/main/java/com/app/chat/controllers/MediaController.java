package com.app.chat.controllers;

import com.app.chat.data.dto.MediaDto;
import com.app.chat.data.entities.Media;
import com.app.chat.services.MediaService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/api")
class MediaController {

    private MediaService mediaService;

    @PostMapping("/media")
    public ResponseEntity<Media> create(@RequestBody MediaDto mediaDto){
        return ResponseEntity.ok(mediaService.create(mediaDto));
    }
}
