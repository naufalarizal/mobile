import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/panenara_widgets.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text.trim();

    if (identifier.isEmpty) {
      _showSnackbar('Silakan masukkan email atau nomor WhatsApp Anda.');
      return;
    }
    if (password.isEmpty) {
      _showSnackbar('Silakan masukkan kata sandi Anda.');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate login delay
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigate to Home screen
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.schibstedGrotesk(
            color: Colors.white,
            fontSize: 13,
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // 1. Top Brand Logo (Wheat Icon + Panenara Wordmark)
            const PanenaraBrandLogo(iconSize: 26, fontSize: 21),
            const SizedBox(height: 28),

            // 2. Title: Masuk
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

            // 3. Subtitle
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

            // 4. Label: Email atau Nomor WhatsApp
            Text(
              'Email atau Nomor WhatsApp',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // 5. Input: Email atau Nomor WhatsApp (Glassmorphism)
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

            // 6. Label: Kata Sandi
            Text(
              'Kata Sandi',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // 7. Input: Kata Sandi with visibility toggle (Glassmorphism)
            PanenaraPasswordField(
              controller: _passwordController,
              hintText: 'Masukkan kata sandi',
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 12),

            // 8. Row: Ingat Saya & Lupa Kata Sandi?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ingat Saya Checkbox
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _rememberMe = !_rememberMe;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: _rememberMe
                              ? Colors.white
                              : Colors.transparent,
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _rememberMe
                            ? const Icon(
                                Icons.check_rounded,
                                size: 12,
                                color: Color(0xFF1C3A2B),
                              )
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Ingat saya',
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Lupa Kata Sandi Link
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Lupa Kata Sandi?',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),

            // 9. Tombol Masuk
            PanenaraPrimaryButton(
              text: 'Masuk',
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 22),

            // 10. Footer: Belum punya akun? Daftar
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 2,
                      ),
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
}
