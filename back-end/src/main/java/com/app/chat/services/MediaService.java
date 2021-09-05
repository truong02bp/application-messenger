package com.app.chat.services;

import com.app.chat.data.entities.MediaEntity;
import com.app.chat.data.dto.MediaDto;

public interface MediaService {

    MediaEntity create(MediaDto mediaDto);

}