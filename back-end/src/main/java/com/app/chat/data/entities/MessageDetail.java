package com.app.chat.data.entities;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "message_detail")
public class MessageDetail extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "reaction_id")
    private Reaction reaction;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "seen_by")
    private Messenger seenBy;

    public Reaction getReaction() {
        return reaction;
    }

    public void setReaction(Reaction reaction) {
        this.reaction = reaction;
    }

    public Messenger getSeenBy() {
        return seenBy;
    }

    public void setSeenBy(Messenger seenBy) {
        this.seenBy = seenBy;
    }
}
