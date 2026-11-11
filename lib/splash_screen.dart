import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Splash screen that faithfully replicates the Figma design & animation
/// for "Aplikasi Panenara" (Node 11:122 -> 11:227).
///
/// Animation breakdown:
/// 1. Stem shoots up from bottom to full height (Curves.easeOutCubic).
/// 2. Grains bloom in sequential pairs from bottom to top (Curves.easeOutBack).
/// 3. Top golden grain emerges at apex.
/// 4. Wordmark "Panenara" fades in and slides into place.
/// 5. Tagline "Hasil panen, harga yang adil." fades in smoothly.
class PanenaraSplashScreen extends StatefulWidget {
  final VoidCallback? onAnimationComplete;
  final Duration animationDuration;

  const PanenaraSplashScreen({
    super.key,
    this.onAnimationComplete,
    this.animationDuration = const Duration(milliseconds: 2400),
  });

  @override
  State<PanenaraSplashScreen> createState() => _PanenaraSplashScreenState();
}

class _PanenaraSplashScreenState extends State<PanenaraSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Staggered Animation Intervals
  late final Animation<double> _stemGrowth;
  late final Animation<double> _grainPair1;
  late final Animation<double> _grainPair2;
  late final Animation<double> _grainPair3;
  late final Animation<double> _grainTop;
  late final Animation<double> _wordmarkOpacity;
  late final Animation<Offset> _wordmarkSlide;
  late final Animation<double> _taglineOpacity;
  late final Animation<Offset> _taglineSlide;

  // Design Token Colors
  static const Color kBackgroundColor = Color(0xFF1F3D2B);
  static const Color kGrainPaleColor = Color(0xFFE6EFE3);
  static const Color kGrainGoldColor = Color(0xFFE8A33D);
  static const Color kTextWhiteColor = Color(0xFFFFFFFF);
  static const Color kTextPaleColor = Color(0xFFE6EFE3);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // 1. Stem sprouts up: 0% -> 28%
    _stemGrowth = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.00, 0.28, curve: Curves.easeOutCubic),
    );

    // 2. Grain Pair 1 (Bottom left & right): 22% -> 44%
    _grainPair1 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.22, 0.44, curve: Curves.easeOutBack),
    );

    // 3. Grain Pair 2 (Middle left & right): 36% -> 58%
    _grainPair2 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.36, 0.58, curve: Curves.easeOutBack),
    );

    // 4. Grain Pair 3 (Top left & right): 50% -> 72%
    _grainPair3 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.50, 0.72, curve: Curves.easeOutBack),
    );

    // 5. Golden Top Grain: 62% -> 82%
    _grainTop = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.62, 0.82, curve: Curves.easeOutBack),
    );

    // 6. Wordmark "Panenara": 70% -> 90%
    _wordmarkOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.70, 0.90, curve: Curves.easeOut),
    );
    _wordmarkSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    // 7. Tagline: 80% -> 100%
    _taglineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.80, 1.00, curve: Curves.easeOut),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 1.00, curve: Curves.easeOutCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replay() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Reference Figma frame size: 380 x 820
    const double designWidth = 380.0;
    const double designHeight = 820.0;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onTap: _replay, // Tap to replay animation
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: designWidth,
                height: designHeight,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // 1. Center Stem
                        _buildStem(),

                        // 2. Bottom Grain Pair (Pair 1)
                        // Left grain (1L) — symmetrical around stem center X=190
                        _buildGrain(
                          left: 145.78,
                          top: 383.68,
                          angleDeg: -35,
                          animation: _grainPair1,
                        ),
                        // Right grain (1R) — symmetrical around stem center X=190
                        _buildGrain(
                          left: 187.78,
                          top: 383.68,
                          angleDeg: 35,
                          animation: _grainPair1,
                        ),

                        // 3. Middle Grain Pair (Pair 2)
                        // Left grain (2L) — symmetrical around stem center X=190
                        _buildGrain(
                          left: 145.78,
                          top: 346.93,
                          angleDeg: -35,
                          animation: _grainPair2,
                        ),
                        // Right grain (2R) — symmetrical around stem center X=190
                        _buildGrain(
                          left: 187.78,
                          top: 346.93,
                          angleDeg: 35,
                          animation: _grainPair2,
                        ),

                        // 4. Top Grain Pair (Pair 3)
                        // Left grain (3L) — symmetrical around stem center X=190
                        _buildGrain(
                          left: 145.78,
                          top: 310.18,
                          angleDeg: -35,
                          animation: _grainPair3,
                        ),
                        // Right grain (3R) — symmetrical around stem center X=190
                        _buildGrain(
                          left: 187.78,
                          top: 310.18,
                          angleDeg: 35,
                          animation: _grainPair3,
                        ),

                        // 5. Top Golden Grain (Apex)
                        _buildTopGrain(),

                        // 6. Wordmark "Panenara"
                        _buildWordmark(),

                        // 7. Tagline "Hasil panen, harga yang adil."
                        _buildTagline(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the center stem that grows upwards from bottom (Y = 436.28 -> 298.47).
  Widget _buildStem() {
    const double stemWidth = 6.56;
    const double fullHeight = 137.81;
    const double stemBottomY = 436.28;
    const double stemCenterX = 190.0;

    final currentHeight = fullHeight * _stemGrowth.value;
    final currentTopY = stemBottomY - currentHeight;

    if (currentHeight <= 0) return const SizedBox.shrink();

    return Positioned(
      left: stemCenterX - (stemWidth / 2),
      top: currentTopY,
      width: stemWidth,
      height: currentHeight,
      child: Container(
        decoration: BoxDecoration(
          color: kGrainPaleColor,
          borderRadius: BorderRadius.circular(stemWidth / 2),
        ),
      ),
    );
  }

  /// Builds a side grain (ellipse 23.62 x 47.24) positioned using Figma
  /// bounding-box coordinates. The grain is placed inside its rotated bbox
  /// (46.44 x 52.24) and rotated around its center.
  Widget _buildGrain({
    required double left,
    required double top,
    required double angleDeg,
    required Animation<double> animation,
  }) {
    final scale = animation.value.clamp(0.0, 1.3);
    if (scale <= 0.001) return const SizedBox.shrink();

    // Intrinsic grain size (unrotated ellipse)
    const double grainWidth = 23.62;
    const double grainHeight = 47.24;
    // Rotated bounding box size (±35° rotation of the ellipse)
    const double bboxWidth = 46.44;
    const double bboxHeight = 52.24;

    return Positioned(
      left: left,
      top: top,
      width: bboxWidth,
      height: bboxHeight,
      child: Center(
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: angleDeg * (math.pi / 180.0),
            alignment: Alignment.center,
            child: Opacity(
              opacity: (animation.value).clamp(0.0, 1.0),
              child: Container(
                width: grainWidth,
                height: grainHeight,
                decoration: const BoxDecoration(
                  color: kGrainPaleColor,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(grainWidth / 2, grainHeight / 2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the single golden grain at the top apex.
  Widget _buildTopGrain() {
    final scale = _grainTop.value.clamp(0.0, 1.3);
    if (scale <= 0.001) return const SizedBox.shrink();

    const double grainWidth = 23.62;
    const double grainHeight = 47.24;
    // Figma coordinates: x = 178.19 (center 190.0), y = 262.38
    const double topGrainX = 190.0 - (grainWidth / 2);
    const double topGrainY = 262.38;

    return Positioned(
      left: topGrainX,
      top: topGrainY,
      width: grainWidth,
      height: grainHeight,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: _grainTop.value.clamp(0.0, 1.0),
          child: Container(
            decoration: const BoxDecoration(
              color: kGrainGoldColor,
              borderRadius: BorderRadius.all(
                Radius.elliptical(grainWidth / 2, grainHeight / 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the "Pane" (white) + "nara" (#E6EFE3) brand wordmark.
  Widget _buildWordmark() {
    const double wordmarkY = 463.5;

    return Positioned(
      left: 0,
      right: 0,
      top: wordmarkY,
      child: SlideTransition(
        position: _wordmarkSlide,
        child: FadeTransition(
          opacity: _wordmarkOpacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Pane',
                style: _getWordmarkStyle(kTextWhiteColor),
              ),
              Text(
                'nara',
                style: _getWordmarkStyle(kTextPaleColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _getWordmarkStyle(Color color) {
    return GoogleFonts.bricolageGrotesque(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.0,
      height: 1.1,
      color: color,
    );
  }

  /// Builds the subtitle / tagline "Hasil panen, harga yang adil."
  Widget _buildTagline() {
    const double taglineY = 546.5;

    return Positioned(
      left: 0,
      right: 0,
      top: taglineY,
      child: SlideTransition(
        position: _taglineSlide,
        child: FadeTransition(
          opacity: _taglineOpacity,
          child: Text(
            'Hasil panen, harga yang adil.',
            textAlign: TextAlign.center,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
              color: kTextPaleColor.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}
