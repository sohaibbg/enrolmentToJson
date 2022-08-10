import 'dart:io';

void printCourse(Map<String, String> course) {
  stdout.write('\n');
  course.forEach((key, value) => stdout.write('>>$key: $value\n'));
  stdout.write('\n');
}
