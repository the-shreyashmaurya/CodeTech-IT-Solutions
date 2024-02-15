import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_database.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';
import 'package:university_attendance_app/screens/instructor_screen/instructor_course_screen.dart';
import 'package:university_attendance_app/widgets/attendace_listitem_widget.dart';

class TodayAttendanceScreen extends StatefulWidget {
  final String courseId;

  const TodayAttendanceScreen({super.key, required this.courseId});

  @override
  State<TodayAttendanceScreen> createState() => _TodayAttendanceScreenState();
}

class _TodayAttendanceScreenState extends State<TodayAttendanceScreen> {
  List attendanceRollster = [];
  Map<String, dynamic> CourseDetails = {};

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    isLoading = true;
    setState(() {});
    attendanceRollster = await AttendanceRecordsDatabase()
        .getAttendanceOfCourse(courseId: widget.courseId);
    CoursesModel record =
        await CoursesDatabase().getCourseDetails(courseId: widget.courseId);
    CourseDetails = record.toJson();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Placeholder(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User detail drawer and notification button
                Container(
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(187, 141, 230, 1),
                        Color.fromRGBO(173, 123, 219, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InstructorCourseScreen(
                                              courseId: widget.courseId)));
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                    ],
                  ),
                ),

                // Hello name and logout button
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(125, 58, 58, 58),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          blurStyle: BlurStyle.outer)
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          CourseDetails["name"],
                          style: titleTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),

                // Space
                SizedBox(
                  height: 25,
                ),

                // List of students Enrolled
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: attendanceRollster.length,
                  itemBuilder: (context, index) {
                    return AttendanceListItemWidget(
                      attendanceRecord: attendanceRollster[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        
      );
    }
  }
}
