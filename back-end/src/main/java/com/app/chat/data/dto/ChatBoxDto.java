package com.app.chat.data.dto;

import com.app.chat.data.entities.MessageEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.app.chat.data.entities.MediaEntity;
import com.app.chat.data.entities.MessengerEntity;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class ChatBoxDto extends BaseDto {
    private String color;
    private String name;
    private boolean isGroup = false;
    private boolean isNew = false;
    private MediaEntity image;
    private MessengerEntity currentUser;
    private List<MessengerEntity> guestUser;
    private MessageEntity lastMessage;

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean getIsGroup() {
        return isGroup;
    }

    public void setIsGroup(boolean isGroup) {
        isGroup = isGroup;
    }

    public boolean getIsNew() {
        return isNew;
    }

    public void setIsNew(boolean isNew) {
        isNew = isNew;
    }

    public MediaEntity getImage() {
        return image;
    }

    public void setImage(MediaEntity image) {
        this.image = image;
    }

    public MessengerEntity getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(MessengerEntity currentUser) {
        this.currentUser = currentUser;
    }

    public List<MessengerEntity> getGuestUser() {
        return guestUser;
    }

    public void setGuestUser(List<MessengerEntity> guestUser) {
        this.guestUser = guestUser;
    }

    public MessageEntity getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(MessageEntity lastMessage) {
        this.lastMessage = lastMessage;
    }
}
