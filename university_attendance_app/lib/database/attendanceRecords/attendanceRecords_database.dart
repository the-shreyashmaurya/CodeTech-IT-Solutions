import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_attendance_app/database/attendanceRecords/attendanceRecords_model.dart';

class AttendanceRecordsDatabase {
  var attendanceRecordsCollection =
      FirebaseFirestore.instance.collection('attendanceRecords');

  Future<void> addAttendance({
    required String courseId,
    required String studentId,
    required String date,
    required bool isPresent,
  }) async {
    AttendanceRecordsModel attendanceModel = AttendanceRecordsModel(
        courseId: courseId,
        studentId: studentId,
        date: date,
        isPresent: isPresent);

    DocumentReference<Map<String, dynamic>> record =
        await attendanceRecordsCollection.add(attendanceModel.toJson());

    // Update attedance record with id
    attendanceModel = AttendanceRecordsModel(
        courseId: courseId,
        studentId: studentId,
        date: date,
        isPresent: isPresent,
        id: record.id);

    updateAttendance(id: record.id, attendanceModel: attendanceModel);
  }

  Future<void> updateAttendance(
      {required String id,
      required AttendanceRecordsModel attendanceModel}) async {
    await attendanceRecordsCollection.doc(id).set(attendanceModel.toJson());
  }

  Future<bool> checkIfAttendanceAlreadyMarked(
      {required String courseId,
      required String studentId,
      required String date}) async {
    var record = await attendanceRecordsCollection
        .where('courseId', isEqualTo: courseId)
        .where('studentId', isEqualTo: studentId)
        .where('date', isEqualTo: date)
        .limit(1)
        .get();
    if (record.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> getAttendanceOfSingleStudent(
      {required String studentId}) async {
    List<Map<String, dynamic>> attendanceRecord = [];
    var records = await attendanceRecordsCollection
        .where('studentId', isEqualTo: studentId)
        .limit(10)
        .get();

    for (var record in records.docs) {
      attendanceRecord.add(record.data());
    }
    print(attendanceRecord);
    return attendanceRecord;
  }

  Future<List> getAttendanceOfCourse({required String courseId}) async {
    var records = await attendanceRecordsCollection
        .where("courseId", isEqualTo: courseId)
        .get();
    List attendanceList = [];
    for (var i in records.docs) {
      attendanceList.add(i.data());
    }
    
    return attendanceList;
  }
}
