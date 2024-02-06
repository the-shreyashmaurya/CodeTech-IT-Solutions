import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/elevatedButton.dart';
import 'package:university_attendance_app/constants/inputdecoration.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/database/instructor/instructor_database.dart';
import 'package:university_attendance_app/database/instructor/instructor_model.dart';
import 'package:university_attendance_app/database/student/student_database.dart';
import 'package:university_attendance_app/database/student/student_model.dart';
import 'package:university_attendance_app/screens/signup_screen/firebase_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController prnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController instructorNameController = TextEditingController();
  TextEditingController instructorPasswordController = TextEditingController();
  TextEditingController instructorConfirmPasswordController =
      TextEditingController();
  TextEditingController instructorEmailController = TextEditingController();

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                // height: kToolbarHeight,
                height: 30,
                width: double.infinity,
              ),
              // Title Login
              Text(
                "SignUp",
                textAlign: TextAlign.center,
                style: titleTextStyle,
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 40,
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(
                              child: Text(
                                'Student',
                                style: subTitleTextStyle,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Instructor',
                                style: subTitleTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            40,
                        child: TabBarView(
                          children: [
                            // Student Signup Form
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  // Name Text Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: nameController,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Name", hintText: ""),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),

                                  // PRN Text Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: prnController,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "PRN", hintText: ""),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),

                                  // Email Text Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: emailController,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Email", hintText: ""),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),

                                  // Course and Semester Text field
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Course text field
                                      Container(
                                        margin: const EdgeInsets.only(left: 30),
                                        width: 150,
                                        child: TextField(
                                          controller: degreeController,
                                          decoration: normalTextFieldDecoration(
                                              labletext: "Course Name",
                                              hintText: ""),
                                          keyboardType:
                                              TextInputType.streetAddress,
                                        ),
                                      ),

                                      // Semester Text field
                                      SizedBox(
                                        width: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          child: TextField(
                                            controller: semesterController,
                                            decoration:
                                                normalTextFieldDecoration(
                                                    labletext: "Semester",
                                                    hintText: ""),
                                            keyboardType: TextInputType.name,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Password Text field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Password", hintText: ""),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                  // SignUP button
                                  MyElevatedButton(
                                    onPressed: () async {
                                      try {
                                        // Sign Up User to firebase Authentication
                                        var userCredential =
                                            await SignUpFirebase().mySignUp(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );

                                        //  Save User Data to Firebase Firestore
                                        StudentDatabase().addStudentDetails(
                                          id: userCredential.user!.uid,
                                          studentmodel: StudentModel(
                                              name: nameController.text,
                                              prn: prnController.text,
                                              email: emailController.text,
                                              degree: degreeController.text,
                                              semester: semesterController.text,
                                              courselist: [
                                                "j4SNEY50uRwRsh1bxHot",
                                                "rUcNDdqVv3IDfFsGH2wj"
                                              ]),
                                        );
                                        // StudentDatabase().saveStudentDetails(
                                        //     id: userCredential.user!.uid,
                                        //     name: nameController.text,
                                        //     prn: prnController.text,
                                        //     course: courseController.text,
                                        //     email: emailController.text,
                                        //     semester: semesterController.text);

                                        // Navigate to Student Page
                                        Navigator.pushReplacementNamed(
                                            context, studentRoute);
                                      } catch (e) {
                                        print("SignUp Error");
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(40),
                                    width: 200,
                                    child: const Text(
                                      "SignUp",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),

                                  // Go to Login page
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don't have an account??"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, loginRoute);
                                        },
                                        child: const Text("Sign In"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //
                            //
                            //
                            // Intructor SignUp Form
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  //
                                  //
                                  // Name Text Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: instructorNameController,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Name", hintText: ""),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  //
                                  //
                                  // Email Text Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: instructorEmailController,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Email", hintText: ""),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),

                                  // Password Text field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller: instructorPasswordController,
                                      obscureText: true,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Password", hintText: ""),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  // Confirm Password Text field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextField(
                                      controller:
                                          instructorConfirmPasswordController,
                                      obscureText: true,
                                      decoration: normalTextFieldDecoration(
                                          labletext: "Confirm Password",
                                          hintText: ""),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                  // SignUP button
                                  MyElevatedButton(
                                    onPressed: () async {
                                      if (instructorPasswordController.text ==
                                          instructorConfirmPasswordController
                                              .text) {
                                        // SignUp Instructor
                                        var userCredential =
                                            await SignUpFirebase().mySignUp(
                                                email: instructorEmailController
                                                    .text,
                                                password:
                                                    instructorPasswordController
                                                        .text);

                                        // Make a new Instructor model
                                        InstructorModel instructorModel =
                                            InstructorModel(
                                                id: userCredential.user!.uid,
                                                name: instructorNameController
                                                    .text,
                                                email: instructorEmailController
                                                    .text,
                                                createdCourses: ["1"]);
                                        // Add to Instructor Database
                                        await InstructorDatabase()
                                            .addInstructor(
                                                instructorModel:
                                                    instructorModel);

                                        // Navigate to Instructor Page
                                        Navigator.pushReplacementNamed(
                                            context, instructorRoute);
                                      } else {
                                        print("Passwords does not match");
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(40),
                                    width: 200,
                                    child: const Text(
                                      "SignUp",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),

                                  // Go to Login page
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don't have an account??"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, loginRoute);
                                        },
                                        child: const Text("Sign In"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
