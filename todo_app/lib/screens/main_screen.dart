import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/screens/add_todo_screen.dart';
import 'package:todo_app/widgets/tile_widget2.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var todoBox = Hive.box("todoBox");
  List todoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList = todoBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.jpg"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Your Todo's",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black54,
                ),
                SizedBox(
                  height: 20,
                ),
                ReorderableListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    onReorder: (oldIndex, newIndex) async {
                      // Some Changes are needed while moving downwards
                      if (oldIndex < newIndex) {
                        newIndex--;
                      }

                      // Get the tile we are moving
                      var tile = todoList.removeAt(oldIndex);

                      //Place the tile in new position
                      todoList.insert(newIndex, tile);

                      await todoBox.clear();

                      for (var todo in todoList) {
                        todoBox.add(todo);
                      }

                      setState(() {});
                    },
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return TileWidget2(index: index,todoList: todoList,
                        
                        key: Key("$index"),
                      );
                    })
              ,SizedBox(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodoScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> updateTodoListPositions() async {
    for (int i = 0; i < todoList.length; i++) {
      await todoList[i].save(); // Update each item in the Hive box
    }
  }
}

