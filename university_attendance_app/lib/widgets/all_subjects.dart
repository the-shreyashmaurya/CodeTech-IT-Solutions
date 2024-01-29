import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';

class all_subjects extends StatefulWidget {
  String currentStudentCourse = "";

  all_subjects({
    super.key,
    required this.currentStudentCourse,
  });

  @override
  State<all_subjects> createState() => _all_subjectsState();
}

class _all_subjectsState extends State<all_subjects> {
  String CourseName = "";
  @override
  void initState() {
    // TODO: implement initState
    CourseName = widget.currentStudentCourse;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(125, 58, 58, 58),
                offset: Offset(0, 4),
                blurRadius: 4,
                blurStyle: BlurStyle.outer)
          ],
          color: Colors.white60,
        ),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CourseName",
              style: impNormalTextStyle,
            ),
            Text(
              "Instructor",
              style: normalTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
