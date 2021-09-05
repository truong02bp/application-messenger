package com.app.chat.data.entities;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "message_detail")
public class MessageDetailEntity extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "reaction_id")
    private ReactionEntity reaction;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "seen_by")
    private MessengerEntity seenBy;

    public ReactionEntity getReaction() {
        return reaction;
    }

    public void setReaction(ReactionEntity reaction) {
        this.reaction = reaction;
    }

    public MessengerEntity getSeenBy() {
        return seenBy;
    }

    public void setSeenBy(MessengerEntity seenBy) {
        this.seenBy = seenBy;
    }
}
