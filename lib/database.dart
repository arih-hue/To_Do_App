import 'package:hive_flutter/hive_flutter.dart';
class ToDoDatabase{

  List todoList=[];
  // reference
  final _myBox=Hive.box('myBox');

  //if this the first time ever opening this app
  void createInitialData(){
    todoList=[
      ["Make Tutorial",false],
      ["Do Exercise",false],
    ];
  }

  //load data from data base
  void loadData(){
    todoList=_myBox.get('TODOLIST');
  }

//update the database
  void updateDataBase(){
    _myBox.put('TODOLIST', todoList);
  }

}