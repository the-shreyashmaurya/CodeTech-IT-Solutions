import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_model.dart';

class AttendanceRecordsDatabase {
  var attendanceRecordsCollection =
      FirebaseFirestore.instance.collection('attendanceRecords');

  Future<void> initializeAttendanceForToday(String studentId) async {
    // Get the current date
    String formattedDate =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    // Check if attendance records for the current date exist
    var querySnapshot = await attendanceRecordsCollection
        .where('studentId', isEqualTo: studentId)
        .where('date', isEqualTo: formattedDate)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // If no records exist for the current date, create new records
      List<String> courseIds = [
        "j4SNEY50uRwRsh1bxHot"
      ]; // Replace with the actual course IDs for the student
      for (String courseId in courseIds) {
        await addAttendanceRecord(
          attendanceRecordsModel: AttendanceRecordsModel(
            courseId: courseId,
            studentId: studentId,
            date: formattedDate,
            isPresent: false, // Default to absent
          ),
        );
      }
    } else {
      // If records exist, update them to false if they are not already marked as present
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        bool isPresent = doc['isPresent'] ?? false;
        if (!isPresent) {
          await updateAttendanceStatus(
            recordId: doc.id,
            newStatus: false,
          );
        }
      }
    }
  }

  // Add attendance record
  Future<void> addAttendanceRecord(
      {required AttendanceRecordsModel attendanceRecordsModel}) async {
    var model2json = attendanceRecordsModel.toJson();

    // Creating a new attendance record with id == null
    var record = await attendanceRecordsCollection.add(model2json);

    // Updating id after creation
    model2json["id"] = record.id;
    await attendanceRecordsCollection.doc(record.id).update(model2json);
  }

// Get Attendance Record Id based on studentid, courseid and date
  Future<String> getAttendanceRecordId({
    required String studentId,
    required String courseId,
  }) async {
    // Get the current date
    String formattedDate =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    // Query attendance records for the given student, course, and date
    var querySnapshot = await attendanceRecordsCollection
        .where('studentId', isEqualTo: studentId)
        .where('courseId', isEqualTo: courseId)
        .where('date', isEqualTo: formattedDate)
        .limit(1) // Limit to one document
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If a matching record is found, return its ID
      return querySnapshot.docs.first.id;
    } else {
      // If no matching record is found, return null
      print("error : attendance database, get record id");
      return "";
    }
  }

//
//
//
  Future<void> updateAttendanceForCourse(
      String studentId, String courseId) async {
    // Assuming you have the logic to get the attendance record ID based on the student ID and course ID
    // Replace 'record123' with the actual record ID.
    String recordId =
        await getAttendanceRecordId(studentId: studentId, courseId: courseId);

    // Update attendance status to true (present)
    await updateAttendanceStatus(
      recordId: recordId,
      newStatus: true,
    );
  }
  // Retrieve all attendance records for a specific course.
  // Future<List<AttendanceRecordsModel>> getAttendanceRecordsForCourse(
  //     String courseId) async {
  //   var querySnapshot = await attendanceRecordsCollection
  //       .where('courseId', isEqualTo: courseId)
  //       .get();

  //   return querySnapshot.docs
  //       .map((doc) =>
  //           AttendanceRecordsModel.fromJson(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  // Retrieve attendance records for a specific student.
  //  Future<List<AttendanceRecordsModel>> getAttendanceRecordsForStudent(
  //     String studentId) async {
  //   var querySnapshot = await attendanceRecordsCollection
  //       .where('studentId', isEqualTo: studentId)
  //       .get();

  //   return querySnapshot.docs
  //       .map((doc) =>
  //           AttendanceRecordsModel.fromJson(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  // Update the attendance status of a student for a specific date and course.
  Future<void> updateAttendanceStatus({
    required String recordId,
    required bool newStatus,
  }) async {
    await attendanceRecordsCollection
        .doc(recordId)
        .update({'isPresent': newStatus});
  }
}
  // // Delete attendance record
  // Future<void> deleteAttendanceRecord(String recordId) async {
  //   await attendanceRecordsCollection.doc(recordId).delete();
  // }
