import 'dart:io';
import 'dart:typed_data';
import 'package:enrolment_scheduler/filter_view.dart';
import 'package:enrolment_scheduler/functions.dart';
// ignore: depend_on_referenced_packages
import 'package:excel/excel.dart';

import 'compile_courses.dart';

void main(List<String> arguments) {
  String path = 'assets/Undergraduate Fall 2022 Main campus.xlsx';
  Uint8List bytes = File(path).readAsBytesSync();
  Excel spreadsheet = Excel.decodeBytes(bytes);
  List<Map<String, String>> courses = readCourses(spreadsheet);
  // File('assets/allCourses.json').writeAsStringSync(jsonEncode(courses));
  cli(courses);
}

void cli(List<Map<String, String>> courses) {
  List<Map<String, String>> toBeRefined = courses;
  List<Map<String, String>> refinedCourses = [];
  bool isFirstIter = true;
  while (true) {
    // select whether to filter on this list or next
    int choice = 0;
    if (!isFirstIter) {
      stdout.write("\nChoose:\n");
      stdout.write("\n1. Further filter the above results");
      stdout.write("\n2. Filter from the complete course list\n\n");
      stdout.write(">> ");
      choice = int.parse(stdin.readLineSync() ?? "-1");
      stdout.write("\n");
      if (choice == 1) {
        toBeRefined = refinedCourses;
      } else if (choice == 2) {
        toBeRefined = courses;
      } else {
        exit(0);
      }
    }
    isFirstIter = false;
    // select properties to refine on
    stdout.write('\n\nSelect property to refine on:\n\n');
    for (int i = 0; i < courses.first.length; i++) {
      stdout.write('$i. ${courses.first.keys.elementAt(i)}\n');
    }
    stdout.write('\n');
    // select option
    stdout.write(">> ");
    int selectedProperty = int.parse(stdin.readLineSync() ?? "-1");
    stdout.write("\n");
    // perform action
    if (selectedProperty == -1) exit(0);
    refinedCourses = refineBy(
      toBeRefined.first.keys.elementAt(selectedProperty),
      toBeRefined,
    );
    // dispay result
    for (var course in refinedCourses) {
      printCourse(course);
    }
  }
}
