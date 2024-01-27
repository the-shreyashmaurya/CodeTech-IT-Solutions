import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/elevatedButton.dart';
import 'package:university_attendance_app/constants/inputdecoration.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';
import 'package:university_attendance_app/screens/signup_screen/firebase_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController prnController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController semesterController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
          children: [
            const SizedBox(
              height: 150,
              width: double.infinity,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
                child: SingleChildScrollView(
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Title Login
                      Text(
                        "SignUp",
                        style: titleTextStyle,
                      ),
                      const SizedBox(height: 30),

                      // Name Text Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: nameController,
                          decoration: normalTextFieldDecoration(
                              labletext: "Name", hintText: ""),
                          keyboardType: TextInputType.name,
                        ),
                      ),

                      // PRN Text Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: prnController,
                          decoration: normalTextFieldDecoration(
                              labletext: "PRN", hintText: ""),
                          keyboardType: TextInputType.name,
                        ),
                      ),

                      // Email Text Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: emailController,
                          decoration: normalTextFieldDecoration(
                              labletext: "Email", hintText: ""),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      // Course and Semester Text field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Course text field
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            width: 150,
                            child: TextField(
                              controller: courseController,
                              decoration: normalTextFieldDecoration(
                                  labletext: "Course Name", hintText: ""),
                              keyboardType: TextInputType.streetAddress,
                            ),
                          ),

                          // Semester Text field
                          SizedBox(
                            width: 200,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: TextField(
                                controller: semesterController,
                                decoration: normalTextFieldDecoration(
                                    labletext: "Semester", hintText: ""),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Password Text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                      MyElevatedButton(
                        onPressed: () async {
                          await SignUpFirebase().mySignUp(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          Navigator.pushReplacementNamed(context, loginRoute);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
