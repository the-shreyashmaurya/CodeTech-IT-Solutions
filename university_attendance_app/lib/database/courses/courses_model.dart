class CoursesModel {
  String? id;
  String name;
  String instructor;
  List<dynamic> students;

  CoursesModel(
      {this.id,
      required this.name,
      required this.instructor,
      required this.students,
      });

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
        id: json["id"],
        name: json["name"],
        instructor: json["instructor"],
        students: List<String>.from(json["students"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "instructor": instructor,
        "students": List<dynamic>.from(students.map((x) => x)),
      };
}
