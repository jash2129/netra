# Attendance Management SDK

A Flutter-based SDK for implementing attendance management in educational applications.

## Features

- Teacher authentication
- Class and subject selection
- Attendance marking (Present/Absent)
- Historical attendance viewing
- Offline support with data sync

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  attendance_sdk:
    path: /path/to/attendance_sdk
```

## Usage

1. Initialize the SDK:

```dart
import 'package:attendance_sdk/attendance_sdk.dart';

await AttendanceSDK.initialize(
  baseUrl: 'https://your-api-url.com',
);
```

2. Authenticate teacher:

```dart
final authService = AuthService(
  baseUrl: AttendanceSDK.baseUrl,
  prefs: AttendanceSDK.prefs,
);

final user = await authService.login('teacher@example.com', 'password');
```

3. Mark attendance:

```dart
final attendanceService = AttendanceService(
  baseUrl: AttendanceSDK.baseUrl,
  token: authService.getToken()!,
);

final attendance = Attendance(
  studentId: 'student_id',
  teacherId: 'teacher_id',
  subject: 'subject_code',
  date: DateTime.now(),
  status: 'present',
  semester: 1,
);

await attendanceService.markAttendance(attendance);
```

## Building the SDK

1. Generate JSON serialization code:
```bash
flutter pub run build_runner build
```

2. Build for Android:
```bash
flutter build aar
```

3. Build for iOS:
```bash
flutter build ios-framework
```
