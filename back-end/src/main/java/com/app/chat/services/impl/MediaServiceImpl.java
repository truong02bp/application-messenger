package com.app.chat.services.impl;

import com.app.chat.common.constants.FolderConstants;
import com.app.chat.data.repository.MediaRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.app.chat.data.dto.MediaDto;
import com.app.chat.data.entities.MediaEntity;
import com.app.chat.services.MediaService;
import com.app.chat.services.MinioService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.ByteArrayInputStream;

@Service
@AllArgsConstructor
@Transactional
public class MediaServiceImpl implements MediaService {

    private MinioService minioService;

    private ObjectMapper objectMapper;

    private MediaRepository mediaRepository;

    @Override
    public MediaEntity create(MediaDto mediaDto) {
        MediaEntity media = objectMapper.convertValue(mediaDto,MediaEntity.class);
        String contentType;
        if (mediaDto.getBytes() != null) {
            minioService.upload(FolderConstants.IMAGES_FOLDER, mediaDto.getName(), new ByteArrayInputStream(mediaDto.getBytes()));
            media.setUrl(FolderConstants.IMAGES_FOLDER + mediaDto.getName());
            contentType = mediaDto.getName().substring(mediaDto.getName().lastIndexOf(".")+1);
        }
        else {
            contentType = "sticker";
            media.setUrl(mediaDto.getUrl());
            MediaEntity sticker = mediaRepository.findByUrl(media.getUrl());
            if (sticker != null)
                return sticker;
        }
        media.setContentType(contentType);
        return mediaRepository.save(media);
    }
}
