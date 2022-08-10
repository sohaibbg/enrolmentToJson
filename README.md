

IBA, Karachi's enrolment schedule is published in a very difficult to navigate spreadsheet file. This code presents you with a CLI to access the aforementioned data. It also translates the spreadsheet into a json with accessible attributes for your custom logic to be applied with the programming language of your choice.

**Guide**

1. Navigate to the root folder
2. open a terminal
3. Enter "dart lib/main.dart"
You will need the Dart SDK to be installed
All courses are stored in Json form in assets/allCourses.json.

**Explanation:**

Code is in bin/enrolment_scheduler.dart;

1. readCourses returns a List of courses in Map form
2. cleanCourses corrects white spaces and some formatting. It is called within readCourses
3. results are written to assets/allCourses.json

Feel free to fork and submit **pull requests** to implement the following:

1. implement "Saturday Only", "Tuesday Only", etc. corner cases in cleanCourses
