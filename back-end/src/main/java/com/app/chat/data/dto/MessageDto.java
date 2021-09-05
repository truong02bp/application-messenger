package com.app.chat.data.dto;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class MessageDto {
    private Long chatBoxId;
    private Long messengerId;
    private Long messageId;
    private Long mediaId;
    private boolean isMedia;
    private String reaction;
    private byte[] bytes;
    private String content;
    private String name;

    public Long getMediaId() {
        return mediaId;
    }

    public void setMediaId(Long mediaId) {
        this.mediaId = mediaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getBytes() {
        return bytes;
    }

    public void setBytes(byte[] bytes) {
        this.bytes = bytes;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getChatBoxId() {
        return chatBoxId;
    }

    public void setChatBoxId(Long chatBoxId) {
        this.chatBoxId = chatBoxId;
    }

    public Long getMessengerId() {
        return messengerId;
    }

    public void setMessengerId(Long messengerId) {
        this.messengerId = messengerId;
    }

    public Long getMessageId() {
        return messageId;
    }

    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }


    public boolean getIsMedia() {
        return isMedia;
    }

    public void setIsMedia(boolean media) {
        isMedia = media;
    }

    public String getReaction() {
        return reaction;
    }

    public void setReaction(String reaction) {
        this.reaction = reaction;
    }
}
