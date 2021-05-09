import 'models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseProvider{
  static const String TABLE_STUDENT = 'dream';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'name';
  static const String COLUMN_ROLL = 'roll';
  static const String COLUMN_DEPT ='dept';
  static const String COLUMN_SESSION = 'session';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future <Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async{
    String dbPath= await getDatabasesPath();

    return await openDatabase(
     join(dbPath,'studentDB.db'),
     version:1,
      onCreate: (Database database,int version) async{
       await database.execute(
         "CREATE TABLE $TABLE_STUDENT("
             "$COLUMN_ID INTEGER PRIMARY KEY,"
             "$COLUMN_NAME TEXT,"
             "$COLUMN_ROLL TEXT,"
             "$COLUMN_DEPT TEXT,"
             "$COLUMN_SESSION TEXT"
             ")",
       );
      }
    );
  }


  Future<List<Student>> getStudents() async {
    final db = await database;

    var students = await db.query(
      TABLE_STUDENT,
      columns: [COLUMN_ID, COLUMN_NAME, COLUMN_ROLL,COLUMN_DEPT,COLUMN_SESSION],
      orderBy: '$COLUMN_ID desc',
    );

    List<Student> studentsList = [];

    students.forEach((currentDream) {
      Student student = Student.formMap(currentDream);

      studentsList.add(student);
    });

    return studentsList;
  }


  Future<Student> insert(Student student) async{
    final db= await database;
    student.id = await db.insert(TABLE_STUDENT, student.toMap());

    return student;
  }
  //
  Future<int> delete(int id) async{
    final db= await database;

    return await db.delete(
      TABLE_STUDENT,
      where: 'id=?',
      whereArgs: [id],
    );
  }
  //
  Future<int> update(Student student) async{
    final db= await database;

    return await db.update(
    TABLE_STUDENT,
    student.toMap(),
    where: 'id=?',
    whereArgs: [student.id],
    );
  }

}






