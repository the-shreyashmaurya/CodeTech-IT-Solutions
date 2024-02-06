import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:university_attendance_app/constants/elevatedButton.dart';
import 'package:university_attendance_app/constants/inputdecoration.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';
import 'package:university_attendance_app/database/instructor/instructor_database.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  String instructorId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController courseNameController = TextEditingController();
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
                          "Add Course",
                          style: titleTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Course name Text Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        controller: courseNameController,
                        decoration: normalTextFieldDecoration(
                            labletext: "Course name", hintText: ""),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    MyElevatedButton(
                      onPressed: () async {
                        // Add course to database
                        CoursesModel courseModel = CoursesModel(
                          name: courseNameController.text,
                          instructor: instructorId,
                          students: [],
                        );

                        // Add Course to Course Database
                        String courseId =
                            await CoursesDatabase().addNewCourse(courseModel);

                        // Add Course to CourseList of Instructor
                        await InstructorDatabase().addInstructorCourses(
                            instructorId: instructorId, courseId: courseId);

                        // Navigate back
                        Navigator.pushReplacementNamed(
                            context, instructorRoute);
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
          Navigator.pushReplacementNamed(context, instructorRoute);
        },
        child: Icon(Icons.arrow_back_ios),
      ),
    );
    ;
  }
}
