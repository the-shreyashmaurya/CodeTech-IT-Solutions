class AttendanceRecordsModel {
    String? id;
    String courseId;
    String studentId;
    String date;
    bool isPresent;

    AttendanceRecordsModel({
        this.id,
        required this.courseId,
        required this.studentId,
        required this.date,
        required this.isPresent,
    });

    factory AttendanceRecordsModel.fromJson(Map<String, dynamic> json) => AttendanceRecordsModel(
        id: json["id"],
        courseId: json["courseId"],
        studentId: json["studentId"],
        date: json["date"],
        isPresent: json["isPresent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "studentId": studentId,
        "date": date,
        "isPresent": isPresent,
    };
}
