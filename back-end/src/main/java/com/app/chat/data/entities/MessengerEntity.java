package com.app.chat.data.entities;

import javax.persistence.*;

@Entity
@Table(name =  "messenger")
public class MessengerEntity extends BaseEntity {

    @Column(name = "nick_name")
    private String nickName;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @Column(name = "chat_box_id", nullable = false)
    private Long chatBoxId;


    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

    public Long getChatBoxId() {
        return chatBoxId;
    }

    public void setChatBoxId(Long chatBoxId) {
        this.chatBoxId = chatBoxId;
    }
}
