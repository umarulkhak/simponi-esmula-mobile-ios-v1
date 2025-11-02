// lib/views/grades_page.dart
import 'package:flutter/material.dart';
import 'package:simponi_v_01/widgets/custom_card.dart';
import 'package:simponi_v_01/widgets/subject_score_chart.dart';

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai Akademik'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Grafik Nilai
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grafik Nilai Semester Ini',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                const SubjectScoreChart(),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Rincian Nilai
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rincian Nilai',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                _buildGradeItem(
                  subject: 'Matematika',
                  grade: 85,
                  teacher: 'Ibu Siti, S.Pd.',
                ),
                const Divider(),
                _buildGradeItem(
                  subject: 'Ilmu Pengetahuan Alam',
                  grade: 78,
                  teacher: 'Bapak Budi, M.Sc.',
                ),
                const Divider(),
                _buildGradeItem(
                  subject: 'Ilmu Pengetahuan Sosial',
                  grade: 92,
                  teacher: 'Bapak Agus, S.Sos.',
                ),
                const Divider(),
                _buildGradeItem(
                  subject: 'Bahasa Indonesia',
                  grade: 88,
                  teacher: 'Ibu Rina, S.Pd.',
                ),
                const Divider(),
                _buildGradeItem(
                  subject: 'Bahasa Inggris',
                  grade: 76,
                  teacher: 'Mr. John Doe',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeItem({required String subject, required int grade, required String teacher}) {
    Color gradeColor;
    if (grade >= 85) {
      gradeColor = Colors.green.shade700;
    } else if (grade >= 75) {
      gradeColor = Colors.orange.shade800;
    } else {
      gradeColor = Colors.red.shade700;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: CircleAvatar(
        backgroundColor: gradeColor,
        child: Text(
          grade.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(subject, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('Guru: $teacher'),
    );
  }
}
