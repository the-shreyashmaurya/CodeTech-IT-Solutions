import 'package:flutter/material.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_database.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_model.dart';

class CourseScreen extends StatefulWidget {
  String studentId;
  String courseId;
  CourseScreen({
    super.key,
    required this.studentId,
    required this.courseId,
  });

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  String? studentId;
  String? courseId;

  @override
  void initState() {
    // TODO: implement initState
    asyncInit();
    super.initState();
  }

  asyncInit() async {
    await AttendanceRecordsDatabase().addAttendanceRecord(
        attendanceRecordsModel: AttendanceRecordsModel(
            courseId: widget.courseId,
            studentId: widget.studentId,
            date: "yesterday",
            isPresent: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("True"),
      ),
    );
  }
}
