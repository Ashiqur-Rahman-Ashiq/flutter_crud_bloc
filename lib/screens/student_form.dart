import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import 'screens.dart';

class StudentForm extends StatefulWidget {
  final Student student;
  final int studentIndex;

  StudentForm({this.student,this.studentIndex});
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  String _name;
  String _roll;
  String _dept;
  String _session;

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    if(widget.student != null){
      _name=widget.student.name;
      _roll=widget.student.roll;
      _dept=widget.student.dept;
      _session=widget.student.session;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Information Form')),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.list),
        onPressed: () =>Navigator.push(
          context,
            MaterialPageRoute(
                builder: (BuildContext context) => StudentEntries(),
            ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25,),
              //Name
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color : Colors.indigoAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
                maxLength: 40,
                style: TextStyle(fontSize: 20),
                validator: (String value){
                  return value.isEmpty ? 'name is requerd' : null;
                },
                onSaved: (String value){
                  _name=value;
                },
              ),
              SizedBox(height: 25,),
              //Roll
              TextFormField(
                initialValue: _roll,
                decoration: InputDecoration(
                  labelText: 'Roll',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color : Colors.indigoAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
                maxLength: 8,
                style: TextStyle(fontSize: 20),
                validator: (String value){
                  return value.isEmpty ? 'Roll is requierd' : null;
                },
                onSaved: (String value){
                  _roll=value;
                },
              ),
              SizedBox(height: 25,),
              //DEPT
              TextFormField(
                initialValue: _dept,
                decoration: InputDecoration(
                  labelText: 'Department',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color : Colors.indigoAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
                maxLength: 12,
                style: TextStyle(fontSize: 20),
                validator: (String value){
                  return value.isEmpty ? 'Department is requred' : null;
                },
                onSaved: (String value){
                  _dept=value;
                },
              ),
              SizedBox(height: 25,),
              //Session
              TextFormField(
                initialValue: _session,
                decoration: InputDecoration(
                  labelText: 'Session',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color : Colors.indigoAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
                maxLength: 40,
                style: TextStyle(fontSize: 20),
                validator: (String value){
                  return value.isEmpty ? 'Session is requred' : null;
                },
                onSaved: (String value){
                  _session=value;
                },
              ),

              SizedBox(height: 25,),

              widget.student ==null
              ?ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16,color: Colors.white70),
                ),
                onPressed: (){
                  if(!_formKey.currentState.validate()){
                    return;
                  }
                  _formKey.currentState.save();

                  Student student = Student(
                    id:DateTime.now().microsecondsSinceEpoch,
                    name:_name,
                    roll:_roll,
                    dept:_dept,
                    session:_session,
                  );

                  DatabaseProvider.db.insert(student).then(
                      (storedStudent) =>
                      BlocProvider.of<StudentBloc>(context).add(
                          addStudent(storedStudent),
                      ),
                  );
                }
              )
              :ElevatedButton(
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                onPressed: (){
                  if(!_formKey.currentState.validate()){
                    return;
                  }
                  _formKey.currentState.save();

                  Student student = Student(
                    name:_name,
                    roll:_roll,
                    dept:_dept,
                    session:_session,
                  );

                  DatabaseProvider.db.update(student).then(
                      (updateStudentId) =>
                          BlocProvider.of<StudentBloc>(context).add(
                              updateStudent(widget.student.id,student),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
