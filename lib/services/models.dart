import 'db_provider.dart';

class Student {
  int id;
  String name;
  String roll;
  String dept;
  String session;

  Student({this.id, this.name, this.roll, this.dept, this.session});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_ID: id,
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_ROLL: roll,
      DatabaseProvider.COLUMN_DEPT: dept,
      DatabaseProvider.COLUMN_SESSION: session,
    };
    return map;
  }

  Student.formMap(Map<String,dynamic>map){
    id=map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    roll =map[DatabaseProvider.COLUMN_ROLL];
    dept = map[DatabaseProvider.COLUMN_DEPT];
    session = map[DatabaseProvider.COLUMN_SESSION];
  }
}



