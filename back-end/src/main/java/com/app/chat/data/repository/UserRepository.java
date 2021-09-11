package com.app.chat.data.repository;

import com.app.chat.data.entities.UserEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity,Long> {

    UserEntity findByUsername(String username);
    UserEntity findByEmail(String email);

    @Query(value = "select user from UserEntity user where user.name like %:name%")
    List<UserEntity> findAllByName(@Param("name") String name, Pageable pageable);
}