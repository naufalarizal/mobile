import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
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
                  Text(
                    'Pasar Lelang',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                  // Tab bar
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

            // Tab content
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
      padding: const EdgeInsets.all(16),
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
              onPressed: () {},
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
