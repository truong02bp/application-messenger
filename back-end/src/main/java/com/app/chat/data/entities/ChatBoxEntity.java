package com.app.chat.data.entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.List;

@Entity
@Table(name = "chat_box")
public class ChatBoxEntity extends BaseEntity {

    @Column(name = "color")
    private String color;

    @Column(name = "name")
    private String name;

    @Column(name = "is_group")
    private Boolean isGroup = false;

    @ManyToOne
    @JoinColumn(name = "image_id")
    private MediaEntity image;

    @JsonManagedReference
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "chat_box_id")
    private List<MessengerEntity> messengers;

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

    public MediaEntity getImage() {
        return image;
    }

    public void setImage(MediaEntity image) {
        this.image = image;
    }

    public List<MessengerEntity> getMessengers() {
        return messengers;
    }

    public void setMessengers(List<MessengerEntity> messengers) {
        this.messengers = messengers;
    }
}
