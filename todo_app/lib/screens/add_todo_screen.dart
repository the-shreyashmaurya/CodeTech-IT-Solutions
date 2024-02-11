import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/main_screen.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.jpg"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  label: Text("Description"),
                ),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  label: Text("Date"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var todoBox = Hive.box("todoBox");

                  // Make a todoModel
                  TodoModel myTodo = TodoModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      dueDate: dateController.text);

                  // Add to todoBox
                  todoBox.add(myTodo);
                  // myTodo.save();

                  // Navigate back to main page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
