import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/database.dart';
import 'package:to_do_app/to_do_tile.dart';
import 'dialog.dart';

void main() async{

  //inititialize the hive
  await Hive.initFlutter();

  // open the box
  var box = await Hive.openBox('mybox');



  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: home(),
  )
  );
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  //reference the hive box

  final _myBox=Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState(){

    // if this is the first time opening the app , then create default data
    if(_myBox.get('TODOLIST')==null){
      db.createInitialData();
    }
    else{
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();


  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Create new task
  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return dialog(
        controller: _controller,
        onCancel: () => Navigator.of(context).pop(),
        onSave: saveNewTask,);
    },
    );
    db.updateDataBase();
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A434E),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF92BBED),
                Colors.transparent,
              ],
            ),
          ),
        ),
        title: const Text(
            "TO  DO",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF92BBED)
            )
        ),
        centerTitle: true,
      ),

      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: const Color(0xFF92BBED),
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return todotile(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index)
            );
          }
      ),
    );
  }
}
