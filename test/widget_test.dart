import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/splash_screen.dart';

void main() {
  testWidgets('Panenara splash to login flow smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PanenaraApp());
    expect(find.byType(PanenaraSplashScreen), findsOneWidget);

    // Advance splash screen through its timeline
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify it transitioned to LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Masuk'), findsWidgets);
    expect(find.text('Email atau Nomor WhatsApp'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
    expect(find.text('Ingat saya'), findsOneWidget);
    expect(find.text('Lupa Kata Sandi?'), findsOneWidget);
    expect(find.text('Daftar'), findsOneWidget);
  });
}
