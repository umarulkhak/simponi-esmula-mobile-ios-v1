// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simponi_v_01/providers/main_screen_provider.dart';
import 'package:simponi_v_01/views/dashboard_page.dart';
import 'package:simponi_v_01/views/grades_page.dart';
import 'package:simponi_v_01/views/profile_page.dart';
import 'package:simponi_v_01/views/schedule_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainScreenProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF007BFF); // Warna biru cerah dan profesional
    const backgroundColor = Color(0xFFF5F7FA);

    return MaterialApp(
      title: 'Simponi Akademik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          background: backgroundColor,
          surface: Colors.white,
          onSurface: const Color(0xFF1B2537), // Warna teks utama
          secondary: const Color(0xFF6C757D), // Warna teks sekunder
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 1.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B2537),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Color(0xFF1B2537)),
          titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF1B2537)),
          bodyMedium: TextStyle(color: Color(0xFF6C757D)),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _pages = const [
    DashboardPage(),
    GradesPage(),
    SchedulePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenProvider = context.watch<MainScreenProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: PageView(
        controller: screenProvider.pageController,
        onPageChanged: screenProvider.onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: NavigationBar(
          onDestinationSelected: screenProvider.onNavBarTap,
          selectedIndex: screenProvider.currentIndex,
          backgroundColor: colorScheme.surface,
          elevation: 0,
          indicatorColor: colorScheme.primary.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              selectedIcon: Icon(Icons.school_rounded),
              label: 'Nilai',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today_rounded),
              label: 'Jadwal',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
