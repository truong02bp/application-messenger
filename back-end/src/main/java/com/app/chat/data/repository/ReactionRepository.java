package com.app.chat.data.repository;

import com.app.chat.data.entities.ReactionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReactionRepository extends JpaRepository<ReactionEntity, Long> {
    ReactionEntity findByCode(String code);
}
