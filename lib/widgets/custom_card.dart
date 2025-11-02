import 'package:flutter/material.dart';

/// Sebuah Card kustom dengan style bayangan dan radius yang konsisten
/// untuk digunakan di seluruh aplikasi.
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.margin,
    this.padding = const EdgeInsets.all(16.0),
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // Menggunakan Card bawaan Flutter lebih disarankan karena menghormati tema
      elevation: 0, // Kita akan atur bayangan sendiri melalui Container
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: color ?? theme.colorScheme.surface,
      clipBehavior: Clip.antiAlias, // Penting agar InkWell tidak keluar dari border
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding!,
          child: child,
        ),
      ),
    );
  }
}
