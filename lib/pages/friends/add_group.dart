import 'package:flutter/material.dart';
import 'package:splttr/pages/pick_avatar_screen.dart';
import 'package:splttr/widgets/pick_avatar.dart';
import 'package:splttr/pages/choose_participants.dart';
import 'package:splttr/dataPages/user.dart';
import 'package:splttr/database/userQuery.dart';
import 'package:splttr/dataPages/group.dart';
import 'package:splttr/database/groupQuery.dart';

class AddGroup extends StatefulWidget {
  final User signinedUser;
  AddGroup({this.signinedUser});
  @override
  _AddGroupState createState() => _AddGroupState(signinedUser);
}

class _AddGroupState extends State<AddGroup> {
  final _formKey = GlobalKey<FormState>();
  final User signinedUser;
  _AddGroupState(this.signinedUser);
  String _groupAvatar = '';
  DateTime _dateOfCreation;
  var db;
  var db2 = GroupQuery();
  TextEditingController _groupNameController;
  TextEditingController _groupDescriptionController;
  List<User> _friendsList = [];
  getUsers() async {
    db = UserQuery();
    var userNamesList;
    var userDetails;
    userNamesList = await db.getUserNames();
    for (int i = 0; i < userNamesList.length; i++) {
      if (signinedUser.username != userNamesList[i]) {
        userDetails = await db.userDetails(userNamesList[i]);
        _friendsList.add(userDetails);
      }
    }
  }

  bool validGroupName = true;
  Future registerGroup(Group newgroup) async {
    db2.saveGroup(newgroup);
    // users.forEach((user)=> print(user));
    // await Future.delayed(Duration(seconds: 3));
  }

  Future<List> getGroupNames() async {
    var groupNames = await db2.getGroupNames();
    return groupNames;
  }

  Future<bool> checkUsernameExists(String value) async {
    var groupNames = await getGroupNames();
    if (!groupNames.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  void processGroupData() async {
    validGroupName = await checkUsernameExists(_groupNameController.text);
    if (!validGroupName) {
      setState(() {
        validGroupName = false;
        _formKey.currentState.validate();
      });
    } else {
      setState(() {
      });
      Group newgroup = Group(
        groupName: _groupNameController.text,
        groupDec: _groupDescriptionController.text,
        avtar: _groupAvatar,
        doc: _dateOfCreation
      );
      

      registerGroup(newgroup).then((_) =>Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChooseParticipants(
                                  friendsList: _friendsList,
                                  enableSelectionByGroup: true,
                                )),
                      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();
    _groupDescriptionController = TextEditingController();
    getUsers();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width / 3 + 200,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/friends-banner.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PickAvatar(
                              radius: MediaQuery.of(context).size.width / 6,
                              avatar: _groupAvatar,
                              onTap: () async {
                                _groupAvatar = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PickAvatarScreen(),
                                  ),
                                );
                                setState(() {});
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                ' Choose group avatar ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontFamily: 'Montserrat',
                                      backgroundColor: Colors.white54,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SafeArea(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: null,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                  top: 24.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: TextFormField(
                  controller: _groupNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Group Name';
                    }
                    if (!validGroupName) {
                      validGroupName = true;
                      return 'Already exists. Try something else';
                    }
                    return null;
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Group Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                // padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  controller: _groupDescriptionController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Description',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Text('No friends in this group')),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 75,
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _dateOfCreation = DateTime.now();
                      processGroupData();
                    }
                  },
                  child: Text(
                    'Select members',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
