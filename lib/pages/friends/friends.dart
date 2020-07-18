import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splttr/widgets/app_screen_title_with_image_widget.dart';
import 'package:splttr/widgets/empty_list_message.dart';
import 'package:splttr/widgets/small_avatar_tile.dart';
import 'package:splttr/dataPages/user.dart';
import 'package:splttr/widgets/two_button_row.dart';
import 'package:splttr/database/userQuery.dart';



class Friends extends StatefulWidget {
  final User signinedUser;
  Friends(this.signinedUser);
  @override
  _FriendsState createState() => _FriendsState(signinedUser);
}

class _FriendsState extends State<Friends> with AutomaticKeepAliveClientMixin {
  final User signinedUser;
  List<User> _friendsList = [];
  var db;
  _FriendsState(this.signinedUser);

  getUsers() async{
    db = UserQuery();
    var userNamesList;
    var userDetails;
    userNamesList = await db.getUserNames();
    for (int i = 0; i < userNamesList.length; i++) {
        if(signinedUser.username
         != userNamesList[i])
        {userDetails = await db.userDetails(userNamesList[i]);
        _friendsList.add(userDetails);}
      }
    setState(() {
    });
  }



  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: _friendsList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0)
          return AppScreenTitleWithImageWidget(
            imagePath: 'assets/images/friends.png',
            title: 'Friends',
            buttonRow: TwoButtonRow(
              buttonOneOnPressed: () {},
              buttonOneText: 'Manage groups',
              buttonTwoOnPressed: () {},
              buttonTwoText: 'Add friend',
            ),
            showEmptyListMessage: (_friendsList.length == 0),
            message: EmptyListEmoticonMessage(
              emotion: Emotion.sad,
              message:
                  'You haven\'t added any friends yet :(\nYou can share expenses with friends or a group of friends. Add someone you know to get started.',
            ),
          );
        index--;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: SmallAvatarTile(
            avatar: _friendsList[index].avtar,
            title: _friendsList[index].firstName +
                ' ' +
                _friendsList[index].lastName,
            subtitle: '@'+_friendsList[index].username,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.trashAlt,
                  size: 20,
                ),
                onPressed: () => print('trash'),
              ),
            ],
          ),
        );
      },
    );
  }
}
