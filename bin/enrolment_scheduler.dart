import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// ignore: depend_on_referenced_packages
import 'package:excel/excel.dart';

void main(List<String> arguments) {
  String path = 'assets/Undergraduate Fall 2022 Main campus.xlsx';
  Uint8List bytes = File(path).readAsBytesSync();
  Excel spreadsheet = Excel.decodeBytes(bytes);
  List courses = readCourses(spreadsheet);
  File('assets/allCourses.json').writeAsStringSync(jsonEncode(courses));
}

List<Map<String, String>> readCourses(Excel spreadsheet) {
  List<Map<String, String>> courses = [];
  // used to navigate excel file when read
  Map scheduleMap = {
    'dayPair': ['M/W', 'T/T', 'F/S'],
    // the number represents the last row for that session
    'sessions': {
      61: '8:30-9:45',
      114: '10:00-11:15',
      163: '11:30-12:45',
      218: '1:00-2:15',
      266: '2:30-3:45',
      319: '4:00-5:15',
      364: '5:30-6:45',
      372: '7:00-8:15',
    },
    'columns': ['course', 'class', 'room', 'erp', 'teacher'],
    'firstColumn': 2,
    'firstRow': 8,
    'lastRow': 372
  };

  for (var table in spreadsheet.tables.keys) {
    for (int rowIndex = scheduleMap['firstRow'] - 1;
        rowIndex < scheduleMap['lastRow'];
        rowIndex++) {
      String currentSlot = '';
      for (int i = 1; i < scheduleMap['sessions'].length; i++) {
        // print(
        //   rowIndex.toString() +
        //       ' ' +
        //       scheduleMap['sessions'].keys.toList()[i].toString(),
        // );
        if (scheduleMap['sessions'].keys.toList()[i] > rowIndex) {
          currentSlot = scheduleMap['sessions'].values.toList()[i - 1];
          break;
        }
      }
      // print(currentSlot);
      for (int dayPairIndex = 0;
          dayPairIndex <
              ((spreadsheet.tables[table]!.maxCols -
                          (scheduleMap['firstColumn'] - 1)) /
                      scheduleMap['columns'].length)
                  .floor();
          dayPairIndex++) {
        String currentDayPair = scheduleMap['dayPair'][dayPairIndex];
        Map<String, String> course = {};
        for (int i = 0; i < scheduleMap['columns'].length; i++) {
          course[scheduleMap['columns'][i]] = spreadsheet
                  .tables[table]!
                  .rows[rowIndex][scheduleMap['firstColumn'] -
                      1 +
                      (dayPairIndex * scheduleMap['columns'].length as int) +
                      i]
                  ?.value
                  .toString()
                  .trim() ??
              '';
        }
        course['dayPair'] = currentDayPair;
        course['currentSlot'] = currentSlot;
        courses.add(course);
      }
    }
  }
  courses = cleanCourses(courses);
  return courses;
}

List<Map<String, String>> cleanCourses(List<Map<String, String>> courses) {
  String temp = '';
  for (int i = 0; i < courses.length; i++) {
    courses[i].forEach((key, value) {
      temp = value.replaceAll('\n', ' ');
      temp = temp.trim();
      while (temp.contains('  ')) {
        temp = temp.replaceAll('  ', ' ');
      }
      courses[i][key] = temp;
    });
  }
  courses.removeWhere(
    (course) => course['class']!.isEmpty && course['course']!.isEmpty,
  );
  return courses;
}
