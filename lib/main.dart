import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';
import 'screens/login_screen.dart';

/// ============================================================================
/// MODUL 1 - 4: ENTRY POINT & ROOT APLIKASI FLUTTER
/// ============================================================================
/// [main] adalah fungsi utama (entry point) dalam bahasa pemrograman Dart (Bab 3.3.5).
/// Fungsi [runApp] bertugas mengikat root widget ke layar perangkat.
/// ============================================================================
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Pengaturan tema status bar & navigation bar sistem Android
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF1F3D2B),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const PanenaraApp());
}

/// ============================================================================
/// MODUL 4.2.1: WIDGET MATERIALAPP
/// ============================================================================
/// [MaterialApp] adalah titik awal untuk aplikasi berbasis Material Design.
/// Widget ini bertindak sebagai papan dasar (kanvas utama) yang mendefinisikan
/// tema aplikasi, konfigurasi navigasi, dan judul aplikasi (Bab 4.2.1 Modul).
/// ============================================================================
class PanenaraApp extends StatelessWidget {
  const PanenaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panenara',
      debugShowCheckedModeBanner: false,

      // Konfigurasi ThemeData aplikasi (Material Design 3)
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF3F6F2),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF258149),
          brightness: Brightness.light,
        ),
      ),

      // Halaman awal aplikasi: Splash Screen handler
      home: const _SplashFlowHandler(),
    );
  }
}

/// ============================================================================
/// MODUL 5.1.2: STATEFUL WIDGET UNTUK PENGELOLAAN ALUR SPLASH
/// ============================================================================
/// Menggunakan [StatefulWidget] karena memiliki state internal [_hasNavigated]
/// yang berubah saat transisi dari splash screen ke halaman login (Bab 5.1.2 Modul).
/// ============================================================================
class _SplashFlowHandler extends StatefulWidget {
  const _SplashFlowHandler();

  @override
  State<_SplashFlowHandler> createState() => _SplashFlowHandlerState();
}

class _SplashFlowHandlerState extends State<_SplashFlowHandler> {
  // Variabel penanda apakah navigasi sudah dieksekusi agar tidak dobel
  bool _hasNavigated = false;

  /// Metode untuk berpindah ke halaman Login menggunakan [Navigator.pushReplacement]
  /// (Sesuai Bab 5.3.4 Navigasi Antar Halaman pada Modul)
  void _navigateToLogin() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Animasi FadeTransition halus saat transisi halaman
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PanenaraSplashScreen(
      onAnimationComplete: () {
        // Jeda singkat 400ms setelah animasi splash selesai, lalu navigasi ke Login
        Future.delayed(const Duration(milliseconds: 400), _navigateToLogin);
      },
    );
  }
}
