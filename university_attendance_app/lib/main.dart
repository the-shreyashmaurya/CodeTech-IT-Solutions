import 'package:flutter/material.dart';
import 'package:university_attendance_app/screens/course_screen/add_course_screen.dart';
import 'package:university_attendance_app/screens/instructor_screen/instructor_screen.dart';
import 'package:university_attendance_app/screens/login_screen/login_screen.dart';
import 'package:university_attendance_app/screens/onboarding_screen.dart';
import 'package:university_attendance_app/screens/signup_screen/signup_screen.dart';
import 'package:university_attendance_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:university_attendance_app/screens/student_screen/student_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        '/student' :(context) => const StudentScreen(),
        '/instructor':(context)=> const InstructorScreen(),
        '/addCourse':(context) => const AddCourseScreen(),
        // '/teacher' :(context) => const 
      },
      home: const SplashScreen(),
    );
  }
}
