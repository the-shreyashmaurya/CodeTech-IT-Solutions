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

  Future<bool> checkStudentExists({required String id}) async {
    var record =
        await studentCollection.where('id', isEqualTo: id).limit(1).get();
    if (record.docs.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  // Get Student Id based on PRN
  Future<String> getStudentIdFromPrn({required String prn}) async {
    var record =
        await studentCollection.where("prn", isEqualTo: prn).limit(1).get();

    return record.docs[0].id;
  }

  // Add Student Courses
  Future<void> addCourseToStudent(
      {required String studentId, required String courseId}) async {
    var record = await studentCollection.doc(studentId).get();

    StudentModel studentModel = StudentModel(
        name: record["name"],
        prn: record["prn"],
        email: record["email"],
        degree: record["degree"],
        semester: record["semester"],
        courselist: record["courselist"] + [courseId]);

    await studentCollection.doc(studentId).set(studentModel.toJson());
  }
}
