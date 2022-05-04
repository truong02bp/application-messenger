package com.app.chat.data.repository;

import com.app.chat.data.entities.Message;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {

    @Query("select m from Message m where m.sender.chatBoxId=:chatBoxId order by m.id desc")
    List<Message> findAllByChatBoxId(@Param("chatBoxId") Long chatBoxId, Pageable pageable);

    @Query("select m from Message m where m.sender.chatBoxId=:chatBoxId order by m.id desc")
    List<Message> findAllByChatBoxId(@Param("chatBoxId") Long chatBoxId);

    @Query("select m from Message m where m.id = (select max(m.id) from Message m where m.sender.chatBoxId=:chatBoxId)")
    Message findLastMessageByChatBoxId(@Param("chatBoxId") Long chatBoxId);

    @Query("select max(m.id) from Message m where m.sender.id=?1")
    Long findIdLastMessageBySenderId(Long senderId);

    @Query("select distinct message FROM Message message" +
            " join Messenger messenger on messenger.id = message.sender.id" +
            " join ChatBox chatBox on chatBox.id = messenger.chatBoxId and chatBox.id=:chatBoxId and message.id > :maxId ORDER by message.id desc")
    List<Message> findMessageNeedUpdate(@Param("chatBoxId") Long chatBoxId, @Param("maxId") Long maxId);
}