import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/panenara_widgets.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _identifierController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _handleSendCode() async {
    final identifier = _identifierController.text.trim();
    if (identifier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan masukkan email atau nomor WhatsApp Anda.',
            style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontSize: 13),
          ),
          backgroundColor: const Color(0xFF1E3C2A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(
          destination: identifier,
          isResetPassword: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PanenaraAuthScaffold(
      backgroundImage: 'assets/images/bg_forgot.jpg',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                PanenaraBackButton(),
                PanenaraBrandLogo(iconSize: 24, fontSize: 20),
              ],
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Lupa Kata Sandi?',
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
              'Masukkan email atau nomor WhatsApp yang terdaftar. Kami kirim kode OTP untuk mengatur ulang kata sandi.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),

            // Label
            Text(
              'Email atau Nomor WhatsApp',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Input
            PanenaraInputField(
              controller: _identifierController,
              hintText: 'Masukkan email atau nomor WhatsApp',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                size: 19,
                color: Colors.white.withValues(alpha: 0.85),
              ),
              onSubmitted: (_) => _handleSendCode(),
            ),
            const SizedBox(height: 24),

            // Button
            PanenaraPrimaryButton(
              text: 'Kirim Kode',
              isLoading: _isLoading,
              onPressed: _handleSendCode,
            ),
            const SizedBox(height: 20),

            // Footer
            Center(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: RichText(
                    text: TextSpan(
                      text: 'Ingat kata sandi? ',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                      children: [
                        TextSpan(
                          text: 'Kembali masuk',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
