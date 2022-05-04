package com.app.chat.data.repository;

import com.app.chat.data.entities.FriendShip;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FriendShipRepository extends JpaRepository<FriendShip, Long> {

    @Query(value = "select friendShip from FriendShip friendShip where (friendShip.user.id =?1 and friendShip.friend.id=?2) or (friendShip.user.id=?2 and friendShip.friend.id = ?1)")
    FriendShip findFriendShip(Long userId, Long userId2);

    @Query(value = "select friendShip from FriendShip friendShip where" +
            "(friendShip.user.id = ?1 and friendShip.friend.name like %?2%) or" +
            " (friendShip.friend.id = ?1 and friendShip.user.name like %?2%)")
    List<FriendShip> findAllByUserIdAndName(Long userId, String name, Pageable pageable);

}
