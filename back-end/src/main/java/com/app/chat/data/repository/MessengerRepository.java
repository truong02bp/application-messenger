package com.app.chat.data.repository;

import com.app.chat.data.entities.Messenger;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessengerRepository extends JpaRepository<Messenger, Long> {

}