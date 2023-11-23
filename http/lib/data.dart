import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StudentData {
  StudentData(this.id, this.first_name, this.last_name, this.course, this.score,
      this.created_at, this.updated_at);

  StudentData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        course = json['course'],
        first_name = json['first_name'],
        last_name = json['last_name'],
        score = json['score'],
        created_at = json['created_at'],
        updated_at = json['updated_at'];

  final int id;
  final String first_name;
  final String last_name;
  final String course;
  final int score;
  final String created_at;
  final String updated_at;
}

class HttpClient {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "http://expertdevelopers.ir/api/v1/",
  ));
}

Future<StudentData> saveStudent({
  required String firstName,
  required String lastName,
  required String course,
  required int score,
}) async {
  emptyCheck([firstName, lastName, course, score]);
  final response =
      await HttpClient.dio.post("experts/student", queryParameters: {
    "course": course,
    "first_name": firstName,
    "last_name": lastName,
    "score": score,
  });

  if (response.statusCode == 200) {
    return StudentData.fromJson(response.data);
  } else {
    throw Exception("nothing hapened");
  }
}

void emptyCheck(List<dynamic> names) {
  for (var name in names)
    if (name.runtimeType == String
        ? (name as String).isEmpty
        : (name as int) > 0) {
      throw Exception("first name can not be empty");
    }
}

Future<List<StudentData>> getStudents() async {
  final response = await HttpClient.dio.get("experts/student");
  List<StudentData> students = [];
  if (response.data is List<dynamic>) {
    (response.data as List<dynamic>).forEach((element) {
      students.add(StudentData.fromJson(element));
    });
  }
  // print(response.data);
  return Future.value(students);
}
