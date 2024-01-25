import 'package:flutter/material.dart';
import 'package:university_attendance_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    asyncInit();
    super.initState();
  }

  Future<void> asyncInit() async {
    await Future.delayed(const Duration(seconds: 1,milliseconds: 500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Icon(
                Icons.calendar_month_rounded,
                size: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("University Attendence App"),
          ],
        ),
      ),
    );
  }
}
