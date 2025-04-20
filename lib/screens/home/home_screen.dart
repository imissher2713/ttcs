import 'package:flutter/material.dart';

import '../../model/course.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Exam",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              // Đây là thanh scroll ngang
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courses
                      .map(
                        (course) => GestureDetector(
                          onTap: () => {
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: CourseCard(
                              title: course.title,
                              iconSrc: course.iconSrc,
                              color: course.color,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              // Đây là thanh scroll dọc
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Recent",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ...recentCourses.map((course) => GestureDetector(
                onTap: () => {
                },
                child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: SecondaryCourseCard(
                        title: course.title,
                        iconsSrc: course.iconSrc,
                        colorl: course.color,
                      ),
                    ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
