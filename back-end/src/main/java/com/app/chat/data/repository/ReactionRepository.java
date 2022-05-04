package com.app.chat.data.repository;

import com.app.chat.data.entities.Reaction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReactionRepository extends JpaRepository<Reaction, Long> {
    Reaction findByCode(String code);
}
