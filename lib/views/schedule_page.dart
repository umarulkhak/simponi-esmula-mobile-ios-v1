// lib/views/schedule_page.dart
import 'package:flutter/material.dart';
import 'package:simponi_v_01/widgets/custom_card.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Pelajaran'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          // Jadwal Hari Senin
          _ScheduleDayCard(
            day: 'Senin',
            subjects: [
              _SubjectInfo(
                time: '07:00 - 08:30',
                subject: 'Upacara & Literasi',
                teacher: 'Wali Kelas',
                color: Colors.orange,
              ),
              _SubjectInfo(
                time: '08:30 - 10:00',
                subject: 'Matematika',
                teacher: 'Ibu Siti, S.Pd.',
                color: Colors.blue,
              ),
              _SubjectInfo(
                time: '10:00 - 11:30',
                subject: 'Bahasa Indonesia',
                teacher: 'Ibu Rina, S.Pd.',
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(height: 16),

          // Jadwal Hari Selasa
          _ScheduleDayCard(
            day: 'Selasa',
            subjects: [
              _SubjectInfo(
                time: '07:00 - 08:30',
                subject: 'Ilmu Pengetahuan Alam',
                teacher: 'Bapak Budi, M.Sc.',
                color: Colors.green,
              ),
              _SubjectInfo(
                time: '08:30 - 10:00',
                subject: 'Ilmu Pengetahuan Sosial',
                teacher: 'Bapak Agus, S.Sos.',
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScheduleDayCard extends StatelessWidget {
  final String day;
  final List<_SubjectInfo> subjects;

  const _ScheduleDayCard({required this.day, required this.subjects});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              day,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ...subjects.map((subject) => _buildSubjectTile(subject)).toList(),
        ],
      ),
    );
  }

  Widget _buildSubjectTile(_SubjectInfo info) {
    return ListTile(
      leading: Container(
        width: 4,
        height: 40,
        color: info.color,
      ),
      title: Text(info.subject, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('Guru: ${info.teacher}'),
      trailing: Text(
        info.time,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
        ),
      ),
    );
  }
}

class _SubjectInfo {
  final String time;
  final String subject;
  final String teacher;
  final Color color;

  const _SubjectInfo({
    required this.time,
    required this.subject,
    required this.teacher,
    required this.color,
  });
}
