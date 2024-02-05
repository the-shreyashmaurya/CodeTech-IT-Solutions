import 'package:flutter/material.dart';
import 'package:university_attendance_app/widgets/student_signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Icon(Icons.school_outlined),
                  ),
                  Tab(
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              // Tab View

              TabBarView(children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.green,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
