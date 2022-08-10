import 'dart:io';

List<Map<String, String>> refineBy(
  String property,
  List<Map<String, String>> courses,
) {
  // filtered Courses initialized
  List<Map<String, String>> selectedCourses = [];
  // collect filter criteria
  Set<String> allOptions = {};
  for (Map<String, String> course in courses) {
    allOptions.add(course[property] ?? "");
  }
  // sort
  List<String> sortedOptions = allOptions.toList();
  sortedOptions.sort();
  // display options for selection
  for (int i = 0; i < sortedOptions.length; i++) {
    stdout.write(i.toString() + ". " + sortedOptions[i].toString() + "\n");
  }
  // select options
  stdout.write("\nEnter the numbers corresponding to your classes.\n");
  stdout.write("\nSeparate them by spaces. Example input:-\n");
  stdout.write("2 5 6 7 12\n");
  stdout.write("\nLeave it empty to select all classes.\n\n");
  stdout.write(">> ");
  String selected = stdin.readLineSync() ?? "";
  stdout.write("\n");
  // clean selection
  selected = selected.trim();
  while (selected.contains("  ")) {
    selected = selected.replaceAll("  ", " ");
  }
  List<String> selectedOptions = [];
  if (selected.isEmpty) {
    selectedOptions = sortedOptions;
  } else {
    List<int> selectedOptionsIndex = selected
        .split(" ")
        .map(
          (e) => int.tryParse(e) ?? -1,
        )
        .toList();
    for (var i in selectedOptionsIndex) {
      selectedOptions.add(sortedOptions[i]);
    }
  }
  // compile selection
  selectedCourses.addAll(
    courses.where(
      (course) => selectedOptions.contains(course[property]),
    ),
  );
  // return
  return selectedCourses;
}
