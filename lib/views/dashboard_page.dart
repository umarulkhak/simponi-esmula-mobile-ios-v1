// lib/views/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:simponi_v_01/widgets/custom_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Sambutan
          Text(
            'Selamat Datang, Bapak Ahmad!',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Berikut adalah ringkasan akademik Budi.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Kartu Pengumuman
          _buildAnnouncementCard(context),
          const SizedBox(height: 24),

          // Kartu Tugas Mendatang
          _buildUpcomingAssignmentsCard(context),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.campaign_rounded, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                "Pengumuman Penting",
                style: textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Ujian Tengah Semester akan dilaksanakan mulai tanggal 25 Oktober 2024. Harap mempersiapkan diri.',
            style: textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Lihat Semua'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUpcomingAssignmentsCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_turned_in_outlined, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              Text(
                "Tugas Mendatang",
                style: textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAssignmentItem(
            subject: 'Matematika',
            title: 'Latihan Soal Bab 5',
            dueDate: 'Besok, 23 Okt 2024',
          ),
          const Divider(height: 24),
          _buildAssignmentItem(
            subject: 'Bahasa Inggris',
            title: 'Membuat Esai',
            dueDate: 'Jumat, 25 Okt 2024',
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentItem({required String subject, required String title, required String dueDate}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Text(dueDate, style: const TextStyle(color: Colors.red, fontSize: 12)),
      ],
    );
  }
}
