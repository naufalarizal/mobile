import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/panenara_theme.dart';

class RiwayatTransaksiScreen extends StatefulWidget {
  const RiwayatTransaksiScreen({super.key});

  @override
  State<RiwayatTransaksiScreen> createState() => _RiwayatTransaksiScreenState();
}

class _RiwayatTransaksiScreenState extends State<RiwayatTransaksiScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Lelang: Beras Premium Cianjur (250 Kg)',
      'buyer': 'CV Berkah Pangan Nusantara',
      'date': '08 Nov 2026, 14:20',
      'amount': '+ Rp 3.200.000',
      'isIncome': true,
      'category': 'Lelang',
      'status': 'Selesai',
      'invoice': 'INV/20261108/PNR/0892',
      'icon': Icons.gavel_rounded,
    },
    {
      'title': 'Bagi Hasil: Padi Organik Ciherang',
      'buyer': 'Pendanaan Panen Periode III',
      'date': '01 Nov 2026, 10:15',
      'amount': '+ Rp 1.850.000',
      'isIncome': true,
      'category': 'Investasi',
      'status': 'Selesai',
      'invoice': 'INV/20261101/INV/0411',
      'icon': Icons.trending_up_rounded,
    },
    {
      'title': 'Penarikan Dana ke Bank BRI',
      'buyer': 'Rek. 0123-****-5678 (Budi Santoso)',
      'date': '28 Okt 2026, 09:30',
      'amount': '- Rp 2.500.000',
      'isIncome': false,
      'category': 'Penarikan',
      'status': 'Berhasil',
      'invoice': 'WD/20261028/BRI/9012',
      'icon': Icons.account_balance_wallet_rounded,
    },
    {
      'title': 'Lelang: Jagung Pipil Kering (500 Kg)',
      'buyer': 'PT Pangan Mandiri Sejahtera',
      'date': '15 Okt 2026, 16:45',
      'amount': '+ Rp 1.750.000',
      'isIncome': true,
      'category': 'Lelang',
      'status': 'Selesai',
      'invoice': 'INV/20261015/PNR/0312',
      'icon': Icons.gavel_rounded,
    },
    {
      'title': 'Penarikan Dana ke Bank Mandiri',
      'buyer': 'Rek. 1320-****-4321 (Budi Santoso)',
      'date': '05 Okt 2026, 11:10',
      'amount': '- Rp 1.200.000',
      'isIncome': false,
      'category': 'Penarikan',
      'status': 'Berhasil',
      'invoice': 'WD/20261005/MDR/7741',
      'icon': Icons.account_balance_wallet_rounded,
    },
    {
      'title': 'Lelang: Cabai Merah Keriting (100 Kg)',
      'buyer': 'Restoran Sari Minang Cianjur',
      'date': '25 Sep 2026, 13:00',
      'amount': '+ Rp 850.000',
      'isIncome': true,
      'category': 'Lelang',
      'status': 'Selesai',
      'invoice': 'INV/20260925/PNR/0199',
      'icon': Icons.gavel_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showDetailInvoice(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
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
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rincian Transaksi',
                  style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['status'] as String,
                    style: GoogleFonts.schibstedGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8F5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _invoiceRow('Nomor Transaksi', item['invoice'] as String),
                  const Divider(height: 16),
                  _invoiceRow('Deskripsi', item['title'] as String),
                  const Divider(height: 16),
                  _invoiceRow('Pihak Terkait', item['buyer'] as String),
                  const Divider(height: 16),
                  _invoiceRow('Waktu Transaksi', item['date'] as String),
                  const Divider(height: 16),
                  _invoiceRow('Metode', item['category'] == 'Penarikan' ? 'Transfer Bank' : 'Panenara Escrow'),
                  const Divider(height: 16),
                  _invoiceRow('Total Nominal', item['amount'] as String, isHighlight: true, isIncome: item['isIncome'] as bool),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
                label: Text(
                  'Tutup Rincian',
                  style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PanenaraTheme.primaryGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _invoiceRow(String label, String value, {bool isHighlight = false, bool isIncome = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade600)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: isHighlight
                ? GoogleFonts.bricolageGrotesque(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isIncome ? PanenaraTheme.primaryGreen : Colors.red.shade700,
                  )
                : GoogleFonts.schibstedGrotesk(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: PanenaraTheme.textDark,
                  ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
      appBar: AppBar(
        backgroundColor: PanenaraTheme.darkGreenBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Riwayat Transaksi',
          style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: PanenaraTheme.goldAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: GoogleFonts.schibstedGrotesk(fontSize: 12.5, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Lelang'),
            Tab(text: 'Investasi'),
            Tab(text: 'Penarikan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(null),
          _buildList('Lelang'),
          _buildList('Investasi'),
          _buildList('Penarikan'),
        ],
      ),
    );
  }

  Widget _buildList(String? filterCategory) {
    final list = filterCategory == null
        ? _transactions
        : _transactions.where((t) => t['category'] == filterCategory).toList();

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            Text(
              'Belum ada transaksi di kategori ini',
              style: GoogleFonts.schibstedGrotesk(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        final item = list[i];
        final bool isIncome = item['isIncome'] as bool;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _showDetailInvoice(item),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isIncome
                            ? PanenaraTheme.primaryGreen.withValues(alpha: 0.12)
                            : Colors.red.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: isIncome ? PanenaraTheme.primaryGreen : Colors.red,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PanenaraTheme.textDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['buyer'] as String,
                            style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF3B4D3F)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['date'] as String,
                            style: GoogleFonts.schibstedGrotesk(fontSize: 10.5, fontWeight: FontWeight.w500, color: const Color(0xFF5A6D5F)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item['amount'] as String,
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: isIncome ? PanenaraTheme.primaryGreen : Colors.red.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['status'] as String,
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
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
      },
    );
  }
}
