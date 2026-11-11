import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/panenara_widgets.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final bool isPasswordUpdated;

  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.isPasswordUpdated = false,
  });

  @override
  Widget build(BuildContext context) {
    return PanenaraAuthScaffold(
      backgroundImage: 'assets/images/bg_success.jpg',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            const Spacer(flex: 3),

            // Big Green Checkmark Circle matching Figma
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF2C6B46),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2C6B46).withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 44,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 28),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFE6EFE3).withValues(alpha: 0.85),
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Panenara Brand Logo
            const PanenaraBrandLogo(iconSize: 26, fontSize: 21),

            const Spacer(flex: 4),

            // Bottom Action Button
            PanenaraPrimaryButton(
              text: buttonText,
              onPressed: () {
                if (isPasswordUpdated) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
