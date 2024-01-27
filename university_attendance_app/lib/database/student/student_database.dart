import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_attendance_app/database/student/student_model.dart';

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
  }) async {
    await studentCollection.doc(id).set({
      "name": name,
      "prn": prn,
      "course": course,
      "email": email,
      "semester": semester
    });
  }


  // Get Student Details
  Future<StudentModel> getStudentDetails({required String? id}) async {
    var record = await studentCollection.doc(id).get();

    StudentModel studentDetails = StudentModel(
        name: record["name"],
        prn: record["prn"],
        email: record["email"],
        course: record["course"],
        semester: record["semester"]);

    return studentDetails;
  }
}
