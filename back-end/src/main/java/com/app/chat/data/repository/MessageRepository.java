package com.app.chat.data.repository;

import com.app.chat.data.entities.MessageEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MessageRepository extends JpaRepository<MessageEntity, Long> {

    @Query("select m from MessageEntity m where m.sender.chatBoxId=:chatBoxId order by m.id desc")
    List<MessageEntity> findAllByChatBoxId(@Param("chatBoxId") Long chatBoxId, Pageable pageable);

    @Query("select m from MessageEntity m where m.sender.chatBoxId=:chatBoxId order by m.id desc")
    List<MessageEntity> findAllByChatBoxId(@Param("chatBoxId") Long chatBoxId);

    @Query("select m from MessageEntity m where m.id = (select max(m.id) from MessageEntity m where m.sender.chatBoxId=:chatBoxId)")
    MessageEntity findLastMessageByChatBoxId(@Param("chatBoxId") Long chatBoxId);

    @Query("select max(m.id) from MessageEntity m where m.sender.id=?1")
    Long findIdLastMessageBySenderId(Long senderId);

    @Query("select distinct message FROM MessageEntity message" +
            " join MessengerEntity messenger on messenger.id = message.sender.id" +
            " join ChatBoxEntity chatBox on chatBox.id = messenger.chatBoxId and chatBox.id=:chatBoxId and message.id > :maxId ORDER by message.id desc")
    List<MessageEntity> findMessageNeedUpdate(@Param("chatBoxId") Long chatBoxId, @Param("maxId") Long maxId);
}