package com.app.chat.data.repository;

import com.app.chat.data.entities.Media;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MediaRepository extends JpaRepository<Media, Long> {
    Media findByUrl(String url);
    Media findByName(String name                                                                                          );
}