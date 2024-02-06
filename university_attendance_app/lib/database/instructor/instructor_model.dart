class InstructorModel {
    String id;
    String name;
    String email;
    List<dynamic> createdCourses;

    InstructorModel({
        required this.id,
        required this.name,
        required this.email,
        required this.createdCourses,
    });

    factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        createdCourses: List<String>.from(json["createdCourses"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "createdCourses": List<dynamic>.from(createdCourses.map((x) => x)),
    };
}
