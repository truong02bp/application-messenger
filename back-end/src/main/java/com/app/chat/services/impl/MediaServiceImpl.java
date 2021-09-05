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

    private MediaRepository imageRepository;

    @Override
    public MediaEntity create(MediaDto mediaDto) {
        minioService.upload(FolderConstants.IMAGES_FOLDER, mediaDto.getName(), new ByteArrayInputStream(mediaDto.getBytes()));
        MediaEntity image = objectMapper.convertValue(mediaDto,MediaEntity.class);
        String contentType = mediaDto.getName().substring(mediaDto.getName().lastIndexOf(".")+1);
        image.setContentType(contentType);
        image.setUrl(FolderConstants.IMAGES_FOLDER + mediaDto.getName());
        return imageRepository.save(image);
    }
}
