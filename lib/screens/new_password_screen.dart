import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/panenara_widgets.dart';
import 'success_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSavePassword() async {
    final newPass = _newPasswordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    if (newPass.length < 8) {
      _showSnackbar('Kata sandi baru minimal 8 karakter.');
      return;
    }
    if (newPass != confirmPass) {
      _showSnackbar('Konfirmasi kata sandi tidak cocok.');
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const SuccessScreen(
          title: 'Kata Sandi Diperbarui',
          subtitle:
              'Kata sandi baru sudah tersimpan. Masuk dengan kata sandi baru untuk melanjutkan.',
          buttonText: 'Masuk Sekarang',
          isPasswordUpdated: true,
        ),
      ),
      (route) => false,
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
      backgroundImage: 'assets/images/bg_new_password.jpg',
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
              'Atur Kata Sandi Baru',
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
              'Buat kata sandi baru yang belum pernah dipakai di akun ini.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),

            // Label 1
            Text(
              'Kata Sandi Baru',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            PanenaraPasswordField(
              controller: _newPasswordController,
              hintText: 'Minimal 8 karakter',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Label 2
            Text(
              'Ulangi Kata Sandi',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            PanenaraPasswordField(
              controller: _confirmPasswordController,
              hintText: 'Ketik ulang kata sandi',
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleSavePassword(),
            ),
            const SizedBox(height: 8),

            // Hint
            Text(
              'Minimal 8 karakter.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 11.5,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 26),

            // Button
            PanenaraPrimaryButton(
              text: 'Simpan Kata Sandi',
              isLoading: _isLoading,
              onPressed: _handleSavePassword,
            ),
          ],
        ),
      ),
    );
  }
}
