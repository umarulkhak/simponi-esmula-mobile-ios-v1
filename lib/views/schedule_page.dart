import 'package:flutter/material.dart';

// --- MODEL DATA & DATA DUMMY ---

// Model untuk item jadwal
class ScheduleData {
  final String time;
  final String subject;
  final String room;
  final IconData icon;

  ScheduleData({
    required this.time,
    required this.subject,
    required this.room,
    required this.icon,
  });
}

// Data dummy untuk 5 hari
final Map<String, List<ScheduleData>> dummySchedules = {
  'Senin': [
    ScheduleData(time: '07.00 – 08.30', subject: 'Matematika', room: 'R.7A', icon: Icons.calculate_rounded),
    ScheduleData(time: '08.40 – 10.10', subject: 'IPA', room: 'Lab IPA', icon: Icons.science_rounded),
    ScheduleData(time: '10.20 – 11.50', subject: 'Bahasa Indonesia', room: 'R.7A', icon: Icons.book_rounded),
    ScheduleData(time: '13.00 – 14.30', subject: 'PKN', room: 'R.7A', icon: Icons.flag_rounded),
  ],
  'Selasa': [
    ScheduleData(time: '07.00 – 08.30', subject: 'Bahasa Inggris', room: 'Lab Bahasa', icon: Icons.language_rounded),
    ScheduleData(time: '08.40 – 10.10', subject: 'PJOK', room: 'Lapangan', icon: Icons.sports_basketball_rounded),
    ScheduleData(time: '10.20 – 11.50', subject: 'IPS', room: 'R.7A', icon: Icons.public_rounded),
    ScheduleData(time: '13.00 – 14.30', subject: 'Seni Budaya', room: 'R. Kesenian', icon: Icons.palette_rounded),
  ],
  'Rabu': [
    ScheduleData(time: '07.00 – 08.30', subject: 'Matematika', room: 'R.7A', icon: Icons.calculate_rounded),
    ScheduleData(time: '08.40 – 10.10', subject: 'IPA', room: 'Lab IPA', icon: Icons.science_rounded),
    ScheduleData(time: '10.20 – 11.50', subject: 'Bahasa Indonesia', room: 'R.7A', icon: Icons.book_rounded),
    ScheduleData(time: '13.00 – 14.30', subject: 'Agama', room: 'Musholla', icon: Icons.mosque_rounded),
  ],
  'Kamis': [
    ScheduleData(time: '07.00 – 08.30', subject: 'Bahasa Inggris', room: 'Lab Bahasa', icon: Icons.language_rounded),
    ScheduleData(time: '08.40 – 10.10', subject: 'IPS', room: 'R.7A', icon: Icons.public_rounded),
    ScheduleData(time: '10.20 – 11.50', subject: 'Prakarya', room: 'R. Keterampilan', icon: Icons.build_rounded),
  ],
  'Jumat': [
    ScheduleData(time: '07.00 – 08.30', subject: 'PJOK', room: 'Lapangan', icon: Icons.sports_basketball_rounded),
    ScheduleData(time: '08.40 – 10.10', subject: 'Matematika', room: 'R.7A', icon: Icons.calculate_rounded),
  ],
};

// --- WIDGET UTAMA (SCHEDULE PAGE) ---

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

// Gunakan SingleTickerProviderStateMixin untuk TabController
class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = dummySchedules.keys.toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _days.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // NestedScrollView diperlukan untuk SliverAppBar dengan TabBarView
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Jadwal Pelajaran'),
              backgroundColor: colorScheme.background,
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled, // Bayangan appbar saat scroll
              scrolledUnderElevation: 2.0,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: false, // Set false jika 5 tab cukup
                labelColor: colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: colorScheme.primary,
                indicatorWeight: 3.0,
                tabs: _days.map((day) => Tab(text: day)).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          // Buat widget list terpisah untuk setiap hari
          children: _days.map((day) {
            return _ScheduleDayList(
              key: ValueKey(day), // Penting untuk performa TabBarView
              schedule: dummySchedules[day] ?? [],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// --- WIDGET DAFTAR JADWAL PER HARI (DENGAN ANIMASI) ---

class _ScheduleDayList extends StatefulWidget {
  final List<ScheduleData> schedule;

  const _ScheduleDayList({super.key, required this.schedule});

  @override
  State<_ScheduleDayList> createState() => _ScheduleDayListState();
}

class _ScheduleDayListState extends State<_ScheduleDayList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimations = List.generate(
      widget.schedule.length,
          (index) => Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 * (index / widget.schedule.length),
            0.5 + 0.1 * (index / widget.schedule.length),
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
    if (widget.schedule.isEmpty) {
      return const Center(child: Text('Tidak ada jadwal hari ini.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: widget.schedule.length,
      itemBuilder: (context, index) {
        final item = widget.schedule[index];

        // Terapkan animasi fade dan slide
        return FadeTransition(
          opacity: CurvedAnimation(parent: _controller, curve: Interval(0.1 * (index / widget.schedule.length), 1.0)),
          child: SlideTransition(
            position: _slideAnimations[index],
            child: _ScheduleItem(
              subject: item.subject,
              time: item.time,
              room: item.room,
              icon: item.icon,
              // Beri warna unik untuk setiap item
              color: Colors.accents[index % Colors.accents.length].shade700,
            ),
          ),
        );
      },
    );
  }
}

// --- WIDGET ITEM JADWAL YANG DIDESAIN ULANG ---

class _ScheduleItem extends StatelessWidget {
  final String time;
  final String subject;
  final String room;
  final IconData icon;
  final Color color; // Warna aksen untuk item

  const _ScheduleItem({
    required this.time,
    required this.subject,
    required this.room,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),

          // 2. Info Utama (Mapel & Waktu)
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
                const SizedBox(height: 4),
                Text(
                  time,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600, // Jam dibuat tebal
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // 3. Info Ruangan (dibuat seperti 'badge')
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded, size: 14, color: colorScheme.onSurface.withOpacity(0.7)),
                const SizedBox(width: 4),
                Text(
                  room,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withOpacity(0.9),
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