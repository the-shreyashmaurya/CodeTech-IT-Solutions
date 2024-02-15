import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';
import 'package:university_attendance_app/screens/attendance_screen/today_attendance_screen.dart';
import 'package:university_attendance_app/screens/instructor_screen/addStudent_screen.dart';
import 'package:university_attendance_app/widgets/student_listItem_widget.dart';

class InstructorCourseScreen extends StatefulWidget {
  final String courseId;

  const InstructorCourseScreen({super.key, required this.courseId});

  @override
  State<InstructorCourseScreen> createState() => _InstructorCourseScreenState();
}

class _InstructorCourseScreenState extends State<InstructorCourseScreen> {
  var date =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, instructorRoute);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                      PopupMenuButton(
                        icon: Icon(Icons.menu, size: 30),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                value: "GetAttendance",
                                child: Text("Get Attendance")),
                          ];
                        },
                        onSelected: (value) {
                          if (value == "GetAttendance") {
                            print("GetAttendance clicked");
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> TodayAttendanceScreen(courseId: widget.courseId)));
                          }
                        },
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
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          date,
                          style: subTitleTextStyle,
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
                  itemCount: CourseDetails["students"].length,
                  itemBuilder: (context, index) {
                    return StudentListItemWidget(
                      studentId: CourseDetails["students"][index],
                    );
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddStudentScreen(courseId: widget.courseId)));
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
