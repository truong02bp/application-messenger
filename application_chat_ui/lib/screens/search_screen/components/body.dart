import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/friend_ship_bloc.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc_event/friend_ship_event.dart';
import 'package:messenger_ui/bloc_event/user_event.dart';
import 'package:messenger_ui/bloc_state/friend_ship_state.dart';
import 'package:messenger_ui/bloc_state/user_state.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/dto/user_contact.dart';
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Body extends StatefulWidget {
  final String keySearch;

  Body({required this.keySearch});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<UserContact> userContacts = [];
  late UserBloc _userBloc;
  late FriendShipBloc _friendShipBloc;
  int page = 0;
  int size = 15;
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _friendShipBloc = BlocProvider.of<FriendShipBloc>(context);
    _userBloc
        .add(GetUserContact(name: widget.keySearch, page: page, size: size));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('${page + 1}');
        _userBloc.add(
            GetUserContact(page: page + 1, size: size, name: widget.keySearch));
        setState(() {
          page = page + 1;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant Body oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.keySearch != oldWidget.keySearch) {
      print('${widget.keySearch} ${oldWidget.keySearch} update');
      setState(() {
        page = 0;
        _userBloc
            .add(GetUserContact(name: widget.keySearch, page: 0, size: size));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is GetUserContactSuccess) {
          setState(() {
            if (page == 0) userContacts.clear();
            userContacts.addAll(state.userContacts);
          });
        }
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            children: [
              BlocBuilder(
                bloc: _userBloc,
                builder: (context, state) {
                  if (state is Loading) {
                    return Flexible(
                      flex: 2,
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/loading.gif"),
                                fit: BoxFit.cover)),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: userContacts.length,
                  addAutomaticKeepAlives: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${userContacts[index].user.name}',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                            userContacts[index].friendShip == null ||
                                    userContacts[index].friendShip!.accepted ==
                                        false
                                ? Spacer()
                                : Container(),
                            BlocBuilder(
                              bloc: _friendShipBloc,
                              builder: (context, state) {
                                User user = userContacts[index].user;
                                if (state is SendAddFriendSuccess && state.friendShip.friend.id == user.id) {
                                  userContacts[index].friendShip = state.friendShip;
                                }
                                // if (state is DeleteFriendShipSuccess && state.friendShipId == user.id)
                                FriendShip? friendShip = userContacts[index].friendShip;
                                if (friendShip != null && state is DeleteFriendShipSuccess && friendShip.id == state.friendShipId) {
                                  friendShip = null;
                                  userContacts[index].friendShip = null;
                                }
                                if (friendShip == null) {
                                  return InkWell(
                                      key: ValueKey(user.id),
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        _friendShipBloc.add(AddFriendEvent(friend: user));
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(7),
                                          child: Image.asset(
                                            "assets/images/add_friend.png",
                                            color: Colors.white,
                                          )));
                                }
                                else {
                                  if (state is ConfirmFriendShipSuccess && state.friendShip.id == friendShip.id) {
                                    friendShip = state.friendShip;
                                  }
                                  if (friendShip.accepted)
                                    return Container();
                                  else {
                                    if (friendShip.user.id == user.id) {
                                      if (friendShip.friend.id == user.id)
                                        return Container();
                                      return InkWell(
                                        onTap: () {
                                          _friendShipBloc.add(ConfirmFriendShipEvent(friendShipId: friendShip!.id!));
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(child: Text('Confirm'))
                                        ),
                                      );
                                    }
                                    else {
                                      return InkWell(
                                        onTap: () {
                                          _friendShipBloc.add(DeleteFriendShipEvent(friendShipId: friendShip!.id!));
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(0.9),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(child: Text('Delete'))
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CachedNetworkImage(
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset('assets/images/loading.gif');
                            },
                            imageUrl:
                                minioUrl + userContacts[index].user.avatar.url,
                          ),
                        ),
                      onTap: (){
                          if (userContacts[index].friendShip != null && userContacts[index].friendShip!.accepted) {
                            // solve here
                          }
                          else {
                            // solve here
                          }
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
