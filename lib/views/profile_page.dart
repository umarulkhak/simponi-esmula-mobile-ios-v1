import 'package:flutter/material.dart';

// Ubah menjadi StatefulWidget untuk Animasi
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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

    // Animasi staggered untuk 3 bagian: Info Siswa, Info Wali, Info Akun
    _staggeredAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeOutCubic),
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

  // Helper untuk menerapkan animasi fade + slide
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

    return Scaffold(
      backgroundColor: colorScheme.background,
      // Menggunakan CustomScrollView untuk App Bar yang dinamis
      body: CustomScrollView(
        slivers: [
          // 1. AppBar yang bisa membesar
          SliverAppBar(
            backgroundColor: colorScheme.surface, // Latar belakang header
            foregroundColor: colorScheme.onSurface, // Teks & ikon di header
            elevation: 1,
            pinned: true, // Tetap terlihat saat di-scroll
            stretch: true, // Efek 'stretch' saat ditarik
            expandedHeight: 280.0, // Tinggi saat AppBar besar
            scrolledUnderElevation: 2.0,
            title: const Text('Profil Siswa'), // Judul saat AppBar kecil
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfileHeader(), // Konten saat AppBar besar
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
            ),
          ),

          // 2. Konten Halaman (Daftar Info)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Bagian Informasi Siswa
                  _buildStaggered(
                    0,
                    _InfoSection(
                      title: 'Informasi Siswa',
                      children: [
                        _InfoTile(
                          icon: Icons.person_pin_rounded,
                          label: 'NIS',
                          value: '2025001',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Bagian Informasi Wali
                  _buildStaggered(
                    1,
                    _InfoSection(
                      title: 'Informasi Wali',
                      children: [
                        _InfoTile(
                          icon: Icons.shield_rounded,
                          label: 'Nama Wali',
                          value: 'Umul Muffarokhati',
                        ),
                        _InfoTile(
                          icon: Icons.phone_android_rounded,
                          label: 'No. HP',
                          value: '085711598638',
                        ),
                        _InfoTile(
                          icon: Icons.alternate_email_rounded,
                          label: 'Email',
                          value: 'alikhak24@gmail.com',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Bagian Aksi Akun
                  _buildStaggered(
                    2,
                    _InfoSection(
                      title: 'Akun',
                      children: [
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.red.shade600),
                          title: Text(
                            'Keluar',
                            style: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            // Logika untuk logout
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Berhasil keluar...')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET HEADER PROFIL (UNTUK FLEXIBLE SPACE) ---

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 80.0), // Padding dari status bar + appbar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'studentAvatar', // Tag untuk animasi Hero
            child: CircleAvatar(
              radius: 60,
              backgroundColor: colorScheme.background,
              backgroundImage: NetworkImage('https://picsum.photos/150/150'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Evans Gemilang',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Kelas 8A – SMP Muhammadiyah Larangan',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET KARTU INFO ---

class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium
                ?.copyWith(color: colorScheme.primary, fontSize: 16),
          ),
          const Divider(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// --- WIDGET ITEM INFO (PENGGANTI _buildRow) ---

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: colorScheme.primary.withOpacity(0.8)),
      title: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
      ),
    );
  }
}