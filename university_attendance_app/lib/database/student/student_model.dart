class StudentModel {
  String name;
  String prn;
  String email;
  String degree;
  String semester;
  List<dynamic>? courselist;

  StudentModel({
    required this.name,
    required this.prn,
    required this.email,
    required this.degree,
    required this.semester,
    this.courselist,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        name: json["name"],
        prn: json["prn"],
        email: json["email"],
        degree: json["degree"],
        semester: json["semester"],
        courselist: json["courselist"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "prn": prn,
        "email": email,
        "degree": degree,
        "semester": semester,
        "courselist": courselist,
      };
}
