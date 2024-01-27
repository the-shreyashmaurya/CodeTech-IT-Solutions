class StudentModel {
  String name;
  String prn;
  String email;
  String course;
  String semester;

  StudentModel({
    required this.name,
    required this.prn,
    required this.email,
    required this.course,
    required this.semester,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        name: json["name"],
        prn: json["prn"],
        email: json["email"],
        course: json["course"],
        semester: json["semester"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "prn": prn,
        "email": email,
        "course": course,
        "semester": semester,
      };
}
