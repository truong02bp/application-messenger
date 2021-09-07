package com.app.chat.data.repository;

import com.app.chat.data.entities.MediaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MediaRepository extends JpaRepository<MediaEntity, Long> {
    MediaEntity findByUrl(String url);
}