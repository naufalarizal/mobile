import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF1F3D2B),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const PanenaraApp());
}

class PanenaraApp extends StatelessWidget {
  const PanenaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panenara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF3F6F2),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF258149),
          brightness: Brightness.light,
        ),
      ),
      home: const _SplashFlowHandler(),
    );
  }
}

class _SplashFlowHandler extends StatefulWidget {
  const _SplashFlowHandler();

  @override
  State<_SplashFlowHandler> createState() => _SplashFlowHandlerState();
}

class _SplashFlowHandlerState extends State<_SplashFlowHandler> {
  bool _hasNavigated = false;

  void _navigateToLogin() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PanenaraSplashScreen(
      onAnimationComplete: () {
        // Brief 400ms pause after animation finishes, then transition to Login
        Future.delayed(const Duration(milliseconds: 400), _navigateToLogin);
      },
    );
  }
}
