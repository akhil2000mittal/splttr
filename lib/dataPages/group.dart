import 'package:intl/intl.dart';
class Group {
  String groupName;
  DateTime doc;
  String groupDec;
  String avtar;

  Group({this.groupName,this.doc,this.groupDec,this.avtar});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'groupName': groupName,
      'groupDec' : groupDec,
      'avtar': avtar,
      'doc': doc.toString()
    };
    return map;
  }
final DateFormat _dateformat = DateFormat('yyyy-MM-dd');
  Group.fromMap(Map<String, dynamic> map) {
    groupName = map['groupName'];
    groupDec = map['groupDec'];
    avtar = map['avtar'];
    doc =_dateformat.parse(map['doc']);
  }
}
