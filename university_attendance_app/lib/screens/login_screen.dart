import 'package:flutter/material.dart';
import 'package:university_attendance_app/constants/elevatedButton.dart';
import 'package:university_attendance_app/constants/inputdecoration.dart';
import 'package:university_attendance_app/constants/routes.dart';
import 'package:university_attendance_app/constants/textstyle.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Title Login
                      Text(
                        "Login",
                        style: titleTextStyle,
                      ),
                      const SizedBox(height: 30),

                      // Email Text Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          // autofocus: true,
                          decoration: normalTextFieldDecoration(
                              labletext: "Email", hintText: ""),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      // Password Text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          obscureText: true,
                          decoration: normalTextFieldDecoration(
                              labletext: "Password", hintText: ""),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      MyElevatedButton(
                        onPressed: () {},
                        borderRadius: BorderRadius.circular(40),
                        width: 200,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account??"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, signUpRoute);
                            },
                            child: Text("SignUp"),
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
