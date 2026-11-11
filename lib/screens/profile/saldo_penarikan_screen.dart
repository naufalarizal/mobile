import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/panenara_theme.dart';

class SaldoPenarikanScreen extends StatefulWidget {
  const SaldoPenarikanScreen({super.key});

  @override
  State<SaldoPenarikanScreen> createState() => _SaldoPenarikanScreenState();
}

class _SaldoPenarikanScreenState extends State<SaldoPenarikanScreen> {
  int _availableBalance = 4750000;
  final int _pendingBalance = 850000;
  final TextEditingController _amountController = TextEditingController();
  String _selectedAccount = 'Bank BRI - 0123-****-53-8 (Budi Santoso)';

  final List<Map<String, dynamic>> _withdrawHistory = [
    {
      'id': 'WD-08912',
      'amount': 'Rp 2.500.000',
      'bank': 'Bank BRI (0123-****-53-8)',
      'date': '28 Okt 2026, 09:30',
      'status': 'Berhasil',
      'statusColor': Colors.green,
    },
    {
      'id': 'WD-07412',
      'amount': 'Rp 1.200.000',
      'bank': 'Bank Mandiri (1320-****-43-2)',
      'date': '05 Okt 2026, 11:10',
      'status': 'Berhasil',
      'statusColor': Colors.green,
    },
    {
      'id': 'WD-06109',
      'amount': 'Rp 3.000.000',
      'bank': 'Bank BRI (0123-****-53-8)',
      'date': '18 Sep 2026, 15:40',
      'status': 'Berhasil',
      'statusColor': Colors.green,
    },
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatRupiah(int number) {
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _showWithdrawSheet() {
    _amountController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
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
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tarik Saldo ke Rekening',
                  style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  'Saldo siap ditarik: ${_formatRupiah(_availableBalance)}',
                  style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: PanenaraTheme.primaryGreen, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Rekening Tujuan
                Text(
                  'Rekening Pencairan',
                  style: GoogleFonts.bricolageGrotesque(fontSize: 12.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedAccount,
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: PanenaraTheme.textDark),
                      isExpanded: true,
                      items: [
                        'Bank BRI - 0123-****-53-8 (Budi Santoso)',
                        'Bank Mandiri - 1320-****-43-2 (Budi Santoso)',
                        'DANA - 0812-3456-7890 (Budi Santoso)',
                      ].map((acc) => DropdownMenuItem(
                        value: acc,
                        child: Text(
                          acc,
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: PanenaraTheme.textDark,
                          ),
                        ),
                      )).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setModalState(() => _selectedAccount = val);
                          setState(() => _selectedAccount = val);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Input Nominal
                Text(
                  'Nominal Penarikan (Rp)',
                  style: GoogleFonts.bricolageGrotesque(fontSize: 12.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.primaryGreen),
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    prefixStyle: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.primaryGreen),
                    hintText: '0',
                    hintStyle: GoogleFonts.bricolageGrotesque(fontSize: 18, color: Colors.grey.shade400),
                    filled: true,
                    fillColor: const Color(0xFFF6F8F5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),

                // Quick chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [500000, 1000000, 2000000, _availableBalance].map((nominal) {
                    final label = nominal == _availableBalance ? 'Tarik Semua' : _formatRupiah(nominal);
                    return ActionChip(
                      label: Text(label),
                      labelStyle: GoogleFonts.schibstedGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: PanenaraTheme.primaryGreen),
                      backgroundColor: PanenaraTheme.primaryGreen.withValues(alpha: 0.1),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        setModalState(() {
                          _amountController.text = nominal.toString();
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Info Bebas Biaya Admin
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Bebas biaya admin penarikan. Dana otomatis masuk dalam 1-5 menit.',
                          style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: PanenaraTheme.darkGreenBg),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PanenaraTheme.primaryGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      final parsed = int.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                      if (parsed <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Masukkan nominal penarikan yang valid.')),
                        );
                        return;
                      }
                      if (parsed > _availableBalance) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nominal melebihi saldo yang tersedia.')),
                        );
                        return;
                      }

                      // Execute withdrawal
                      setState(() {
                        _availableBalance -= parsed;
                        _withdrawHistory.insert(0, {
                          'id': 'WD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                          'amount': _formatRupiah(parsed),
                          'bank': _selectedAccount.split(' - ').first,
                          'date': 'Hari ini, baru saja',
                          'status': 'Berhasil',
                          'statusColor': Colors.green,
                        });
                      });

                      Navigator.pop(ctx);
                      _showSuccessDialog(parsed);
                    },
                    child: Text(
                      'Konfirmasi Penarikan',
                      style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(int amount) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PanenaraTheme.primaryGreen.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: PanenaraTheme.primaryGreen, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              'Penarikan Berhasil Diajukan!',
              textAlign: TextAlign.center,
              style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              'Dana sebesar ${_formatRupiah(amount)} sedang ditransfer ke ${_selectedAccount.split(' - ').first}. Silakan periksa mutasi rekening Anda.',
              textAlign: TextAlign.center,
              style: GoogleFonts.schibstedGrotesk(fontSize: 12.5, color: Colors.grey.shade600, height: 1.4),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PanenaraTheme.primaryGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Selesai', style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
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
          'Saldo & Penarikan Dana',
          style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Card Saldo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B3C2B), Color(0xFF2C6B46)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.wallet_rounded, color: PanenaraTheme.goldAccent, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Saldo Aktif Hasil Panen',
                            style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.white70),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Siap Ditarik',
                          style: GoogleFonts.schibstedGrotesk(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _formatRupiah(_availableBalance),
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Colors.white24, height: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dana Kliring / Dalam Proses',
                            style: GoogleFonts.schibstedGrotesk(fontSize: 10.5, color: Colors.white60),
                          ),
                          Text(
                            _formatRupiah(_pendingBalance),
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PanenaraTheme.goldAccent,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: _showWithdrawSheet,
                        icon: const Icon(Icons.arrow_downward_rounded, size: 16, color: PanenaraTheme.darkGreenBg),
                        label: Text(
                          'Tarik Dana',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: PanenaraTheme.darkGreenBg,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PanenaraTheme.goldAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section Riwayat Penarikan
            Text(
              'Riwayat Penarikan Dana',
              style: GoogleFonts.bricolageGrotesque(fontSize: 15, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
            ),
            const SizedBox(height: 10),

            ..._withdrawHistory.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_upward_rounded, color: Colors.red, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Penarikan ke ${item['bank']}',
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
                            '${item['id']} • ${item['date']}',
                            style: GoogleFonts.schibstedGrotesk(fontSize: 11, color: Colors.grey.shade500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item['amount'] as String,
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 2),
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
                              color: item['statusColor'] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
