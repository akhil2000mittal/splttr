import 'package:splttr/dataPages/group.dart';
import 'datahelper.dart';
  class GroupQuery
    {var data = DBHelper();
  Future<Group> saveGroup(Group group) async {
    var dbClient = await data.db;
    await dbClient.insert('Groups', group.toMap());
    return group;
  }

  Future<List<Group>> getGroups() async {
    var dbClient = await data.db;
    // List<Map> maps = await dbClient.query('Groups', columns: ['id', 'groupname']);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM Groups");
    List<Group> groups = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        groups.add(Group.fromMap(maps[i]));
      }
    }
    return groups;
  }

  Future<List<String>> getGroupNames() async {
    var dbClient = await data.db;
    // List<Map> groupNames = await dbClient.query('Groups', columns: ['groupname']);
    List<Map> groupNames = await dbClient.rawQuery("SELECT * FROM Groups");
    List<String> groupName = [];
    if (groupNames.length > 0) {
      for (int i = 0; i < groupNames.length; i++) {
        groupName.add(Group.fromMap(groupNames[i]).groupName);
      }
    }
    return groupName;
  }
  Future<Group> groupDetails(String groupName) async {
    var dbClient = await data.db;
  List<Map> result = await dbClient.rawQuery('SELECT * FROM Groups WHERE groupName=?', [groupName]);
    var a;
    result.forEach((row) => a = Group.fromMap(row));
    return a;
  }
  
}