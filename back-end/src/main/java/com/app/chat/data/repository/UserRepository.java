package com.app.chat.data.repository;

import com.app.chat.data.entities.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepository extends JpaRepository<User,Long> {

    User findByUsername(String username);
    User findByEmail(String email);

    @Query(value = "select user from User user where user.name like %:name%")
    List<User> findAllByName(@Param("name") String name, Pageable pageable);

    @Query(value = "select user from User user where user.id in ?1")
    List<User> findByUserIds(List<Long> ids);
}