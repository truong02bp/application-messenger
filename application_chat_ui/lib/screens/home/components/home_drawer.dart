import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc_event/user_event.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:messenger_ui/screens/group/group_screen.dart';
import 'package:messenger_ui/screens/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/screens/profile/profile_screen.dart';
class HomeDrawer extends StatelessWidget {
  final User user;

  HomeDrawer({required this.user});

  @override
  Widget build(BuildContext context) {
    UserBloc _userBloc = BlocProvider.of<UserBloc>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.wb_sunny)
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: (){
                  Navigator.pushNamed(context, ProfileScreen.routeName, arguments: {"user" : user});
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset('assets/images/loading.gif');
                      },
                      imageUrl: minioUrl + user.avatar.url,
                    )),
              ),
              Text(
                '${user.name}',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              )
            ],
          )),
      buildItem(icon: Icon(Icons.group, color: Color(0xfff78379).withOpacity(0.8)), title: 'New group', onTap: (){
        Navigator.pushNamed(context, GroupScreen.routeName, arguments: {"user" : user});
      }),
      buildItem(icon: Icon(Icons.location_history_rounded, color: Color(0xfff78379).withOpacity(0.8)), title: 'Contacts', onTap: (){}),
      buildItem(icon: Icon(Icons.location_on, color: Color(0xfff78379).withOpacity(0.8)), title: 'People Nearby', onTap: (){}),
      buildItem(icon: Icon(Icons.save_rounded, color: Color(0xfff78379).withOpacity(0.8)), title: 'Saved Messages', onTap: (){}),
      buildItem(icon: Icon(Icons.settings, color: Color(0xfff78379).withOpacity(0.8)), title: 'Settings', onTap: (){}),
      buildItem(icon: Icon(Icons.share, color: Color(0xfff78379).withOpacity(0.8)), title: 'Invite Friends', onTap: (){}),
      buildItem(icon: Icon(Icons.logout, color: Color(0xfff78379).withOpacity(0.8)), title: 'Log out', onTap: (){
        _userBloc.add(UpdateOfflineEvent());
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (r) => false);
      }),
    ]);
  }

  Widget buildItem({required Icon icon, required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
        child: Row(
          children: [
            icon,
            SizedBox(width: 20,),
            Text('$title',
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15),),
          ],
        ),
      ),
    );
  }
}
