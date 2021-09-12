package com.app.chat.data.repository;

import com.app.chat.data.entities.FriendShipEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface FriendShipRepository extends JpaRepository<FriendShipEntity, Long> {

    @Query(value = "select friendShip from FriendShipEntity friendShip where (friendShip.user.id =?1 and friendShip.friend.id=?2) or (friendShip.user.id=?2 and friendShip.friend.id = ?1)")
    FriendShipEntity findFriendShip(Long userId, Long userId2);
}
