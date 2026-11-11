import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Clean vector wheat stalk brand icon.
class PanenaraWheatIcon extends StatelessWidget {
  final double size;

  const PanenaraWheatIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 0.7,
      height: size,
      child: CustomPaint(
        painter: _WheatPainter(),
      ),
    );
  }
}

class _WheatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final centerX = w / 2;

    // Stem
    final stemPaint = Paint()
      ..color = const Color(0xFFE6EFE3)
      ..strokeWidth = w * 0.08
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(centerX, h * 0.35),
      Offset(centerX, h * 0.95),
      stemPaint,
    );

    // Grains paint
    final palePaint = Paint()
      ..color = const Color(0xFFE6EFE3)
      ..style = PaintingStyle.fill;

    final goldPaint = Paint()
      ..color = const Color(0xFFE8A33D)
      ..style = PaintingStyle.fill;

    // Top gold grain
    final topRect = Rect.fromCenter(
      center: Offset(centerX, h * 0.22),
      width: w * 0.26,
      height: h * 0.32,
    );
    canvas.drawOval(topRect, goldPaint);

    // 3 side pairs
    final pairYOffsets = [0.42, 0.58, 0.74];
    final grainW = w * 0.24;
    final grainH = h * 0.30;

    for (final py in pairYOffsets) {
      // Left grain (-35 deg)
      canvas.save();
      final leftCenter = Offset(centerX - w * 0.22, h * py);
      canvas.translate(leftCenter.dx, leftCenter.dy);
      canvas.rotate(-35 * 3.14159 / 180);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: grainW, height: grainH),
        palePaint,
      );
      canvas.restore();

      // Right grain (+35 deg)
      canvas.save();
      final rightCenter = Offset(centerX + w * 0.22, h * py);
      canvas.translate(rightCenter.dx, rightCenter.dy);
      canvas.rotate(35 * 3.14159 / 180);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: grainW, height: grainH),
        palePaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Brand logo: official wheat stalk icon + "Panenara" wordmark.
class PanenaraBrandLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;

  const PanenaraBrandLogo({
    super.key,
    this.iconSize = 24,
    this.fontSize = 19,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PanenaraWheatIcon(size: iconSize),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Pane',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              TextSpan(
                text: 'nara',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE6EFE3),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Circular white back button (matching Figma sub-screens).
class PanenaraBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PanenaraBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Color(0xFF1C3A2B),
          size: 19,
        ),
      ),
    );
  }
}

/// Glassmorphism input field matching Figma 100% (translucent background, subtle border, rounded 16px).
class PanenaraInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  const PanenaraInputField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final prefix = prefixIcon;
    final suffix = suffixIcon;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: Row(
            children: [
              if (prefix != null) ...[
                prefix,
                const SizedBox(width: 12),
              ],
              Expanded(
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  onFieldSubmitted: onSubmitted,
                  validator: validator,
                  cursorColor: Colors.white,
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: GoogleFonts.schibstedGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.65),
                    ),
                  ),
                ),
              ),
              ?suffix,
            ],
          ),
        ),
      ),
    );
  }
}

/// Password input field with show/hide toggle.
class PanenaraPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;

  const PanenaraPasswordField({
    super.key,
    this.controller,
    this.hintText = 'Masukkan kata sandi',
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  @override
  State<PanenaraPasswordField> createState() => _PanenaraPasswordFieldState();
}

class _PanenaraPasswordFieldState extends State<PanenaraPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return PanenaraInputField(
      controller: widget.controller,
      hintText: widget.hintText,
      obscureText: _obscure,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      prefixIcon: Icon(
        Icons.lock_outline_rounded,
        size: 19,
        color: Colors.white.withValues(alpha: 0.8),
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _obscure = !_obscure;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 20,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

/// Primary button matching Figma (dark green #204B33, rounded 16px, subtle border).
class PanenaraPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? trailing;

  const PanenaraPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E462F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.20),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      if (trailing != null) ...[
                        const SizedBox(width: 8),
                        trailing!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Auth layout wrapper: renders the photo background + gradient overlay + content safely.
class PanenaraAuthScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  const PanenaraAuthScaffold({
    super.key,
    required this.child,
    this.backgroundImage = 'assets/images/bg_login.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C3A2B),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Photographic Farm Background (Crisp, High-Resolution, Unique per screen)
          Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFF1C3A2B),
            ),
          ),

          // 2. Soft Dark Vignette & Gradient for High Text Legibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.40),
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // 3. Screen content
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
