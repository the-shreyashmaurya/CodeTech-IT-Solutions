import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDatabase {
  // var studentCollection =
  var studentCollection = FirebaseFirestore.instance.collection('student');

  // Save students Details on Signup
  saveStudentDetails({
    required String? id,
    required String name,
    required String prn,
    required String course,
    required String email,
    required String semester,
  }) {
    studentCollection.doc(id).set({
      "name": name,
      "prn": prn,
      "course": course,
      "email": email,
      "semester": semester
    });
    print("Added to student database");
  }

  // Get Student Details
  getStudentDetails({required String id}) {
    Future<DocumentSnapshot<Map<String, dynamic>>> StudentDetails =
        studentCollection.doc(id).get();
    print(StudentDetails);
  }
}
