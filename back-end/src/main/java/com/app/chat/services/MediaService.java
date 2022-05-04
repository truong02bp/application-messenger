package com.app.chat.services;

import com.app.chat.data.entities.Media;
import com.app.chat.data.dto.MediaDto;

public interface MediaService {

    Media create(MediaDto mediaDto);

}