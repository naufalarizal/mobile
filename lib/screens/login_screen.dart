import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/panenara_widgets.dart';
import 'register_screen.dart';
import 'home_screen.dart';

/// ============================================================================
/// MODUL 5: MANAJEMEN STATE DAN NAVIGASI (CHAPTER 5)
/// ============================================================================
/// [LoginScreen] mengimplementasikan:
/// - [StatefulWidget] (Bab 5.1.2) untuk mengelola input formulir dan status loading.
/// - [TextEditingController] (Bab 5.2.3) untuk membaca data teks input pengguna.
/// - [SnackBar] (Bab 5.2.2) via [ScaffoldMessenger] untuk menampilkan notifikasi validasi.
/// - [Navigator.push] dan [Navigator.pushReplacement] (Bab 5.3.4) untuk navigasi halaman.
/// - Pemrograman Asinkron Dart [async]/[await] (Bab 3.3.6) untuk simulasi proses login.
/// ============================================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk menangani input email/telepon dan kata sandi (Bab 5.2.3)
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variabel untuk checkbox 'Ingat Saya' dan indikator loading
  bool _rememberMe = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    // Membersihkan controller dari memori saat widget dihancurkan (best practice)
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Logika otentikasi login email / nomor WhatsApp
  /// Menggunakan async/await sesuai Bab 3.3.6 Dart Async
  void _handleLogin() async {
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text.trim();

    // Validasi input pengguna
    if (identifier.isEmpty) {
      _showSnackbar('Silakan masukkan email atau nomor WhatsApp Anda.');
      return;
    }
    if (password.isEmpty) {
      _showSnackbar('Silakan masukkan kata sandi Anda.');
      return;
    }

    setState(() => _isLoading = true);

    // Simulasi delay request login asinkron
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigasi ke halaman beranda utama (Bab 5.3.4)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  /// Logika login menggunakan akun Google (Opsi instan)
  void _handleGoogleLogin() async {
    setState(() => _isGoogleLoading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  /// Menampilkan pesan notifikasi pop-up bawah menggunakan SnackBar (Bab 5.2.2 Modul)
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontSize: 13),
        ),
        backgroundColor: const Color(0xFF1E3C2A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PanenaraAuthScaffold(
      backgroundImage: 'assets/images/bg_login.jpg',
      child: SingleChildScrollView(
        // Layout SingleChildScrollView untuk mencegah overflow pada layar kecil (Bab 4.4.5 & 4.5.3)
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          // Susunan elemen antarmuka vertikal dari atas ke bawah (Bab 4.4.2 Column)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // 1. Logo Brand
            const PanenaraBrandLogo(iconSize: 26, fontSize: 21),
            const SizedBox(height: 28),

            // 2. Judul Halaman
            Text(
              'Masuk',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 6),

            // 3. Subjudul
            Text(
              'Masuk untuk melanjutkan menggunakan aplikasi.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // 4. Input Label & Form Email / WhatsApp (Bab 5.2.3 TextField)
            Text(
              'Email atau Nomor WhatsApp',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            PanenaraInputField(
              controller: _identifierController,
              hintText: 'Masukkan email atau nomor WhatsApp',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                size: 19,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 16),

            // 5. Input Label & Form Kata Sandi
            Text(
              'Kata Sandi',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            PanenaraPasswordField(
              controller: _passwordController,
              hintText: 'Masukkan kata sandi',
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 12),

            // 6. Checkbox Ingat Saya (Bab 4.4.3 Row)
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _rememberMe = !_rememberMe),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: _rememberMe ? Colors.white : Colors.transparent,
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _rememberMe
                            ? const Icon(Icons.check_rounded,
                                size: 12, color: Color(0xFF1C3A2B))
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Ingat saya',
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),

            // 7. Tombol Aksi Utama: Masuk (Bab 4.3.3 ElevatedButton)
            PanenaraPrimaryButton(
              text: 'Masuk',
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 20),

            // 8. Garis Pemisah ATAU
            _buildDividerOr(),
            const SizedBox(height: 16),

            // 9. Tombol Masuk dengan Google
            _buildSocialButton(
              onTap: _handleGoogleLogin,
              isLoading: _isGoogleLoading,
              logo: _GoogleLogo(),
              label: 'Lanjutkan dengan Google',
            ),
            const SizedBox(height: 24),

            // 10. Navigasi ke Halaman Pendaftaran (Bab 5.3.4 Navigator.push)
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Helper widget untuk garis pemisah ATAU (Bab 4.4.3 Row & Expanded)
  Widget _buildDividerOr() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'ATAU',
            style: GoogleFonts.schibstedGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.7),
              letterSpacing: 1.0,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }

  /// Helper widget tombol sosial media / Google
  Widget _buildSocialButton({
    required VoidCallback onTap,
    required bool isLoading,
    required Widget logo,
    required String label,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Color(0xFF258149),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1C1C1E),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Logo Google berbasis vektor CustomPainter (Bab 4.3 Visible Widget)
class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2;

    final segments = [
      _Segment(startAngle: -0.5236, sweepAngle: 1.5708, color: const Color(0xFFEA4335)),
      _Segment(startAngle: 1.0472, sweepAngle: 1.5708, color: const Color(0xFFFBBC05)),
      _Segment(startAngle: 2.6180, sweepAngle: 1.5708, color: const Color(0xFF34A853)),
      _Segment(startAngle: -2.0944, sweepAngle: 1.5708, color: const Color(0xFF4285F4)),
    ];

    for (final seg in segments) {
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.75),
        seg.startAngle,
        seg.sweepAngle,
        false,
        paint,
      );
    }

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), r * 0.42, whitePaint);

    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx, cy - r * 0.13, r * 0.75, r * 0.26),
        const Radius.circular(2),
      ),
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Segment {
  final double startAngle;
  final double sweepAngle;
  final Color color;
  const _Segment({
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
  });
}
