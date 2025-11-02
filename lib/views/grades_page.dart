import 'package:flutter/material.dart';

// Model sederhana untuk data nilai (lebih baik daripada hardcoding di build)
class GradeData {
  final String subject;
  final int score;
  final String grade;
  final IconData icon;

  GradeData({
    required this.subject,
    required this.score,
    required this.grade,
    required this.icon,
  });
}

// Data dummy untuk halaman nilai
final List<GradeData> dummyGrades = [
  GradeData(subject: 'Matematika', score: 85, grade: 'A-', icon: Icons.calculate_rounded),
  GradeData(subject: 'IPA', score: 90, grade: 'A', icon: Icons.science_rounded),
  GradeData(subject: 'IPS', score: 78, grade: 'B+', icon: Icons.public_rounded),
  GradeData(subject: 'Bahasa Indonesia', score: 88, grade: 'A-', icon: Icons.book_rounded),
  GradeData(subject: 'PKN', score: 92, grade: 'A', icon: Icons.flag_rounded),
  GradeData(subject: 'Bahasa Inggris', score: 82, grade: 'B+', icon: Icons.language_rounded),
  GradeData(subject: 'PJOK', score: 95, grade: 'A', icon: Icons.sports_basketball_rounded),
  GradeData(subject: 'Seni Budaya', score: 80, grade: 'B+', icon: Icons.palette_rounded),
];

// Ubah menjadi StatefulWidget untuk mengelola animasi
class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Membuat animasi slide staggered untuk setiap item
    _slideAnimations = List.generate(
      dummyGrades.length,
          (index) => Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 * (index / dummyGrades.length), // Mulai animasi secara bertahap
            0.5 + 0.1 * (index / dummyGrades.length), // Selesaikan
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Menggunakan CustomScrollView untuk AppBar yang dinamis
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Nilai Akademik'),
            backgroundColor: Theme.of(context).colorScheme.background,
            pinned: true,
            floating: true,
            snap: true,
            scrolledUnderElevation: 2.0,
          ),

          // Wrapper untuk konten agar memiliki padding
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // 1. Kartu Header Rangkuman
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const _GradesHeader(),
                  ),
                  const SizedBox(height: 24),

                  // Judul untuk daftar nilai
                  Text(
                    'Rincian Mata Pelajaran',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),

                  // 2. Daftar Nilai (dengan animasi)
                  ...List.generate(dummyGrades.length, (index) {
                    final item = dummyGrades[index];
                    // Terapkan animasi fade dan slide ke setiap item
                    return FadeTransition(
                      opacity: CurvedAnimation(parent: _controller, curve: Interval(0.1 * (index / dummyGrades.length), 1.0)),
                      child: SlideTransition(
                        position: _slideAnimations[index],
                        child: _GradeItem(
                          subject: item.subject,
                          score: item.score,
                          grade: item.grade,
                          icon: item.icon,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET KARTU HEADER ---

class _GradesHeader extends StatelessWidget {
  const _GradesHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Stat Rata-rata
          Column(
            children: [
              Text(
                'Rata-rata Semester',
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                '86.5',
                style: textTheme.titleLarge
                    ?.copyWith(color: Colors.white, fontSize: 26),
              ),
            ],
          ),
          // Pemisah
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withOpacity(0.3),
          ),
          // Stat Peringkat
          Column(
            children: [
              Text(
                'Peringkat Kelas',
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                '3 / 32',
                style: textTheme.titleLarge
                    ?.copyWith(color: Colors.white, fontSize: 26),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- WIDGET ITEM NILAI YANG DIDESAINK ULANG ---

class _GradeItem extends StatelessWidget {
  final String subject;
  final int score;
  final String grade;
  final IconData icon;

  const _GradeItem({
    required this.subject,
    required this.score,
    required this.grade,
    required this.icon,
  });

  // Helper untuk menentukan warna berdasarkan nilai
  Color _getGradeColor(String grade, ColorScheme colorScheme) {
    if (grade.startsWith('A')) return colorScheme.primary;
    if (grade.startsWith('B')) return colorScheme.secondary;
    if (grade.startsWith('C')) return Colors.orange.shade700;
    return Colors.red.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gradeColor = _getGradeColor(grade, colorScheme);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Ikon Mata Pelajaran
          CircleAvatar(
            radius: 24,
            backgroundColor: gradeColor.withOpacity(0.1),
            child: Icon(icon, color: gradeColor, size: 26),
          ),
          const SizedBox(width: 16),

          // 2. Nama Pelajaran dan Skor
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Nilai Akhir: $score',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // 3. Visualisasi Nilai (Progress Ring)
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: score / 100.0,
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  color: gradeColor,
                  backgroundColor: colorScheme.background,
                ),
                Center(
                  child: Text(
                    grade,
                    style: textTheme.labelLarge
                        ?.copyWith(color: gradeColor, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}