import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:university_attendance_app/screens/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Width of screen : ${MediaQuery.of(context).size.width}");
    print(
        "Hieght of screen : ${MediaQuery.of(context).size.height}");

    return IntroductionScreen(
      // Automatic Scroll after 3 seconds
      infiniteAutoScroll: false,
      autoScrollDuration: 3 * 1000,

      // Dont show Back and Next Buttons
      showBackButton: false,
      showNextButton: false,

      // Skip button
      showSkipButton: true,
      skip: const Text("Skip"),

      // Done Button
      showDoneButton: true,
      done: const Text("Done"),
      onDone: () {
        print("pressed");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },

      // Show Pages
      pages: [
        // Page 1
        PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Easy Registration and SignIn"),
              Image.asset(
                "images/onboarding1.jpg",
                width: 390,
                height: 450,
                fit: BoxFit.fill,
              ),
              const Text(
                "This is a attendence app for university students",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // Page 2
        PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Search from your Courses"),
              Image.asset(
                "images/onboarding2.jpg",
                width: 390,
                height: 450,
                fit: BoxFit.fill,
              ),
              const Text(
                "This is a attendence app for university students",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        // Page 3
        PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Mark your Attendence"),
              Image.asset(
                "images/onboarding3.jpg",
                width: 390,
                height: 450,
                fit: BoxFit.fill,
              ),
              const Text(
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
