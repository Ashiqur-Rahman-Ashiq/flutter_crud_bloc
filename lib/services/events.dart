import 'models.dart';

abstract class StudentEvent{}


class setStudents extends StudentEvent{
  List<Student> studentsList;

  setStudents(List<Student> student){
    studentsList = student;
  }
}

class addStudent extends StudentEvent{
  Student newStudent;

  addStudent(Student student){
    newStudent =student;
  }
}

class deleteStudent extends StudentEvent{
  int studentIndex;

  deleteStudent(int index){
    studentIndex=index;
  }
}

class updateStudent extends StudentEvent{
  int studentIndex;
  Student newStudent;

  updateStudent(int index,Student student){
    studentIndex=index;
    newStudent=student;
  }
}