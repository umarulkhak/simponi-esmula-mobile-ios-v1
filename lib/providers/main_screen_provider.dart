// lib/providers/main_screen_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Impor untuk Haptic Feedback

/// Provider untuk mengelola state dari MainScreen.
/// Termasuk index halaman aktif dan kontroler untuk PageView.
class MainScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Getter untuk mengakses state dari luar
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Dipanggil ketika halaman di PageView berganti (karena digeser).
  void onPageChanged(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      // Memberi tahu semua widget yang "mendengarkan" bahwa ada perubahan.
      notifyListeners();
    }
  }

  /// Dipanggil ketika item di NavigationBar di-tap.
  void onNavBarTap(int index) {
    // Tambahkan getaran halus saat di-tap
    HapticFeedback.lightImpact();

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
}
