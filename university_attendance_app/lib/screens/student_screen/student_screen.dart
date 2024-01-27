import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/student/student_database.dart';
import 'package:university_attendance_app/widgets/recent_subjects.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    StudentDatabase()
        .getStudentDetails(id: FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Hello",
                        style: titleTextStyle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Your name",
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

              // List of Recently accessed Subjects
              Container(
                height: 180,
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return RecentSubjects();
                    }),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "All Subjects",
                  style: subTitleTextStyle,
                ),
              ),

              // List of all subjects

              ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Container(decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(125, 58, 58, 58),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              blurStyle: BlurStyle.outer)
                        ],
                        color: Colors.red,
                      ),),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
