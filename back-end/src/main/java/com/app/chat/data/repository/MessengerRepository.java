package com.app.chat.data.repository;

import com.app.chat.data.entities.MessengerEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessengerRepository extends JpaRepository<MessengerEntity, Long> {

}