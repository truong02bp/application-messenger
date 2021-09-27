package com.app.chat.data.repository;

import com.app.chat.data.entities.ChatBoxEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChatBoxRepository extends JpaRepository<ChatBoxEntity, Long> {

    @Query(value = "select chatbox from ChatBoxEntity chatbox " +
            "join MessengerEntity messenger on messenger.chatBoxId = chatbox.id and messenger.user.id = ?1 order by chatbox.lastModifiedDate desc")
    List<ChatBoxEntity> findByUserId(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT chatBox.id FROM ChatBoxEntity chatBox " +
            "left join MessengerEntity messenger on messenger.chatBoxId = chatBox.id and messenger.user.id=?1 " +
            "left join MessageEntity message on message.sender.id = messenger.id " +
            "group by chatBox.id " +
            "order by count(message.id) desc")
    List<Long> findMostMessage(@Param("userId") Long userId, Pageable pageable);

}
