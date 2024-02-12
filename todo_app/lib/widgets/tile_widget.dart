import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.index,
    required this.todoList,
  });

  final List todoList;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key("$index"),
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        isThreeLine: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.check_box_outline_blank_rounded),
        ),
        title: Text(todoList[index].title),
        titleTextStyle: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        subtitle: Text(
          '${todoList[index].description} \nDue : ${todoList[index].dueDate}',
          textAlign: TextAlign.justify,
        ),
        trailing: Container(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.edit),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ),
        tileColor: Colors.white60,
      ),
    );
  }
}
