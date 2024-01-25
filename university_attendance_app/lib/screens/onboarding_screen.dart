import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:university_attendance_app/screens/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Width of screen : " + MediaQuery.of(context).size.width.toString());
    print(
        "Hieght of screen : " + MediaQuery.of(context).size.height.toString());

    return IntroductionScreen(
      // Automatic Scroll after 3 seconds
      infiniteAutoScroll: false,
      autoScrollDuration: 3 * 1000,

      // Dont show Back and Next Buttons
      showBackButton: false,
      showNextButton: false,

      // Skip button
      showSkipButton: true,
      skip: Text("Skip"),

      // Done Button
      showDoneButton: true,
      done: Text("Done"),
      onDone: () {
        print("pressed");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },

      // Show Pages
      pages: [
        // Page 1
        PageViewModel(
          titleWidget: Text(""),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Easy Registration and SignIn"),
              Image.asset(
                "images/onboarding1.jpg",
                width: 390,
                height: 450,
                fit: BoxFit.fill,
              ),
              Text(
                "This is a attendence app for university students",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // Page 2
        PageViewModel(
          titleWidget: Text(""),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Search from your Courses"),
              Image.asset(
                "images/onboarding2.jpg",
                width: 390,
                height: 450,
                fit: BoxFit.fill,
              ),
              Text(
                "This is a attendence app for university students",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // Page 3
        PageViewModel(
          titleWidget: Text(""),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Mark your Attendence"),
              Image.asset(
                "images/onboarding3.jpg",
                width: 390,
                height: 450,
                fit: BoxFit.fill,
              ),
              Text(
                "This is a attendence app for university students",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}
