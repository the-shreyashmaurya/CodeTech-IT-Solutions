import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/main_screen.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoModel todoModel;
  const EditTodoScreen({super.key, required TodoModel this.todoModel});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.todoModel.dueDate;
    titleController.text = widget.todoModel.title;
    descriptionController.text = widget.todoModel.description;
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
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    //  Date Picker
                    Row(
                      children: [
                        Text("Date : "),
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: 140,
                      height: 60,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(1)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          var todoBox = Hive.box("todoBox");

                          // Make a todoModel
                          TodoModel myTodo = TodoModel(
                              id: widget.todoModel.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              dueDate: selectedDate,
                              isDone: widget.todoModel.isDone);

                          // Put the edited model to Local Storage
                          List todoList = todoBox.values.toList();
                          for (var i in todoBox.values) {
                            if (i.id == widget.todoModel.id) {
                              Hive.box("todoBox")
                                  .putAt(todoList.indexOf(i), myTodo);
                            }
                          }
                          // myTodo.save();

                          // Navigate back to main page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        child: Text("Edit"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2040),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
