import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/screens/group/bloc/group_bloc.dart';
import 'package:messenger_ui/screens/group/bloc/group_event.dart';
import 'package:messenger_ui/screens/group/bloc/group_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:messenger_ui/screens/home/home_screen.dart';

import '../../../host_api.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late GroupBloc _groupBloc;
  List<FriendShip> friendShips = [];
  Set<int> selectedIds = Set();
  List<User> usersSelected = [];
  String name = "";
  int page = 0;
  int size = 15;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _groupBloc = BlocProvider.of<GroupBloc>(context);
    _groupBloc.add(GetFriendShipEvent(page: 0, size: size, name: name));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _groupBloc
            .add(GetFriendShipEvent(page: page + 1, size: size, name: name));
        page = page + 1;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _groupBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    User user = arguments["user"];
    selectedIds.add(user.id);
    final border = UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: Colors.deepOrangeAccent, width: 0.8));
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width*4/5,
              ),
              child: TextFormField(
                onChanged: (value) {
                  friendShips.clear();
                  name = value;
                  page = 0;
                  _groupBloc
                      .add(GetFriendShipEvent(page: page, size: size, name: name));
                },
                decoration: InputDecoration(
                  focusedBorder: border,
                  enabledBorder: border,
                  errorBorder: border,
                  disabledBorder: border,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'Add people',
                  hintStyle: TextStyle(
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              splashColor: Colors.red,
              onTap: (){
                _groupBloc.add(CreateGroupEvent(userIds: selectedIds));
              },
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(18)
                ),
                child: Center(child: Text('Create')),
              ),
            ),
            SizedBox(width: 10,)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder(
          bloc: _groupBloc,
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
        Flexible(
          flex: 1,
          child: BlocConsumer(
            bloc: _groupBloc,
            listener: (context, state) {
              if (state is AddMemberSuccess) {
                usersSelected.add(state.user);
              }
              if (state is RemoveMemberSuccess) {
                usersSelected.remove(state.user);
                selectedIds.remove(state.user.id);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    usersSelected.length,
                    (index) => Stack(children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CachedNetworkImage(
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset('assets/images/loading.gif');
                            },
                            imageUrl:
                                minioUrl + usersSelected[index].avatar.url,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            _groupBloc.add(RemoveMemberEvent(user: usersSelected[index]));
                          },
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(9)),
                            child: FittedBox(
                              child: Icon(
                                Icons.close,
                                color: Colors.deepOrangeAccent,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocConsumer(
            bloc: _groupBloc,
            listener: (context, state) {
              if (state is GetFriendShipSuccess) {
                if (page == 0) {
                  friendShips.clear();
                }
                friendShips.addAll(state.friendShips);
              }
              if (state is AddMemberSuccess) {
                selectedIds.add(state.user.id);
              }
              if (state is CreateGroupSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false, arguments: {"user" : user});
              }
            },
            builder: (context, state) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  FriendShip friendShip = friendShips[index];
                  User friend = friendShip.user.id == user.id
                      ? friendShip.friend
                      : friendShip.user;
                  if (selectedIds.contains(friend.id)) {
                    return Container();
                  }
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: CachedNetworkImage(
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset('assets/images/loading.gif');
                        },
                        imageUrl: minioUrl + friend.avatar.url,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${friend.name}'),
                        Checkbox(
                          onChanged: (bool? value) {
                            if (value == true) {
                              _groupBloc.add(AddMemberEvent(user: friend));
                            }
                          },
                          value: false,
                          fillColor: MaterialStateProperty.all(
                              Colors.deepOrangeAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: friendShips.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
