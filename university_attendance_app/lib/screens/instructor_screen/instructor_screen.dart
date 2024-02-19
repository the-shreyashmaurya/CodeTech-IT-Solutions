import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/instructor/instructor_database.dart';
import 'package:university_attendance_app/database/instructor/instructor_model.dart';
import 'package:university_attendance_app/widgets/instructor_course_card.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({super.key});

  @override
  State<InstructorScreen> createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  var date =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  Map<String, dynamic> currentInstructorDetails = {};
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
    InstructorModel record = await InstructorDatabase()
        .getInstructorDetails(id: FirebaseAuth.instance.currentUser!.uid);
    currentInstructorDetails = record.toJson();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Scaffold(
        body: Center(
            child: Container(
                width: 40, height: 40, child: CircularProgressIndicator())),
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
                      // Hello and date Text
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

                      // Instructor Name and Logout Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              currentInstructorDetails['name'],
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

                // Space
                SizedBox(
                  height: 25,
                ),

                // Created Course Gridview
                GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: currentInstructorDetails['createdCourses'].length,
                  itemBuilder: (context, index) {
                    return InstructorCourseCard(
                        courseId: currentInstructorDetails['createdCourses']
                            [index]);
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, addCourseRoute);
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
