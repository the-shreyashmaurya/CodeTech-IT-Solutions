import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_attendance_app/database/courses/courses_model.dart';

class CoursesDatabase {
  var coursesCollection = FirebaseFirestore.instance.collection('courses');

  // Add new course
  Future<String> addNewCourse(CoursesModel course) async {
    var model2json = course.toJson();
    var record = await coursesCollection.add(model2json);
    model2json['id'] = record.id;
    await coursesCollection.doc(record.id).update(model2json);
    return record.id;
  }

  // Delete course
  Future<void> deleteCourse({required String courseId}) async {
    await coursesCollection.doc(courseId).delete();
  }

  // Get Course details - name, instructor, student list
  Future<CoursesModel> getCourseDetails({required String courseId}) async {
    var record = await coursesCollection.doc(courseId).get();
    var courseDetails = CoursesModel(
        id: record.id,
        name: record['name'],
        instructor: record['instructor'],
        students: record['students']);
    return courseDetails;
  }

  // add Students to existing course
  Future<void> addStudentToCourse(
      {required String courseId, required String userId}) async {
    CoursesModel record = await getCourseDetails(courseId: courseId);

    Map<String, dynamic> courseDetail = record.toJson();
    // courseDetail["students"] = courseDetail['students'] + [userId];
    courseDetail["students"].add(userId);

    await coursesCollection.doc(courseId).update(courseDetail);
  }

  // remove Students from existing course
  Future<void> removeStudentFromCourse(
      {required String courseId, required String userId}) async {
    CoursesModel record = await getCourseDetails(courseId: courseId);
    Map<String, dynamic> courseDetail = record.toJson();
    courseDetail["students"].remove(userId);

    await coursesCollection.doc(courseId).update(courseDetail);
  }
}
