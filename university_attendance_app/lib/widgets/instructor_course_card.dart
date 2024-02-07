import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/courses/courses_database.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';

class InstructorCourseCard extends StatefulWidget {
  final String courseId;
  bool isLoading = true;
  Map<String, dynamic> courseDetails = {};
  InstructorCourseCard({
    super.key,
    required this.courseId,
  });

  @override
  State<InstructorCourseCard> createState() => _InstructorCourseCardState();
}

class _InstructorCourseCardState extends State<InstructorCourseCard> {
  @override
  void initState() {
    super.initState();
    getCourseDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true) {
      return Container(
        child: CircularProgressIndicator(),
      );
    } else {
      return GestureDetector(
        onTap: () async {},
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
                  color: Colors.black,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.courseDetails["name"],
                          style: impNormalTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          widget.courseDetails["instructor"],
                          style: normalTextStyle,
                        ),
                      ],
                    ),
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
    setState(() {
      widget.courseDetails = course;
      widget.isLoading = false;
    });
  }
}
