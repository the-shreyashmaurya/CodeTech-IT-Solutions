import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/edit_todo_screen.dart';
import 'package:todo_app/screens/main_screen.dart';

class TileWidget2 extends StatelessWidget {
  final List todoList;
  final index;
  const TileWidget2({super.key, required this.todoList, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white60),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              IconButton(
                onPressed: () {
                  TodoModel myTodo;
                  // Change isDone Status
                  if (todoList[index].isDone == false) {
                    // Make a todoModel isDone = true
                    myTodo = TodoModel(
                        id: todoList[index].id,
                        title: todoList[index].title,
                        description: todoList[index].description,
                        dueDate: todoList[index].dueDate,
                        isDone: true);
                  } else {
                    // Make a todoModel isDone = false
                    myTodo = TodoModel(
                        id: todoList[index].id,
                        title: todoList[index].title,
                        description: todoList[index].description,
                        dueDate: todoList[index].dueDate,
                        isDone: false);
                  }

                  //  Put updated values in local storage
                  Hive.box("todoBox").putAt(index, myTodo);

                  // Refresh page
                  // Navigate back to main page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
                icon: todoList[index].isDone ? Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
              ),

              // Title and description
              Expanded(
                // width: 100,

                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        todoList[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      Text(
                        todoList[index].description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Due Date :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Text(
                          "${todoList[index].dueDate}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTodoScreen(
                                        todoModel: todoList[index])));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            for (var i in todoList) {
                              if (i.id == todoList[index].id) {
                                Hive.box("todoBox")
                                    .deleteAt(todoList.indexOf(i));
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
