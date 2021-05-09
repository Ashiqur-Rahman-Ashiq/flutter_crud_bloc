import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/student_bloc.dart';
import 'screens/student_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
        create: (context) => StudentBloc(([])),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          //canvasColor: Colors.indigo[100],
        ),
        home: StudentForm(),
      ),
    );
  }
}
