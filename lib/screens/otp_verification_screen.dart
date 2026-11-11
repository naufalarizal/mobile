import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/panenara_widgets.dart';
import 'new_password_screen.dart';
import 'success_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String destination;
  final bool isResetPassword;

  const OtpVerificationScreen({
    super.key,
    required this.destination,
    this.isResetPassword = false,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _secondsRemaining = 45;
  Timer? _timer;
  bool _isLoading = false;
  bool _hasError = false;
  int _attemptsLeft = 2;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _handleVerify() async {
    final code = _otpCode;
    if (code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan lengkapi 6 digit kode OTP.',
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
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Demo code: accepts '123456' or any code if user didn't test error
    if (code == '654321') {
      // Simulate error scenario from Figma "Autentikasi - OTP gagal"
      setState(() {
        _hasError = true;
        _attemptsLeft = 2;
      });
      return;
    }

    setState(() => _hasError = false);

    if (widget.isResetPassword) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const SuccessScreen(
            title: 'Verifikasi Berhasil',
            subtitle:
                'Selamat datang di Panenara. Lihat-lihat lelang dulu, daftar sebagai petani atau pembeli nanti saat Anda siap.',
            buttonText: 'Masuk ke Beranda',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PanenaraAuthScaffold(
      backgroundImage: 'assets/images/bg_otp.jpg',
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
            const SizedBox(height: 20),

            // Error banner if OTP failed (matching Figma Screen 5)
            if (_hasError) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE53935).withValues(alpha: 0.45),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.priority_high_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verifikasi gagal',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFF8A80),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Kode OTP yang dimasukkan salah atau sudah kedaluwarsa. Coba lagi atau kirim ulang kode.',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 11.5,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Title
            Text(
              'Verifikasi OTP',
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
              'Masukkan 6 digit kode verifikasi yang dikirim ke WhatsApp ${widget.destination}.',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),

            // 6 OTP Box Inputs (Glassmorphism)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                final isLast = index == 5;
                return SizedBox(
                  width: 46,
                  height: 52,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _hasError
                            ? const Color(0xFFE53935)
                            : Colors.white.withValues(alpha: 0.35),
                        width: _hasError ? 1.5 : 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      cursorColor: Colors.white,
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _hasError ? const Color(0xFFFF5252) : Colors.white,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && !isLast) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        if (isLast && val.isNotEmpty && _otpCode.length == 6) {
                          _handleVerify();
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 14),

            // Error notice or Countdown timer
            if (_hasError)
              Center(
                child: Text(
                  'Kode salah, Sisa percobaan: $_attemptsLeft kali.',
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF8A80),
                  ),
                ),
              )
            else
              Center(
                child: Text(
                  _secondsRemaining > 0
                      ? 'Kirim Ulang Kode dalam $_secondsRemaining Detik'
                      : 'Kode dapat dikirim ulang sekarang.',
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Tombol Verifikasi
            PanenaraPrimaryButton(
              text: 'Verifikasi',
              isLoading: _isLoading,
              onPressed: _handleVerify,
            ),
            const SizedBox(height: 18),

            // Resend link
            Center(
              child: GestureDetector(
                onTap: _secondsRemaining == 0
                    ? () {
                        _startCountdown();
                        setState(() => _hasError = false);
                      }
                    : null,
                behavior: HitTestBehavior.opaque,
                child: RichText(
                  text: TextSpan(
                    text: 'Tidak menerima kode? ',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    children: [
                      TextSpan(
                        text: 'Kirim Ulang',
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _secondsRemaining == 0 ? Colors.white : Colors.white54,
                          decoration: _secondsRemaining == 0
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Demo hint
            Center(
              child: Text(
                'Kode demo: 123456 (atau 654321 untuk tes error)',
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
