// main.dart
// -------------------------------------------------------------------
// Dibuat : Umar Ulkhak
// Update : 2 November 2025
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Impor provider
import 'providers/main_screen_provider.dart';

// Impor halaman-halaman yang digunakan di MainScreen
import 'views/dashboard_page.dart';
import 'views/grades_page.dart';
import 'views/schedule_page.dart';
import 'views/profile_page.dart';

void main() {
  // 💡 PROFESIONAL: Gunakan Provider untuk state management.
  // Ini memungkinkan state diakses dan diubah secara terpusat.
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainScreenProvider(),
      child: const MyApp(),
    ),
  );
}

// ====================================================================
// WIDGET UTAMA: MyApp (Mengatur Tema Global)
// ====================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // KONFIGURASI TEMA
    const seedColor = Color(0xFF1A237E); // Dark Blue

    return MaterialApp(
      title: 'SMP Muhammadiyah Larangan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',

        // 💡 PERBAIKAN: ColorScheme lebih lengkap.
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light, // Eksplisit untuk tema terang
          primary: seedColor,
          secondary: const Color(0xFF455A64),
          // --- Tambahkan ini untuk konsistensi ---
          error: const Color(0xFFD32F2F), // Warna standar Material untuk error
          onError: Colors.white,
          // ---------------------------------------
          background: const Color(0xFFF9FAFB),
          surface: Colors.white,
          onPrimary: Colors.white,
          onBackground: const Color(0xFF333333),
          onSurface: const Color(0xFF333333),
          surfaceContainerHighest: const Color(0xFFF1F3F6),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9FAFB),
          elevation: 1,
          scrolledUnderElevation: 2.0,
          foregroundColor: Color(0xFF333333),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

// ====================================================================
// WIDGET LAYOUT: MainScreen (Sekarang menjadi StatelessWidget)
// ====================================================================
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Daftar halaman tetap sama.
  final List<Widget> _pages = const [
    DashboardPage(),
    GradesPage(),
    SchedulePage(),
    ProfilePage(),
  ];

  // Fungsi pembantu dipindahkan ke sini, menjadi fungsi statis atau top-level
  // agar tetap bisa diakses tanpa state.
  Widget _gradientIcon(IconData icon) {
    const Gradient indicatorGradient = LinearGradient(
      colors: [Color(0xFF1A237E), Color(0xFF3F51B5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return ShaderMask(
      shaderCallback: (Rect bounds) => indicatorGradient.createShader(bounds),
      child: Icon(icon, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 💡 PROFESIONAL: Mengakses state dari MainScreenProvider.
    // 'watch' akan membuat widget ini rebuild saat notifyListeners() dipanggil.
    final screenProvider = context.watch<MainScreenProvider>();

    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBody: true,
      body: PageView(
        // Gunakan controller dan fungsi dari provider
        controller: screenProvider.pageController,
        onPageChanged: screenProvider.onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + bottomPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: NavigationBar(
              // Gunakan fungsi dan state dari provider
              onDestinationSelected: screenProvider.onNavBarTap,
              selectedIndex: screenProvider.currentIndex,
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: colorScheme.primary.withOpacity(0.1),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.dashboard_outlined),
                  selectedIcon: _gradientIcon(Icons.dashboard_rounded),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.bar_chart_outlined),
                  selectedIcon: _gradientIcon(Icons.bar_chart_rounded),
                  label: 'Nilai',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.calendar_month_outlined),
                  selectedIcon: _gradientIcon(Icons.calendar_month_rounded),
                  label: 'Jadwal',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outline_rounded),
                  selectedIcon: _gradientIcon(Icons.person_rounded),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
