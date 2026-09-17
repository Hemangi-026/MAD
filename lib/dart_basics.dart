// dart_basics.dart
//
// Practical 1 — Dart Programming Fundamentals
// ---------------------------------------------
// This file is a STANDALONE Dart program (not the Flutter UI) that
// demonstrates the core Dart language concepts required for Practical 1:
// variables, constants, data types, operators, conditional statements,
// loops, functions, classes, constructors, inheritance and OOP concepts.
//
// How to run it and capture a screenshot for submission:
//   dart run lib/dart_basics.dart
//
// (This file has its own `main()` and is completely independent of
// lib/main.dart, so running it will NOT launch the Flutter app.)

// ---------------------------------------------------------------------
// 1. VARIABLES, CONSTANTS AND DATA TYPES
// ---------------------------------------------------------------------
// `var`  -> type is inferred and can be reassigned.
// `final`-> set once at runtime, cannot change afterwards.
// `const`-> a compile-time constant, cannot change and must be known
//           before the program runs.

const String universityName = 'Parul University'; // constant: fixed forever
final DateTime sessionStarted = DateTime.now(); // final: set once, at runtime

void demonstrateVariablesAndDataTypes() {
  print('\n--- 1. Variables, Constants & Data Types ---');

  // Basic data types
  String studentName = 'Rahul Patel'; // String
  int enrollmentYear = 2024; // int
  double cgpa = 8.75; // double
  bool isPlaced = false; // bool
  List<String> subjects = ['MAD', 'DBMS', 'AI', 'CN']; // List<String>
  Map<String, int> attendance = {
    'MAD': 92,
    'DBMS': 88,
    'AI': 95,
    'CN': 90,
  }; // Map<key, value>

  var department = 'Computer Engineering'; // var: type inferred as String
  dynamic anything = 24; // dynamic: type can change at runtime
  anything = 'CE001'; // now holds a String — allowed because it's dynamic

  print('University (const): $universityName');
  print('Session started (final): $sessionStarted');
  print('Name: $studentName | Year: $enrollmentYear | CGPA: $cgpa');
  print('Placed: $isPlaced | Department (var): $department');
  print('Subjects (List): $subjects');
  print('Attendance (Map): $attendance');
  print('Dynamic value now holds: $anything');
}

// ---------------------------------------------------------------------
// 2. OPERATORS
// ---------------------------------------------------------------------
void demonstrateOperators() {
  print('\n--- 2. Operators ---');

  int a = 18, b = 4;
  print('Arithmetic: a+b=${a + b}, a-b=${a - b}, a*b=${a * b}, '
      'a/b=${a / b}, a~/b=${a ~/ b}, a%b=${a % b}');

  print('Relational: a>b=${a > b}, a==b=${a == b}, a!=b=${a != b}');

  bool hasAttendance = true, hasFeesPaid = false;
  print('Logical: hasAttendance && hasFeesPaid = '
      '${hasAttendance && hasFeesPaid}');
  print('Logical: hasAttendance || hasFeesPaid = '
      '${hasAttendance || hasFeesPaid}');

  int? maybeCredits; // nullable int, currently null
  int credits = maybeCredits ?? 0; // null-coalescing operator
  print('Null-coalescing: credits = $credits');

  double cgpa = 8.75;
  String grade = cgpa >= 9
      ? 'A+'
      : cgpa >= 8
          ? 'A'
          : 'B'; // ternary/conditional operator
  print('Ternary operator result: grade = $grade');
}

// ---------------------------------------------------------------------
// 3. CONDITIONAL STATEMENTS
// ---------------------------------------------------------------------
String classifyAttendance(double percentage) {
  if (percentage >= 85) {
    return 'Excellent';
  } else if (percentage >= 75) {
    return 'Good';
  } else if (percentage >= 65) {
    return 'Average';
  } else {
    return 'Needs Improvement';
  }
}

void demonstrateConditionals() {
  print('\n--- 3. Conditional Statements ---');
  for (final value in [95.0, 80.0, 70.0, 50.0]) {
    print('Attendance $value% -> ${classifyAttendance(value)}');
  }

  // switch statement
  const semester = 5;
  switch (semester) {
    case 1:
    case 2:
      print('Switch: First year');
      break;
    case 3:
    case 4:
      print('Switch: Second year');
      break;
    case 5:
    case 6:
      print('Switch: Third year');
      break;
    default:
      print('Switch: Final year');
  }
}

