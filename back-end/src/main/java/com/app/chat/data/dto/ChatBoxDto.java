package com.app.chat.data.dto;

import com.app.chat.data.entities.Message;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.app.chat.data.entities.Media;
import com.app.chat.data.entities.Messenger;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class ChatBoxDto extends BaseDto {
    private String color;
    private String name;
    private Boolean isGroup;
    private Media image;
    private Messenger currentUser;
    private List<Messenger> guestUser;
    private Message lastMessage;

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

    public Boolean getIsGroup() {
        return isGroup;
    }

    public void setGroup(Boolean group) {
        isGroup = group;
    }

    public Media getImage() {
        return image;
    }

    public void setImage(Media image) {
        this.image = image;
    }

    public Messenger getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(Messenger currentUser) {
        this.currentUser = currentUser;
    }

    public List<Messenger> getGuestUser() {
        return guestUser;
    }

    public void setGuestUser(List<Messenger> guestUser) {
        this.guestUser = guestUser;
    }

    public Message getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(Message lastMessage) {
        this.lastMessage = lastMessage;
    }
}
