import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/elevatedButton.dart';
import 'package:university_attendance_app/constants/inputdecoration.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/student/student_database.dart';
import 'package:university_attendance_app/screens/instructor_screen/instructor_course_screen.dart';

class AddStudentScreen extends StatefulWidget {
  final String courseId;
  const AddStudentScreen({super.key, required this.courseId});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  TextEditingController prnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(187, 141, 230, 1),
              Color.fromRGBO(121, 80, 238, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Title Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Student",
                          style: titleTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Student PRN Text Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        controller: prnController,
                        decoration: normalTextFieldDecoration(
                            labletext: "Student PRN", hintText: ""),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    MyElevatedButton(
                      onPressed: () async {
                        // Get userId using PRN
                        String studentId = await StudentDatabase()
                            .getStudentIdFromPrn(
                                prn: prnController.text.trim());
                        print(studentId);

                        // Add student to Course database
                        await CoursesDatabase().addStudentToCourse(
                            courseId: widget.courseId, userId: studentId);

                        // Add course to Student database
                        await StudentDatabase().addCourseToStudent(
                            studentId: studentId, courseId: widget.courseId);

                        // Navigate back
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InstructorCourseScreen(courseId: widget.courseId),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(40),
                      width: 200,
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
