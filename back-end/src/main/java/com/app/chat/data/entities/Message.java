package com.app.chat.data.entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "message")
public class Message extends BaseEntity {

    @Column(name = "content")
    private String content;

    @ManyToOne
    @JoinColumn(name = "sender_id")
    private Messenger sender;

    @ManyToOne
    @JoinColumn(name = "media_id")
    private Media media;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "message_id")
    private List<MessageDetail> details;
    
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Messenger getSender() {
        return sender;
    }

    public void setSender(Messenger sender) {
        this.sender = sender;
    }

    public Media getMedia() {
        return media;
    }

    public void setMedia(Media media) {
        this.media = media;
    }

    public List<MessageDetail> getDetails() {
        return details;
    }

    public void setDetails(List<MessageDetail> details) {
        this.details = details;
    }
}
