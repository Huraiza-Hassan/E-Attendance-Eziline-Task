class CourseModel {
  late String degreeName;
  late String courseName;
  late String courseCode;
  late String courseStartingDate;

  CourseModel(
      {required this.degreeName,
      required this.courseName,
      required this.courseCode,
      required this.courseStartingDate});

  CourseModel.fromJson(Map<dynamic, dynamic> courseMap) {
    degreeName = courseMap['degreeName'];
    courseName = courseMap['courseName'];
    courseCode = courseMap['courseCode'];
    courseStartingDate = courseMap['courseStartingDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'degreeName': degreeName,
      'courseName': courseName,
      'courseCode': courseCode,
      'courseStartingDate': courseStartingDate
    };
  }
}
