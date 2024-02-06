import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_attendance_app/database/instructor/instructor_model.dart';

class InstructorDatabase {
  var instructorDatabaseCollection =
      FirebaseFirestore.instance.collection('instructor');

  Future<void> addInstructor({required InstructorModel instructorModel}) async {
    await instructorDatabaseCollection
        .doc(instructorModel.id)
        .set(instructorModel.toJson());
    print("Instructor Added");
  }

  Future<void> addInstructorCourses(
      {required String instructorId, required String courseId}) async {
    InstructorModel instructorModel =
        await getInstructorDetails(id: instructorId);
    var instructorDetail = instructorModel.toJson();
    instructorDetail['createdCourses'] += [courseId];

    await instructorDatabaseCollection.doc(instructorId).set(instructorDetail);
  }

  Future<InstructorModel> getInstructorDetails({required String id}) async {
    var instructor = await instructorDatabaseCollection.doc(id).get();
    InstructorModel instructorModel = InstructorModel(
        id: id,
        name: instructor['name'],
        email: instructor['email'],
        createdCourses: instructor['createdCourses']);
    return instructorModel;
  }

  Future<bool> checkInstructorExists({required String id}) async {
    print("clicked");
    var record = await instructorDatabaseCollection
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    if (record.docs.length == 1) {
      return true;
    } else {
      return false;
    }
  }
}
