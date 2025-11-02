// lib/views/profile_page.dart
import 'package:flutter/material.dart';
import 'package:simponi_v_01/models/student_model.dart';
import 'package:simponi_v_01/widgets/custom_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy siswa
    final student = Student(
      name: 'Budi Santoso',
      nis: '181923001',
      className: 'SMP Kelas IX-A',
      photoUrl: '', // Kosongkan untuk menggunakan placeholder
    );

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Siswa'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(context, student, textTheme, colorScheme),
          const SizedBox(height: 24),
          _buildInfoCard(student, textTheme),
          const SizedBox(height: 24),
          _buildActionButtons(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Student student, TextTheme textTheme, ColorScheme colorScheme) {
    return CustomCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: colorScheme.primary.withOpacity(0.1),
            child: Text(
              student.name.substring(0, 1),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            student.name,
            style: textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            student.className,
            style: textTheme.bodyMedium?.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Student student, TextTheme textTheme) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Dasar',
            style: textTheme.titleMedium,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            icon: Icons.person_outline,
            label: 'Nama Wali',
            value: 'Bapak Ahmad',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.credit_card,
            label: 'Nomor Induk Siswa (NIS)',
            value: student.nis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ColorScheme colorScheme) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.payment_outlined),
          label: const Text('Lihat Rincian SPP'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout),
          label: const Text('Keluar dari Akun'),
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            foregroundColor: colorScheme.error,
          ),
        ),
      ],
    );
  }
}
