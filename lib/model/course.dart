import 'package:flutter/material.dart' show Color;

class Course {
  final String title, description, iconSrc;
  final Color color;

  Course({
    required this.title,
    this.description = '',
    this.iconSrc = "assets/icons/ios.svg",
    this.color = const Color(0xFF7553F6),
  });
}

final List<Course> courses = [
  Course(
    title: "Đề tiếng anh số 1",
  ),
  Course(
    title: "Đề tiếng anh số 2",
    iconSrc: "assets/icons/code.svg",
    color: const Color(0xFF80A4FF),
  ),
  Course(title: "Đề số 3")

];

final List<Course> recentCourses = [
  Course(title: "Đề số 1"),
  Course(
    title: "Đề số 2",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
  Course(title: "Đề số 3"),
  Course(
    title: "Đề số 4",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
  Course(title: "Đề số 5")

];