// ---------------------------------------------------------------------
// 4. LOOPS
// ---------------------------------------------------------------------
void demonstrateLoops() {
  print('\n--- 4. Loops ---');

  final subjects = ['MAD', 'DBMS', 'AI', 'CN'];

  // for loop
  print('for loop:');
  for (int i = 0; i < subjects.length; i++) {
    print('  Subject ${i + 1}: ${subjects[i]}');
  }

  // for-in loop
  print('for-in loop:');
  for (final subject in subjects) {
    print('  Studying $subject');
  }

  // while loop
  print('while loop:');
  int countdown = 3;
  while (countdown > 0) {
    print('  Assignment due in $countdown day(s)');
    countdown--;
  }

  // do-while loop
  print('do-while loop:');
  int attempt = 1;
  do {
    print('  Login attempt $attempt');
    attempt++;
  } while (attempt <= 2);
}

// ---------------------------------------------------------------------
// 5. FUNCTIONS
// ---------------------------------------------------------------------
// A plain function with a required parameter and a return value.
double calculateAverage(List<double> marks) {
  if (marks.isEmpty) return 0;
  final total = marks.reduce((sum, mark) => sum + mark);
  return total / marks.length;
}

// A function with named + optional parameters and a default value.
String buildGreeting(String name, {String timeOfDay = 'day'}) {
  return 'Good $timeOfDay, $name!';
}

// An arrow function (single-expression shorthand).
int square(int x) => x * x;

void demonstrateFunctions() {
  print('\n--- 5. Functions ---');
  final average = calculateAverage([92, 88, 95, 90]);
  print('Average marks: ${average.toStringAsFixed(2)}');
  print(buildGreeting('Rahul'));
  print(buildGreeting('Priya', timeOfDay: 'morning'));
  print('square(6) = ${square(6)}');
}

// ---------------------------------------------------------------------
// 6. CLASSES, CONSTRUCTORS, ENCAPSULATION, INHERITANCE, POLYMORPHISM
// ---------------------------------------------------------------------

// Base class demonstrating a class, fields, encapsulation (private field
// with a getter) and a named + default constructor.
class Person {
  Person({required this.name, required this.email});

  final String name;
  final String email;

  // Private field (encapsulation) — only accessible inside this file.
  int _loginCount = 0;

  int get loginCount => _loginCount; // controlled read-only access

  void recordLogin() => _loginCount++;

  // A method that subclasses will override -> enables polymorphism.
  String describe() => 'Person: $name ($email)';
}

// Student "is-a" Person -> INHERITANCE.
class Student extends Person {
  Student({
    required super.name,
    required super.email,
    required this.enrollmentNo,
    required this.department,
    required this.cgpa,
    List<String>? subjects,
  }) : subjects = subjects ?? const [];

  final String enrollmentNo;
  final String department;
  final double cgpa;
  final List<String> subjects;

  // Constructor initializer list example.
  Student.fresher(String name, String email, String enrollmentNo)
      : this(
          name: name,
          email: email,
          enrollmentNo: enrollmentNo,
          department: 'Undeclared',
          cgpa: 0.0,
        );

  bool get isTopper => cgpa >= 9.0;

  // Overriding the parent method -> POLYMORPHISM.
  @override
  String describe() =>
      'Student: $name ($enrollmentNo), $department, CGPA $cgpa';
}

// Further inheritance: a more specific kind of Student.
class ScholarshipStudent extends Student {
  ScholarshipStudent({
    required super.name,
    required super.email,
    required super.enrollmentNo,
    required super.department,
    required super.cgpa,
    super.subjects,
    required this.scholarshipAmount,
  });

  final double scholarshipAmount;

  @override
  String describe() =>
      '${super.describe()} — Scholarship: ₹$scholarshipAmount';
}

void demonstrateOop() {
  print('\n--- 6. Classes, Constructors, Inheritance, Polymorphism ---');

  final student = Student(
    name: 'Rahul Patel',
    email: 'rahul.patel@campus.edu',
    enrollmentNo: '24CE001',
    department: 'Computer Engineering',
    cgpa: 8.75,
    subjects: const ['MAD', 'DBMS', 'AI', 'CN'],
  );

  final fresher = Student.fresher('Priya Shah', 'priya.shah@campus.edu', '25CE014');

  final scholar = ScholarshipStudent(
    name: 'Aman Verma',
    email: 'aman.verma@campus.edu',
    enrollmentNo: '24CE045',
    department: 'Information Technology',
    cgpa: 9.4,
    scholarshipAmount: 25000,
  );

  student.recordLogin();
  student.recordLogin();

  // Polymorphism: calling describe() through a Person-typed list runs
  // each object's OWN overridden version at runtime.
  final List<Person> people = [student, fresher, scholar];
  for (final person in people) {
    print(person.describe());
  }

  print('Login count for ${student.name}: ${student.loginCount}');
  print('Is ${student.name} a topper? ${student.isTopper}');
}

// ---------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------
void main() {
  print('=== Smart Student Companion — Dart Fundamentals Demo ===');
  demonstrateVariablesAndDataTypes();
  demonstrateOperators();
  demonstrateConditionals();
  demonstrateLoops();
  demonstrateFunctions();
  demonstrateOop();
  print('\n=== Done ===');
}
