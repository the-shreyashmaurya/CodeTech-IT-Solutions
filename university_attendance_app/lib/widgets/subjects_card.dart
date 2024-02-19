import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_database.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';
import 'package:university_attendance_app/database/instructor/instructor_database.dart';
import 'package:university_attendance_app/database/instructor/instructor_model.dart';

class SubjectsCard extends StatefulWidget {
  final String courseId;
  final String studentId;
  final String date;
  String instructorName = "";
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
  Color borderColor = Colors.red;

  @override
  void initState() {
    super.initState();
    ayncInit();
  }

  ayncInit() async {
    getCourseDetails();
    var isPresent = await AttendanceRecordsDatabase()
        .checkIfAttendanceAlreadyMarked(
            courseId: widget.courseId,
            studentId: widget.studentId,
            date: widget.date);
    if (isPresent == true) {
      borderColor = Colors.green;

      setState(() {});
    } else {
      borderColor = Colors.red;

      setState(() {});
    }
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
          // If attendance already marked
          if (borderColor == Colors.green) {
            print("Already Marked");
          } else {
            // Update Attendance
            await AttendanceRecordsDatabase().addAttendance(
                courseId: widget.courseId,
                studentId: widget.studentId,
                date: widget.date,
                isPresent: true);
            // Change Border Color
            borderColor = Colors.green;

            setState(() {});
          }
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
                  color: borderColor,
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
                        widget.instructorName,
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

  getCourseDetails() async {
    CoursesModel courseDetailsModel =
        await CoursesDatabase().getCourseDetails(courseId: widget.courseId);
    var course = courseDetailsModel.toJson();
    InstructorModel instructorModel = await InstructorDatabase()
        .getInstructorDetails(id: course["instructor"]);
    var instructor = instructorModel.toJson();
    setState(() {
      widget.courseDetails = course;
      widget.isLoading = false;
      widget.instructorName = instructor["name"];
    });
  }
}
