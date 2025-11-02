// lib/models/attendance_model.dart

enum AttendanceStatus { hadir, sakit, izin, alfa }

class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceRecord({required this.date, required this.status});
}
