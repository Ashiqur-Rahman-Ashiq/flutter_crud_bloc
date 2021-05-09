import 'services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentBloc extends Bloc<StudentEvent,List<Student>>{
  StudentBloc(List<Student> initialState) : super(initialState);

  @override
  Stream <List<Student>> mapEventToState(StudentEvent event) async*{
    if(event is setStudents){
      yield event.studentsList;
    }else if(event is addStudent){
      List<Student> newState= List.from(state);
      if(event.newStudent != null){
        newState.insert(0, event.newStudent);
      }
      yield newState;
    }else if(event is deleteStudent){
      List<Student> newState= List.from(state);
      if(event.studentIndex !=null){
        newState.removeAt(event.studentIndex);
      }
      yield newState;
    }
    else if (event is updateStudent){
      List<Student> newState = List.from(state);
      newState[event.studentIndex] = event.newStudent;
      yield newState;
    }
  }
}

