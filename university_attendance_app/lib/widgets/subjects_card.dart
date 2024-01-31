import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_database.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';
// import 'package:university_attendance_app/database/courses/courses_database.dart';
// import 'package:university_attendance_app/database/courses/courses_model.dart';
// import 'package:university_attendance_app/screens/course_screen/course_screen.dart';

class SubjectsCard extends StatefulWidget {
  final String courseId;
  final String studentId;
  final String date;
  bool isLoading = true;
  Map<String, dynamic> courseDetails = {};
  SubjectsCard({
    super.key,
    required this.courseId,
    required this.studentId,
    required this.date,
  });

  @override
  State<SubjectsCard> createState() => _SubjectsCardState();
}

class _SubjectsCardState extends State<SubjectsCard> {
  getCourseDetails() async {
    CoursesModel courseDetailsModel =
        await CoursesDatabase().getCourseDetails(courseId: widget.courseId);
    var course = courseDetailsModel.toJson();
    setState(() {
      widget.courseDetails = course;
      widget.isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCourseDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true) {
      return Container(
        child: CircularProgressIndicator(),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          // Update Attendance
          await AttendanceRecordsDatabase()
              .updateAttendanceForCourse(widget.studentId, widget.courseId);
        },
        child: Container(
          margin: EdgeInsets.only(right: 2, left: 2),
          width: 175,
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.red,
                  width: 2,
                )),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(187, 141, 230, 1),
                          Color.fromRGBO(128, 75, 179, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.courseDetails["name"],
                        style: impNormalTextStyle,
                      ),
                      Text(
                        widget.courseDetails["instructor"],
                        style: normalTextStyle,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      );
    }
  }
}
