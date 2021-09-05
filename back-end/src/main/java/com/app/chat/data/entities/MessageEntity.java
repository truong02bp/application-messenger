package com.app.chat.data.entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "message")
public class MessageEntity extends BaseEntity {

    @Column(name = "content")
    private String content;

    @ManyToOne
    @JoinColumn(name = "sender_id")
    private MessengerEntity sender;

    @ManyToOne
    @JoinColumn(name = "media_id")
    private MediaEntity media;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "message_id")
    private List<MessageDetailEntity> details;
    
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public MessengerEntity getSender() {
        return sender;
    }

    public void setSender(MessengerEntity sender) {
        this.sender = sender;
    }

    public MediaEntity getMedia() {
        return media;
    }

    public void setMedia(MediaEntity media) {
        this.media = media;
    }

    public List<MessageDetailEntity> getDetails() {
        return details;
    }

    public void setDetails(List<MessageDetailEntity> details) {
        this.details = details;
    }
}
