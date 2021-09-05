package com.app.chat.data.repository;

import com.app.chat.data.entities.ChatBoxEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChatBoxRepository extends JpaRepository<ChatBoxEntity, Long> {

    @Query(value = "select chatbox from ChatBoxEntity chatbox " +
            "join MessengerEntity messenger on messenger.chatBoxId = chatbox.id and messenger.user.id = ?1")
    List<ChatBoxEntity> findByUserId(@Param("userId") Long userId);

}
