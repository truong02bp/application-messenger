package com.app.chat.data.repository;

import com.app.chat.data.entities.ChatBox;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChatBoxRepository extends JpaRepository<ChatBox, Long> {

    @Query(value = "select chatbox from ChatBox chatbox " +
            "join Messenger messenger on messenger.chatBoxId = chatbox.id and messenger.user.id = ?1 order by chatbox.lastModifiedDate desc")
    List<ChatBox> findByUserId(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT chatBox.id FROM ChatBox chatBox " +
            "inner join Messenger messenger on messenger.chatBoxId = chatBox.id and messenger.user.id=?1 " +
            "left join Message message on message.sender.id = messenger.id " +
            "group by chatBox.id " +
            "order by count(message.id) desc")
    List<Long> findMostMessage(@Param("userId") Long userId, Pageable pageable);

}
