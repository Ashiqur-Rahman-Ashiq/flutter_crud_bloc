import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/services.dart';
import 'screens.dart';


class StudentEntries extends StatefulWidget {
  const StudentEntries({Key key}) : super(key : key);
  @override
  _StudentEntriesState createState() => _StudentEntriesState();
}

class _StudentEntriesState extends State<StudentEntries> {
  @override
  void initState(){
    super.initState();
    DatabaseProvider.db.getStudents().then(
            (studentsList){
              BlocProvider.of<StudentBloc>(context).add(setStudents(studentsList));
            }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students List'),),
      body:BlocConsumer<StudentBloc, List<Student>>(
        builder: (context, studentsList ) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: studentsList.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
            itemBuilder: (BuildContext context, int index) {
              Student student= studentsList[index];
              return GestureDetector(
                onTap: ()=>Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder:(context)=>
                            StudentForm(student:student,studentIndex: index),
                    ),
                ),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        tileColor: Colors.grey,
                        title:Text('Name: '+student.name,style: TextStyle(fontSize: 22,color: Colors.white70,),),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          iconSize: 36,
                          onPressed: () => DatabaseProvider.db.delete(student.id).then((_) {
                            BlocProvider.of<StudentBloc>(context).add(
                              deleteStudent(index),
                            );
                          }
                        ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Roll               :'+student.roll,style: TextStyle(fontSize: 20),),
                            Text('Department :'+student.dept,style: TextStyle(fontSize: 20),),
                            Text('Session         :'+student.session,style: TextStyle(fontSize: 20),),
                          ],
                        )
                      ),
                    ],

                  ),

                ),
              );
            },
          );
        },
        listener: (BuildContext context, dreamsList) {},
      ),
    );
  }
}

