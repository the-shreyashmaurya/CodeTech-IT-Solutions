import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_attendance_app/database/student/student_model.dart';

class StudentDatabase {
  var studentCollection = FirebaseFirestore.instance.collection('student');

  // Add Student details
  addStudentDetails(
      {required StudentModel studentmodel, required String id}) async {
    var model2json = studentmodel.toJson();
    await studentCollection.doc(id).set(model2json);
  }

  // Get Student Details
  Future<StudentModel> getStudentDetails({required String id}) async {
    var record = await studentCollection.doc(id).get();

    StudentModel studentDetails = StudentModel(
      name: record['name'],
      prn: record['prn'],
      email: record['email'],
      degree: record['degree'],
      semester: record['semester'],
      courselist: record['courselist'],
    );

    return studentDetails;
  }
}
