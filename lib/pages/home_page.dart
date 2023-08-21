import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  final String textTitle = 'TODOO';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    //if this is the first time opening app, create default data
    if (_mybox.get('TODOLİST') == null) {
      db.createInitialData();
    } else {
      //there already exits data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void chechBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([
        _controller.text,
        false,
        _controller.clear(),
      ]);
      Navigator.of(context).pop();
      db.updateDatabase();
    });
  }

  //Create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: const Center(
              child: Text(
            'TODOO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 50,
            ),
          )),
          shape: borderRadiusCircular(),
        ),
        floatingActionButton: floatingButton(),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => chechBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }

  RoundedRectangleBorder borderRadiusCircular() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    );
  }

  FloatingActionButton floatingButton() {
    return FloatingActionButton(
      onPressed: createNewTask,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.blue[800],
      splashColor: Colors.white,
    );
  }
}
