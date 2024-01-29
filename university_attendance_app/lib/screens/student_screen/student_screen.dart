import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_database.dart';
import 'package:university_attendance_app/database/student/student_database.dart';
import 'package:university_attendance_app/widgets/subjects_card.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  Map<String, dynamic> currentStudentDetails = {};
  bool isLoading = true;
  String currentUserId = "";

  @override
  void initState() {
    // TODO: implement initState
    asyncInit();
    super.initState();
  }

  asyncInit() async {
    currentUserId = await FirebaseAuth.instance.currentUser!.uid;

    await AttendanceRecordsDatabase()
        .initializeAttendanceForToday(currentUserId);
    var currentStudentModel = await StudentDatabase()
        .getStudentDetails(id: currentUserId);
    currentStudentDetails = currentStudentModel.toJson();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var date =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
                        icon: Icon(Icons.notifications_active, size: 30),
                      )
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Hello,",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              currentStudentDetails['name'],
                              style: titleTextStyle,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacementNamed(
                                    context, loginRoute);
                              },
                              icon: Icon(Icons.logout))
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                // List all courses in which Student is enrolled
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: currentStudentDetails["courselist"].length,
                  itemBuilder: (context, index) {
                    return SubjectsCard(
                      courseId: currentStudentDetails["courselist"][index],
                      studentId: currentUserId,
                      date: date,
                    );
                  },
                )

                // List of Recently accessed Subjects
                // Container(
                //   height: 180,
                //   padding: EdgeInsets.only(bottom: 20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //   ),
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       itemCount: 4,
                //       itemBuilder: (context, index) {
                //         return RecentSubjects();
                //       }),
                // ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0),
                //   child: Text(
                //     "All Subjects",
                //     style: subTitleTextStyle,
                //   ),
                // ),

                // List of all subjects

                // ListView.builder(
                //   scrollDirection: Axis.vertical,
                //   physics: BouncingScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: currentStudentDetails['courselist'].length,
                //   itemBuilder: (context, index) {
                //     return all_subjects(
                //       currentStudentCourse: currentStudentDetails['courselist']
                //           [index],
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
