import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/panenara_widgets.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty) {
      _showSnackbar('Silakan masukkan nama lengkap Anda.');
      return;
    }
    if (email.isEmpty) {
      _showSnackbar('Silakan masukkan alamat email Anda.');
      return;
    }
    if (phone.isEmpty) {
      _showSnackbar('Silakan masukkan nomor WhatsApp Anda.');
      return;
    }
    if (password.length < 8) {
      _showSnackbar('Kata sandi minimal harus 8 karakter.');
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(
          destination: phone.isNotEmpty ? '+62 $phone' : email,
        ),
      ),
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Top Bar: Back Button on left, Brand Logo on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                PanenaraBackButton(),
                PanenaraBrandLogo(iconSize: 24, fontSize: 20),
              ],
            ),
            const SizedBox(height: 22),

            // Title
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

            // Subtitle
            Text(
              'Silakan lengkapi formulir pendaftaran untuk mulai menikmati fitur Panenara.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // 1. Nama Lengkap
            Text(
              'Nama Lengkap',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            PanenaraInputField(
              controller: _nameController,
              hintText: 'Masukkan nama lengkap',
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                size: 19,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 14),

            // 2. Alamat Email
            Text(
              'Alamat Email',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            PanenaraInputField(
              controller: _emailController,
              hintText: 'nama@email.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                size: 19,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 14),

            // 3. Nomor WhatsApp
            Text(
              'Nomor WhatsApp',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            PanenaraInputField(
              controller: _phoneController,
              hintText: '812 3456 7890',
              keyboardType: TextInputType.phone,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.35),
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

            // 4. Kata Sandi
            Text(
              'Kata Sandi',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            PanenaraPasswordField(
              controller: _passwordController,
              hintText: 'Minimal 8 karakter',
            ),
            const SizedBox(height: 22),

            // Tombol Daftar Sekarang
            PanenaraPrimaryButton(
              text: 'Daftar Sekarang',
              isLoading: _isLoading,
              onPressed: _handleRegister,
            ),
            const SizedBox(height: 18),

            // Footer: Sudah punya akun? Masuk
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
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

            // Terms disclaimer
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
