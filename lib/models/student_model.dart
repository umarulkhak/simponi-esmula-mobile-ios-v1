// lib/models/student_model.dart

class Student {
  final String name;
  final String nis; // Nomor Induk Siswa
  final String className;
  final String photoUrl;

  Student({
    required this.name,
    required this.nis,
    required this.className,
    required this.photoUrl,
  });
}
