import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';
import '../helpers/user_session.dart';

/// ============================================================================
/// MODUL 5: PASAR LELANG KOMODITAS & ROLE-BASED ACCESS CONTROL (RBAC)
/// ============================================================================
/// Mengatur hak akses peran sesuai instruksi:
/// - Petani: BISA melakukan fitur melelang hasil tani, TIDAK BISA membeli barang lelang.
/// - Pembeli: BISA mengikuti pelelangan (menawar/membeli), TIDAK BISA melelang barang.
/// Menggunakan:
/// - [TabBar] & [TabBarView] (Bab 5.2.5 Modul)
/// - [FloatingActionButton] (Bab 4.2.2 Scaffold)
/// - [AlertDialog] (Bab 5.2.1 Dialog)
/// - [BottomSheet] (Bab 5.3.2 BottomSheet)
/// - [SnackBar] (Bab 5.2.2 SnackBar)
/// ============================================================================
class LelangTab extends StatefulWidget {
  const LelangTab({super.key});

  @override
  State<LelangTab> createState() => _LelangTabState();
}

class _LelangTabState extends State<LelangTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// ── FITUR MELELANG HASIL TANI (Hanya untuk PETANI) ───────────
  void _handleCreateAuctionAttempt() {
    // Pengecekan Peran: Pembeli dilarang melelang barang
    if (UserSession.isPembeli) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          icon: const Icon(Icons.block_rounded, color: Colors.orange, size: 44),
          title: Text(
            'Khusus Akun Petani',
            textAlign: TextAlign.center,
            style: GoogleFonts.bricolageGrotesque(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: PanenaraTheme.textDark,
            ),
          ),
          content: Text(
            'Akun Anda terdaftar sebagai Pembeli. Pembeli hanya dapat mengikuti pelelangan barang dan tidak dapat melelang hasil tani.\n\nSilakan daftar sebagai Petani untuk memasang komoditas lelang Anda.',
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

    // Jika Petani (atau belum daftar / tamu): Buka formulir melelang hasil tani
    _showCreateAuctionModal();
  }

  /// Modal formulir tambah komoditas lelang (Bab 5.3.2 BottomSheet)
  void _showCreateAuctionModal() {
    final titleCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final locationCtrl = TextEditingController(text: 'Cianjur, Jawa Barat');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
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
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PanenaraTheme.primaryGreen.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add_business_rounded, color: PanenaraTheme.primaryGreen, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Lelang Hasil Tani Anda',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PanenaraTheme.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Pasang komoditas hasil panen Anda agar dapat ditawar oleh pembeli.',
                style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              // 1. Nama Komoditas
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: 'Nama Komoditas (misal: Bawang Merah Brebes)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),

              // 2. Jumlah / Berat
              TextField(
                controller: qtyCtrl,
                decoration: InputDecoration(
                  labelText: 'Jumlah / Stok (misal: 350 Kg)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),

              // 3. Harga Awal
              TextField(
                controller: priceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga Awal Lelang (Rp)',
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),

              // 4. Lokasi Kebun
              TextField(
                controller: locationCtrl,
                decoration: InputDecoration(
                  labelText: 'Lokasi Kebun / Lahan',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 18),

              // Tombol Pasang
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final title = titleCtrl.text.trim();
                    final qty = qtyCtrl.text.trim();
                    final price = priceCtrl.text.trim();
                    final loc = locationCtrl.text.trim();

                    if (title.isEmpty || qty.isEmpty || price.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Harap lengkapi semua kolom lelang!',
                            style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                          ),
                          backgroundColor: Colors.red.shade700,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    // Tambahkan ke daftar lelang aktif
                    setState(() {
                      _activeLelang.insert(0, {
                        'title': title,
                        'location': loc.isEmpty ? 'Jawa Barat' : loc,
                        'icon': Icons.grass_rounded,
                        'status': 'Berlangsung',
                        'statusColor': Colors.green,
                        'qty': qty,
                        'startPrice': 'Rp $price',
                        'bid': 'Rp $price',
                        'time': '04:00:00',
                        'buttonText': 'Ajukan Penawaran',
                        'buttonColor': PanenaraTheme.primaryGreen,
                      });
                    });

                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Hasil tani "$title" berhasil dilelang di pasar Panenara!',
                          style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                        ),
                        backgroundColor: PanenaraTheme.primaryGreen,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                  label: Text(
                    'Pasang Lelang Sekarang',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PanenaraTheme.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ── FITUR MENAWAR / MEMBELI LELANG (Hanya untuk PEMBELI) ─────
  void _handleBidAttempt(Map<String, dynamic> data) {
    // Pengecekan Peran: Petani dilarang membeli barang lelang
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
            'Akun Anda terdaftar sebagai Petani. Petani hanya dapat melelang hasil panen sendiri dan tidak dapat membeli/menawar barang lelang.\n\nGunakan akun Pembeli untuk membeli barang lelang.',
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

    // Jika Pembeli (atau tamu): Buka dialog penawaran
    final bidCtrl = TextEditingController();
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
              data['title'] as String,
              style: GoogleFonts.schibstedGrotesk(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Tawaran saat ini: ${data['bid']}',
              style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: bidCtrl,
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
              final newBid = bidCtrl.text.trim();
              if (newBid.isEmpty) return;

              setState(() {
                data['bid'] = 'Rp $newBid';
              });

              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Tawaran Anda sebesar Rp $newBid berhasil diajukan!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
      // Floating Action Button untuk Petani memasang lelang baru
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: PanenaraTheme.primaryGreen,
        elevation: 3,
        icon: const Icon(Icons.add_business_rounded, color: Colors.white),
        label: Text(
          'Lelang Hasil Tani',
          style: GoogleFonts.schibstedGrotesk(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: _handleCreateAuctionAttempt,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: PanenaraTheme.darkGreenBg,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pasar Lelang',
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Indikator peran aktif di header
                      ValueListenableBuilder<UserRole>(
                        valueListenable: UserSession.currentRole,
                        builder: (context, role, _) {
                          if (role == UserRole.guest) return const SizedBox.shrink();
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: PanenaraTheme.goldAccent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: PanenaraTheme.goldAccent.withValues(alpha: 0.4)),
                            ),
                            child: Text(
                              role == UserRole.petani ? 'Peran: Petani' : 'Peran: Pembeli',
                              style: GoogleFonts.schibstedGrotesk(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: PanenaraTheme.goldAccent,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tawar harga terbaik untuk komoditas petani.',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 12.5,
                      color: PanenaraTheme.textSubtle,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Search Bar
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.7), size: 18),
                        const SizedBox(width: 10),
                        Text(
                          'Cari komoditas...',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Tab bar (Bab 5.2.5 Modul)
                  TabBar(
                    controller: _tabController,
                    indicatorColor: PanenaraTheme.goldAccent,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
                    labelStyle: GoogleFonts.schibstedGrotesk(fontSize: 12.5, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: GoogleFonts.schibstedGrotesk(fontSize: 12.5),
                    tabs: const [
                      Tab(text: 'Berlangsung'),
                      Tab(text: 'Akan Datang'),
                      Tab(text: 'Selesai'),
                    ],
                  ),
                ],
              ),
            ),

            // Tab content (Bab 5.2.5 Modul TabBarView)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAuctionList(_activeLelang),
                  _buildAuctionList(_upcomingLelang),
                  _buildAuctionList(_doneLelang),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuctionList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // Padding bawah agar tidak tertutup FAB
      itemCount: items.length,
      itemBuilder: (ctx, i) => _lelangCard(items[i]),
    );
  }

  Widget _lelangCard(Map<String, dynamic> data) {
    final Color statusColor = data['statusColor'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: data['image'] != null
                    ? Image.asset(
                        data['image'] as String,
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: PanenaraTheme.badgeGreenBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(data['icon'] as IconData, color: PanenaraTheme.primaryGreen, size: 28),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'] as String,
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PanenaraTheme.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 12, color: Colors.grey.shade500),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            data['location'] as String,
                            style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  data['status'] as String,
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: _infoColumn('Jumlah', data['qty'] as String),
              ),
              Expanded(
                flex: 6,
                child: _infoColumn('Harga Awal', data['startPrice'] as String),
              ),
              Expanded(
                flex: 6,
                child: _infoColumn('Penawaran', data['bid'] as String, highlight: true),
              ),
              Expanded(
                flex: 4,
                child: _infoColumn('Waktu', data['time'] as String),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                if (data['buttonText'] == 'Ajukan Penawaran') {
                  _handleBidAttempt(data);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Fitur pengingat lelang telah diaktifkan!',
                        style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                      ),
                      backgroundColor: PanenaraTheme.primaryGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: data['buttonColor'] as Color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Text(
                data['buttonText'] as String,
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value, {bool highlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.schibstedGrotesk(fontSize: 10, color: Colors.grey.shade500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: highlight ? PanenaraTheme.primaryGreen : PanenaraTheme.textDark,
            ),
          ),
        ),
      ],
    );
  }

  final List<Map<String, dynamic>> _activeLelang = [
    {
      'title': 'Beras Premium Cianjur',
      'location': 'Cianjur, Jawa Barat',
      'image': 'assets/images/commodity_beras.jpg',
      'icon': Icons.grass_rounded,
      'status': 'Berlangsung',
      'statusColor': Colors.green,
      'qty': '250 Kg',
      'startPrice': 'Rp 2.950.000',
      'bid': 'Rp 3.200.000',
      'time': '01:24:38',
      'buttonText': 'Ajukan Penawaran',
      'buttonColor': PanenaraTheme.primaryGreen,
    },
    {
      'title': 'Cabai Merah Keriting Segar',
      'location': 'Temanggung, Jawa Tengah',
      'image': 'assets/images/commodity_cabai.jpg',
      'icon': Icons.spa_rounded,
      'status': 'Berlangsung',
      'statusColor': Colors.green,
      'qty': '100 Kg',
      'startPrice': 'Rp 720.000',
      'bid': 'Rp 850.000',
      'time': '00:48:12',
      'buttonText': 'Ajukan Penawaran',
      'buttonColor': PanenaraTheme.primaryGreen,
    },
    {
      'title': 'Jagung Pipil Kering Grade A',
      'location': 'Grobogan, Jawa Tengah',
      'image': 'assets/images/commodity_jagung.jpg',
      'icon': Icons.yard_rounded,
      'status': 'Berlangsung',
      'statusColor': Colors.green,
      'qty': '500 Kg',
      'startPrice': 'Rp 1.600.000',
      'bid': 'Rp 1.750.000',
      'time': '03:10:00',
      'buttonText': 'Ajukan Penawaran',
      'buttonColor': PanenaraTheme.primaryGreen,
    },
    {
      'title': 'Tomat Beef Segar',
      'location': 'Batu, Jawa Timur',
      'icon': Icons.local_florist_rounded,
      'status': 'Berlangsung',
      'statusColor': Colors.green,
      'qty': '200 Kg',
      'startPrice': 'Rp 600.000',
      'bid': 'Rp 720.000',
      'time': '02:05:30',
      'buttonText': 'Ajukan Penawaran',
      'buttonColor': PanenaraTheme.primaryGreen,
    },
  ];

  final List<Map<String, dynamic>> _upcomingLelang = [
    {
      'title': 'Kopi Arabika Gayo Aceh',
      'location': 'Aceh Tengah, Aceh',
      'icon': Icons.local_cafe_rounded,
      'status': 'Besok 09:00',
      'statusColor': Colors.orange,
      'qty': '50 Kg',
      'startPrice': 'Rp 4.500.000',
      'bid': '-',
      'time': 'Besok',
      'buttonText': 'Ingatkan Saya',
      'buttonColor': Colors.orange,
    },
    {
      'title': 'Durian Monthong Premium',
      'location': 'Medan, Sumatera Utara',
      'icon': Icons.local_florist_rounded,
      'status': 'Lusa 10:00',
      'statusColor': Colors.orange,
      'qty': '30 Buah',
      'startPrice': 'Rp 2.100.000',
      'bid': '-',
      'time': 'Lusa',
      'buttonText': 'Ingatkan Saya',
      'buttonColor': Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> _doneLelang = [
    {
      'title': 'Singkong Segar Lampung',
      'location': 'Lampung Tengah, Lampung',
      'icon': Icons.yard_rounded,
      'status': 'Selesai',
      'statusColor': Colors.grey,
      'qty': '1.000 Kg',
      'startPrice': 'Rp 1.800.000',
      'bid': 'Rp 2.350.000',
      'time': 'Kemarin',
      'buttonText': 'Lihat Detail',
      'buttonColor': Colors.grey,
    },
    {
      'title': 'Pisang Cavendish Export',
      'location': 'Lumajang, Jawa Timur',
      'icon': Icons.local_florist_rounded,
      'status': 'Selesai',
      'statusColor': Colors.grey,
      'qty': '300 Kg',
      'startPrice': 'Rp 1.200.000',
      'bid': 'Rp 1.650.000',
      'time': '3 hari lalu',
      'buttonText': 'Lihat Detail',
      'buttonColor': Colors.grey,
    },
  ];
}
