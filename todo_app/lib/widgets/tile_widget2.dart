import 'package:flutter/material.dart';

class TileWidget2 extends StatelessWidget {
  final List todoList;
  final index;
  const TileWidget2({super.key, required this.todoList, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white60),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.check_box),
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
                          "31/12/2002",
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
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete,color: Colors.red,),
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
