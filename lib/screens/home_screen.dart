import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';
import 'widgets/panenara_widgets.dart';
import 'beranda_tab.dart';
import 'lelang_tab.dart';
import 'investasi_tab.dart';
import 'profil_tab.dart';

/// ============================================================================
/// MODUL 4 & 5: STRUKTUR UTAMA DAN NAVIGASI APLIKASI (SCAFFOLD & NAVBAR)
/// ============================================================================
/// [HomeScreen] mengimplementasikan:
/// - [Scaffold] (Bab 4.2.2 Modul): Kerangka dasar halaman yang menyediakan
///   [AppBar], [body], dan navigasi bawah.
/// - [AppBar] (Bab 4.2.3 Modul): Bilah navigasi atas dengan logo Panenara dan notifikasi.
/// - [Stack] & [Positioned] (Bab 4.4.4 Modul): Menampilkan badge indikator notifikasi.
/// - Navigasi Bar Bawah (Bab 5.3.1 Modul) dengan [PageView] terhubung ke tab-tab utama.
/// - [StatefulWidget] (Bab 5.1.2 Modul) untuk mengelola index tab aktif [_currentIndex].
/// ============================================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Index tab yang sedang aktif (0: Beranda, 1: Lelang, 2: Investasi, 3: Profil)
  int _currentIndex = 0;

  // Controller untuk mengontrol perpindahan halaman pada PageView (Bab 5.3.1)
  late final PageController _pageController;

  // Daftar halaman tab utama aplikasi
  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _tabs = [
      BerandaTab(onNavigateTab: _onTabTapped),
      const LelangTab(),
      const InvestasiTab(),
      const ProfilTab(),
    ];
  }

  @override
  void dispose() {
    // Membebaskan PageController dari memori (mencegah memory leak)
    _pageController.dispose();
    super.dispose();
  }

  /// Menangani perubahan tab saat item navigasi ditekan
  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        // Kerangka dasar halaman aplikasi (Bab 4.2.2 Scaffold)
        backgroundColor: const Color(0xFFF3F6F2),
        appBar: AppBar(
          // Bilah navigasi atas (Bab 4.2.3 AppBar)
          backgroundColor: PanenaraTheme.darkGreenBg,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 16,
          title: const PanenaraBrandLogo(
            iconSize: 22,
            fontSize: 20,
          ),
          actions: [
            // Ikon notifikasi dengan badge indikator titik emas (Bab 4.4.4 Stack)
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                  onPressed: () {
                    // Menampilkan SnackBar saat tombol notifikasi ditekan (Bab 5.2.2)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Belum ada notifikasi baru',
                          style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                        ),
                        backgroundColor: PanenaraTheme.darkGreenBg,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: PanenaraTheme.goldAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: PanenaraTheme.darkGreenBg, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
          ],
        ),

        // Konten utama berupa PageView (Swipe horizontal antar tab)
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _tabs,
        ),

        // Menu Navigasi Bawah (Bab 5.3.1 BottomNavigationBar)
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(0, Icons.home_rounded, Icons.home_outlined, 'Beranda'),
                  _navItem(1, Icons.storefront_rounded, Icons.storefront_outlined, 'Lelang'),
                  _navItem(2, Icons.bar_chart_rounded, Icons.bar_chart_outlined, 'Investasi'),
                  _navItem(3, Icons.person_rounded, Icons.person_outline_rounded, 'Profil'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Helper untuk membangun satu item tab pada navigasi bawah (Bab 4.4.2 & 4.4.3)
  Widget _navItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? PanenaraTheme.primaryGreen.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedScale(
          scale: isActive ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : inactiveIcon,
                color: isActive ? PanenaraTheme.primaryGreen : Colors.grey.shade500,
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 10.5,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? PanenaraTheme.primaryGreen : Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
