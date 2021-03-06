import 'package:flutter/material.dart';
import 'package:splttr/pages/home/owes_dues_chart.dart';
import 'package:splttr/pages/home/owes_dues_list.dart';
import 'package:splttr/widgets/empty_list_message.dart';
import 'package:splttr/res/dummy_data.dart';
import 'package:splttr/widgets/two_button_row.dart';
import 'package:splttr/dataPages/user.dart';

class Home extends StatefulWidget {
  final User signinedUser;
  Home(this.signinedUser);
  @override
  _HomeState createState() => _HomeState(signinedUser);
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final _usersOweYouList = DummyData.usersOweYouList;
  final _youOweUsersList = DummyData.youOweUsersList;
  final User signinedUser;
  _HomeState(this.signinedUser);

  List<Widget> _buildListViewItems() {
    List<Widget> items = [
      Container(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.25,
          height: MediaQuery.of(context).size.width / 1.25,
          child: OwesDuesChart(),
        ),
      ),
      TwoButtonRow(
        buttonOneText: 'Add a friend',
        buttonOneOnPressed: (){},
        buttonTwoText: 'Split an Expense',
        buttonTwoOnPressed: (){},
      ),
    ];
    if ((_youOweUsersList.length == 0) && (_usersOweYouList.length == 0)) {
      items.add(EmptyListEmoticonMessage(
        message: 'All your dues are clear :)',
        emotion: Emotion.happy,
      ));
    } else {
      if (_usersOweYouList.length > 0) {
        items
            .add(OwesOrDuesList(userList: _usersOweYouList, userOwesYou: true));
      }
      if (_youOweUsersList.length > 0) {
        items.add(
            OwesOrDuesList(userList: _youOweUsersList, userOwesYou: false));
      }
    }
    return items;
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(children: _buildListViewItems());
  }
}
