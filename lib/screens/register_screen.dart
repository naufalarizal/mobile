import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/panenara_widgets.dart';
import 'home_screen.dart';
import 'login_screen.dart';

/// ============================================================================
/// MODUL 5: MANAJEMEN STATE & FORMULIR PENDAFTARAN (CHAPTER 5)
/// ============================================================================
/// [RegisterScreen] mengimplementasikan pendaftaran akun baru:
/// - [StatefulWidget] (Bab 5.1.2) untuk mengelola input formulir dan loading state.
/// - [TextEditingController] (Bab 5.2.3) untuk mengontrol nilai field nomor telepon.
/// - [SnackBar] (Bab 5.2.2) via [ScaffoldMessenger] untuk validasi data input.
/// - [Navigator.pushReplacement] (Bab 5.3.4) untuk navigasi langsung ke halaman utama.
/// ============================================================================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controller untuk input nomor telepon (Bab 5.2.3 TextField)
  final _phoneController = TextEditingController();

  // State loading untuk tombol lanjut & Google
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    // Membebaskan controller saat halaman ditutup (mencegah memory leak)
    _phoneController.dispose();
    super.dispose();
  }

  /// Menangani pendaftaran melalui nomor telepon
  void _handleRegister() async {
    final phone = _phoneController.text.trim();

    // Validasi input: memastikan nomor telepon tidak kosong
    if (phone.isEmpty) {
      _showSnackbar('Silakan masukkan nomor telepon Anda.');
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigasi langsung ke HomeScreen (Bab 5.3.4)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  /// Menangani pendaftaran instan melalui akun Google
  void _handleGoogleRegister() async {
    setState(() => _isGoogleLoading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  /// Menampilkan pesan notifikasi pop-up bawah menggunakan SnackBar (Bab 5.2.2)
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PanenaraAuthScaffold(
      backgroundImage: 'assets/images/bg_register.jpg',
      child: SingleChildScrollView(
        // Layout SingleChildScrollView untuk mencegah overflow (Bab 4.4.5)
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Top Bar: Tombol Kembali + Logo Brand (Bab 4.4.3 Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                PanenaraBackButton(),
                PanenaraBrandLogo(iconSize: 24, fontSize: 20),
              ],
            ),
            const SizedBox(height: 28),

            // Judul Halaman Pendaftaran
            Text(
              'Buat Akun Baru',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Daftar dengan nomor telepon atau akun Google Anda.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 13,
                color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            // Form Input Nomor Telepon (Bab 5.2.3 TextField)
            Text(
              'No. Telepon',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            PanenaraInputField(
              controller: _phoneController,
              hintText: '812 3456 7890',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleRegister(),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+62',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Tombol Aksi Utama: Lanjut (Bab 4.3.3 ElevatedButton)
            PanenaraPrimaryButton(
              text: 'Lanjut',
              isLoading: _isLoading,
              onPressed: _handleRegister,
            ),
            const SizedBox(height: 20),

            // Garis Pemisah ATAU
            _buildDividerOr(),
            const SizedBox(height: 16),

            // Tombol Daftar dengan Google
            _buildSocialButton(
              onTap: _handleGoogleRegister,
              isLoading: _isGoogleLoading,
              logo: _GoogleLogo(),
              label: 'Daftar dengan Google',
            ),
            const SizedBox(height: 28),

            // Link Navigasi Kembali ke Halaman Masuk
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      child: Text(
                        'Masuk',
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
            const SizedBox(height: 14),

            // Catatan Persetujuan Syarat & Ketentuan
            Center(
              child: Text(
                'Dengan mendaftar, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi.',
                textAlign: TextAlign.center,
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.65),
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Garis pemisah ATAU (Bab 4.4.3 Row & Expanded)
  Widget _buildDividerOr() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1, color: Colors.white.withValues(alpha: 0.3)),
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
          child: Container(height: 1, color: Colors.white.withValues(alpha: 0.3)),
        ),
      ],
    );
  }

  /// Tombol aksi sosial media (Google)
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
