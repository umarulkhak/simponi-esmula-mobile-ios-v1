import 'package:flutter/material.dart';

// --- WIDGET-WIDGET KOMPONEN BARU ---

class _AttendanceSection extends StatelessWidget {
  const _AttendanceSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Status Utama (Hadir)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status Hari Ini:',
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                'Hadir Tepat Waktu',
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // 2. Waktu Check-in/out
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Check-in: 06:45',
                style: textTheme.bodySmall
                    ?.copyWith(color: colorScheme.onSurface.withOpacity(0.8)),
              ),
              const SizedBox(height: 4),
              Text(
                'Durasi: 7 jam 30 menit',
                style: textTheme.bodySmall
                    ?.copyWith(color: colorScheme.onSurface.withOpacity(0.8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpcomingTasksSection extends StatelessWidget {
  const _UpcomingTasksSection();

  final List<Map<String, dynamic>> tasks = const [
    {
      'subject': 'Matematika',
      'task': 'PR Aljabar Hal 50',
      'date': 'Besok',
      'color': Colors.red
    },
    {
      'subject': 'Bahasa Inggris',
      'task': 'Kuis Vocabulary',
      'date': 'Rabu',
      'color': Colors.blue
    },
    {
      'subject': 'IPA',
      'task': 'Laporan Praktikum',
      'date': 'Jumat',
      'color': Colors.orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tasks.map((task) {
        final color = task['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 8), // DIKURANGI dari 10
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.assignment_rounded, color: color),
            title: Text(
              task['task'] as String,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              '${task['subject']} • Deadline ${task['date']}',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}

// --- WIDGET-WIDGET KOMPONEN LAMA YANG DIESUAIKAN ---

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16), // DIKURANGI dari 20
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
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
          // Ring progress
          SizedBox(
            height: 70, // DIKURANGI dari 80
            width: 70, // DIKURANGI dari 80
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 0.86),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOutCubic,
                  builder: (context, value, child) {
                    return CircularProgressIndicator(
                      value: value,
                      strokeWidth: 8,
                      strokeCap: StrokeCap.round,
                      color: colorScheme.primary,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    );
                  },
                ),
                Center(
                  child: Text(
                    '86%',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // DIKURANGI dari 20
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rata-rata Nilai Semester',
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Naik 3.2 poin. Target kelas: A-',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  icon: const Icon(Icons.history_rounded, size: 18),
                  label: const Text('Lihat Riwayat'),
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: colorScheme.secondary,
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

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final shortcuts = [
      {
        'icon': Icons.bar_chart_rounded,
        'label': 'Nilai',
        'color': colorScheme.secondary
      },
      {
        'icon': Icons.calendar_month_rounded,
        'label': 'Jadwal',
        'color': colorScheme.tertiary
      },
      {
        'icon': Icons.event_available_rounded,
        'label': 'Absensi',
        'color': Colors.orange.shade700
      },
      {
        'icon': Icons.receipt_long_rounded,
        'label': 'Tagihan',
        'color': Colors.teal.shade600
      },
      {
        'icon': Icons.school_rounded,
        'label': 'Materi',
        'color': Colors.purple.shade600
      },
      {
        'icon': Icons.message_rounded,
        'label': 'Pesan',
        'color': Colors.pink.shade600
      },
    ];

    return GridView.builder(
      itemCount: shortcuts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10, // DIKURANGI dari 12
        mainAxisSpacing: 10, // DIKURANGI dari 12
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final item = shortcuts[index];
        final color = item['color'] as Color;
        final label = item['label'] as String;
        final icon = item['icon'] as IconData;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Buka halaman $label')),
          ),
          child: Container(
            padding: const EdgeInsets.all(8), // DIKURANGI dari 12
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 30),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- HALAMAN UTAMA DASHBOARD ---

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _staggeredAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    // 6 elemen utama yang dianimasikan
    _staggeredAnimations = List.generate(6, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve:
          Interval(0.1 * index, 0.5 + 0.1 * index, curve: Curves.easeOutCubic),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStaggered(int index, Widget child) {
    return FadeTransition(
      opacity: _staggeredAnimations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.1),
          end: Offset.zero,
        ).animate(_staggeredAnimations[index]),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          // 1. App Bar yang dinamis
          SliverAppBar(
            backgroundColor: colorScheme.background,
            elevation: 0,
            scrolledUnderElevation: 1.0,
            pinned: true,
            floating: true,
            snap: true,
            titleSpacing: 20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat datang,',
                    style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.7))),
                Text(
                  'Ibu Umul 👋',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none_rounded,
                    size: 28, color: colorScheme.onBackground),
                onPressed: () {},
                tooltip: 'Notifikasi',
              ),
              const SizedBox(width: 12),
            ],
            expandedHeight: 100.0,
            flexibleSpace: const FlexibleSpaceBar(),
          ),

          // 2. Konten utama (lebih padat)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                16, 0, 16, 20), // Padding horizontal dan bawah
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // 1. Hero Card Siswa
                  _buildStaggered(
                    0,
                    Hero(
                      tag: 'studentCard', // HERO INDUK
                      child: Container(
                        padding: const EdgeInsets.all(16), // DIKURANGI dari 20
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
                          children: [
                            // PERBAIKAN: Menghapus Hero(tag: 'studentAvatar') untuk menghindari nesting.
                            const CircleAvatar(
                              radius: 28, // DIKURANGI dari 30
                              backgroundColor: Colors.white,
                              backgroundImage:
                              NetworkImage('https://picsum.photos/150/150'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              // PERBAIKAN: Expanded mencegah RenderFlex Overflow.
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Evans Gemilang (8A)',
                                    style: textTheme.titleMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Semester Ganjil 2025/2026',
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.white70, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Status Absensi Harian
                  _buildStaggered(
                    1,
                    const _AttendanceSection(),
                  ),
                  const SizedBox(height: 16),

                  // 3. Statistik ring nilai
                  _buildStaggered(
                    2,
                    const ProgressSection(),
                  ),
                  const SizedBox(height: 16), // PERUBAHAN: DARI 24 MENJADI 16

                  // 4. Akses cepat (3 Kolom)
                  _buildStaggered(
                    3,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Akses Cepat',
                            style: textTheme.titleMedium
                                ?.copyWith(color: colorScheme.onBackground)),
                        const SizedBox(height: 12),
                        const QuickAccessGrid(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16), // PERUBAHAN: DARI 24 MENJADI 16

                  // 5. Tugas Mendatang
                  _buildStaggered(
                    4,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tugas Mendatang',
                                style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onBackground)),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Lihat Semua'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const _UpcomingTasksSection(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16), // PERUBAHAN: DARI 24 MENJADI 16

                  // 6. Pengumuman
                  _buildStaggered(
                    5,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pengumuman Terbaru',
                            style: textTheme.titleMedium
                                ?.copyWith(color: colorScheme.onBackground)),
                        const SizedBox(height: 12),
                        const AnnouncementCard(),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height:
                      80), // Padding bawah agar konten tidak tertutup oleh bottom nav bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET LAMA ---

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(color: colorScheme.primary, width: 5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ujian Tengah Semester',
            style:
            textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 6),
          Text(
            '10–14 November 2025',
            style: textTheme.bodyMedium?.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Text(
            'Mohon persiapkan anak Anda untuk mengikuti ujian dengan baik.',
            style: textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
