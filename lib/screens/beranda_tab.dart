import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';
import '../helpers/dummy_data_helper.dart';
import '../helpers/user_session.dart';
import 'daftar_petani_screen.dart';
import 'daftar_pembeli_screen.dart';

class BerandaTab extends StatelessWidget {
  final Function(int)? onNavigateTab;

  const BerandaTab({super.key, this.onNavigateTab});

  void _showDetailLelang(
    BuildContext context, {
    required String title,
    required String weight,
    required String currentBid,
    required String startPrice,
    required String timeLeft,
    required String location,
    required String seller,
    String? imagePath,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (imagePath != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PanenaraTheme.textDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 13, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        timeLeft,
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 12),
                Icon(Icons.person_outline_rounded, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  seller,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8F5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _modalCol('Jumlah Stok', weight),
                  Container(width: 1, height: 30, color: Colors.grey.shade300),
                  _modalCol('Harga Mulai', startPrice),
                  Container(width: 1, height: 30, color: Colors.grey.shade300),
                  _modalCol('Tawaran Teratas', currentBid, isHighlight: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      onNavigateTab?.call(1); // Pindah ke tab Lelang
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: PanenaraTheme.primaryGreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Buka Pasar Lelang',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: PanenaraTheme.primaryGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _handleBidAttempt(context, title, currentBid);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: PanenaraTheme.primaryGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Tawar Sekarang',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Memeriksa peran sebelum mengajukan penawaran lelang (RBAC)
  /// Petani: TIDAK BISA membeli/menawar barang lelang.
  /// Pembeli: BISA menawar barang lelang.
  void _handleBidAttempt(BuildContext context, String title, String currentBid) {
    if (UserSession.isPetani) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          icon: const Icon(Icons.block_rounded, color: Colors.orange, size: 44),
          title: Text(
            'Khusus Akun Pembeli',
            textAlign: TextAlign.center,
            style: GoogleFonts.bricolageGrotesque(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: PanenaraTheme.textDark,
            ),
          ),
          content: Text(
            'Akun Anda terdaftar sebagai Petani. Petani hanya dapat melelang hasil panen sendiri dan tidak dapat membeli/menawar barang lelang.\n\nSilakan gunakan akun Pembeli untuk membeli komoditas lelang.',
            textAlign: TextAlign.center,
            style: GoogleFonts.schibstedGrotesk(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PanenaraTheme.primaryGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Mengerti', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      );
      return;
    }

    _showBidDialog(context, title, currentBid);
  }

  void _showBidDialog(BuildContext context, String title, String currentBid) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Ajukan Penawaran',
          style: GoogleFonts.bricolageGrotesque(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.schibstedGrotesk(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Tawaran saat ini: $currentBid',
              style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: 'Rp ',
                hintText: 'Masukkan nominal tawaran Anda',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PanenaraTheme.primaryGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Tawaran Anda berhasil diajukan!',
                    style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                  ),
                  backgroundColor: PanenaraTheme.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Kirim Tawaran', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _modalCol(String label, String value, {bool isHighlight = false}) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.schibstedGrotesk(fontSize: 10.5, color: Colors.grey.shade600)),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isHighlight ? PanenaraTheme.primaryGreen : PanenaraTheme.textDark,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Dark Green Hero ──────────────────────────
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: PanenaraTheme.darkGreenBg,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang di Panenara! 👋',
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hasil panen berkualitas dengan harga yang adil.',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 12.5,
                        color: PanenaraTheme.textSubtle,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 2 Pilihan Tombol: Daftar Petani & Pembeli
                    Row(
                      children: [
                        // Button 1: Daftar sebagai Petani
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const DaftarPetaniScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: PanenaraTheme.primaryGreen.withValues(alpha: 0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.agriculture_rounded,
                                          color: PanenaraTheme.primaryGreen,
                                          size: 26,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Daftar sebagai\nPetani',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.bricolageGrotesque(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: PanenaraTheme.textDark,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Jual hasil panen',
                                        style: GoogleFonts.schibstedGrotesk(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Button 2: Daftar sebagai Pembeli
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const DaftarPembeliScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: PanenaraTheme.goldAccent.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.shopping_bag_rounded,
                                          color: PanenaraTheme.goldAccent,
                                          size: 26,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Daftar sebagai\nPembeli',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.bricolageGrotesque(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: PanenaraTheme.textDark,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Ikuti lelang komoditas',
                                        style: GoogleFonts.schibstedGrotesk(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Lelang Berlangsung ───────────────────────────
              _sectionHeader(
                'Lelang Berlangsung',
                'Lihat Semua',
                onAction: () => onNavigateTab?.call(1),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 225,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: DummyDataHelper.getLelangBerlangsungList()
                      .map((item) => _auctionCard(
                            context,
                            item.title,
                            item.weight,
                            item.currentBid,
                            item.startPrice,
                            item.timeLeft,
                            item.themeColor,
                            item.location,
                            item.seller,
                            imagePath: item.imagePath,
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 20),

              // ── Proyek Panen Tayang ─────────────────────────
              _sectionHeader(
                'Proyek Panen Tayang',
                'Lihat Semua',
                onAction: () => onNavigateTab?.call(2),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: DummyDataHelper.getProyekPanenList()
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _projectCard(
                              context,
                              item.title,
                              item.location,
                              item.targetDana,
                              item.progress,
                              item.progressPercentage,
                              item.roiRange,
                            ),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 20),

              // ── Berita & Tips Tani ──────────────────────────
              _sectionHeader('Berita & Tips Tani', 'Info Tani'),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _newsCard(
                      context,
                      '🌾 Harga Gabah Naik 12% Memasuki Musim Panen',
                      '2 jam lalu',
                      'Kementan mencatat kenaikan harga gabah kering pungut (GKP) di tingkat petani seiring meningkatnya permintaan beras premium di pasar lelang.',
                    ),
                    const SizedBox(height: 10),
                    _newsCard(
                      context,
                      '💧 Teknik Irigasi Tetes untuk Cabai agar Hasil Optimal',
                      '5 jam lalu',
                      'Irigasi tetes terbukti meningkatkan efisiensi air hingga 40% dan produktivitas panen cabai rawit merah secara signifikan di musim kemarau.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String action, {VoidCallback? onAction}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: PanenaraTheme.textDark,
            ),
          ),
          InkWell(
            onTap: onAction,
            child: Text(
              action,
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: PanenaraTheme.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _auctionCard(
    BuildContext context,
    String title,
    String weight,
    String currentBid,
    String startPrice,
    String timeLeft,
    Color timerColor,
    String location,
    String seller, {
    String? imagePath,
  }) {
    return Container(
      width: 195,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showDetailLelang(
            context,
            title: title,
            weight: weight,
            currentBid: currentBid,
            startPrice: startPrice,
            timeLeft: timeLeft,
            location: location,
            seller: seller,
            imagePath: imagePath,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Commodity Image with Timer Badge Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: imagePath != null
                        ? Image.asset(
                            imagePath,
                            height: 105,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 105,
                            color: PanenaraTheme.badgeGreenBg,
                            child: const Center(
                              child: Icon(Icons.grass_rounded, color: PanenaraTheme.primaryGreen, size: 36),
                            ),
                          ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer_outlined, size: 10.5, color: timerColor),
                          const SizedBox(width: 3.5),
                          Text(
                            timeLeft,
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: timerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: PanenaraTheme.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      weight,
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Penawaran tertinggi',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 9.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 1),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        currentBid,
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectCard(
    BuildContext context,
    String title,
    String location,
    String target,
    double progress,
    String percent,
    String roi,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onNavigateTab?.call(2), // Pindah ke tab Investasi
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.textDark,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: PanenaraTheme.badgeGreenBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'ROI $roi',
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 13, color: Colors.grey.shade500),
                    const SizedBox(width: 3),
                    Text(
                      location,
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(PanenaraTheme.primaryGreen),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terkumpul: $percent',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: PanenaraTheme.textDark,
                      ),
                    ),
                    Text(
                      'Target: $target',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _newsCard(BuildContext context, String title, String time, String excerpt) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Text(
                  title,
                  style: GoogleFonts.bricolageGrotesque(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  excerpt,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 13, height: 1.5),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  excerpt,
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
