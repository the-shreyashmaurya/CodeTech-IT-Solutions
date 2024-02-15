import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/student/student_database.dart';
import 'package:university_attendance_app/database/student/student_model.dart';

class StudentListItemWidget extends StatefulWidget {
  final String studentId;
  const StudentListItemWidget({super.key, required this.studentId});

  @override
  State<StudentListItemWidget> createState() => _StudentListItemWidgetState();
}

class _StudentListItemWidgetState extends State<StudentListItemWidget> {
  Map<String, dynamic> studentDetails = {};
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    isLoading = true;
    // Get Student details
    StudentModel studentModel =
        await StudentDatabase().getStudentDetails(id: widget.studentId);
    studentDetails = studentModel.toJson();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text("Loading..."),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name : ",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          studentDetails["name"],
                          style: normalTextStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "PRN : ",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          studentDetails["prn"],
                          style: normalTextStyle,
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade800,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
