

IBA, Karachi's enrolment schedule is published in a very difficult to navigate spreadsheet file. This code translates the spreadsheet into a json with accessible attributes.

**Guide** All courses are stored in Json form in assets/allCourses.json. Create a new file in the language of your choice (pytho, java, etc.) to view them as filtered by your criteria.

**Explanation:**

Code is in bin/enrolment_scheduler.dart;

1. readCourses returns a List of courses in Map form
2. cleanCourses corrects white spaces and some formatting. It is called within readCourses
3. results are written to assets/allCourses.json

Feel free to fork and submit **pull requests** to implement the following:

    implement "Saturday Only", "Tuesday Only", etc. corner cases in cleanCourses
    Add user friendly CLI

