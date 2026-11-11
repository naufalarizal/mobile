import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/panenara_theme.dart';

class RekeningBankScreen extends StatefulWidget {
  const RekeningBankScreen({super.key});

  @override
  State<RekeningBankScreen> createState() => _RekeningBankScreenState();
}

class _RekeningBankScreenState extends State<RekeningBankScreen> {
  final List<Map<String, dynamic>> _bankAccounts = [
    {
      'id': 1,
      'bankName': 'Bank Rakyat Indonesia (BRI)',
      'shortName': 'BRI',
      'accountNumber': '0123-0100-4567-53-8',
      'holderName': 'BUDI SANTOSO',
      'isDefault': true,
      'isVerified': true,
      'color': const Color(0xFF00529C),
      'icon': Icons.account_balance_rounded,
    },
    {
      'id': 2,
      'bankName': 'Bank Mandiri',
      'shortName': 'Mandiri',
      'accountNumber': '132-00-9876543-2',
      'holderName': 'BUDI SANTOSO',
      'isDefault': false,
      'isVerified': true,
      'color': const Color(0xFF003865),
      'icon': Icons.account_balance_rounded,
    },
    {
      'id': 3,
      'bankName': 'DANA Dompet Digital',
      'shortName': 'DANA',
      'accountNumber': '0812-3456-7890',
      'holderName': 'BUDI SANTOSO',
      'isDefault': false,
      'isVerified': true,
      'color': const Color(0xFF118EEA),
      'icon': Icons.phone_android_rounded,
    },
  ];

  void _showAddBankModal() {
    String selectedBank = 'Bank Central Asia (BCA)';
    final accNumberCtrl = TextEditingController();
    final holderCtrl = TextEditingController(text: 'BUDI SANTOSO');

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
                'Tambah Rekening Bank / E-Wallet',
                style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              ),
              const SizedBox(height: 6),
              Text(
                'Pastikan nama pemilik rekening sama dengan nama pada e-KTP terverifikasi.',
                style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              // Bank selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F8F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedBank,
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: PanenaraTheme.textDark),
                    isExpanded: true,
                    items: [
                      'Bank Central Asia (BCA)',
                      'Bank Negara Indonesia (BNI)',
                      'Bank Syariah Indonesia (BSI)',
                      'Bank BJB (Jawa Barat)',
                      'GoPay / ShopeePay',
                    ].map((b) => DropdownMenuItem(
                      value: b,
                      child: Text(
                        b,
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.textDark,
                        ),
                      ),
                    )).toList(),
                    onChanged: (val) {
                      if (val != null) setModalState(() => selectedBank = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: accNumberCtrl,
                keyboardType: TextInputType.number,
                style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                decoration: InputDecoration(
                  labelText: 'Nomor Rekening / No. HP E-Wallet',
                  labelStyle: GoogleFonts.schibstedGrotesk(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF3B4D3F)),
                  filled: true,
                  fillColor: const Color(0xFFF6F8F5),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: holderCtrl,
                style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Nama Pemilik Rekening (Sesuai KTP)',
                  labelStyle: GoogleFonts.schibstedGrotesk(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF3B4D3F)),
                  suffixIcon: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20),
                  filled: true,
                  fillColor: const Color(0xFFF0F3EF),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    if (accNumberCtrl.text.isNotEmpty) {
                      setState(() {
                        _bankAccounts.add({
                          'id': DateTime.now().millisecondsSinceEpoch,
                          'bankName': selectedBank,
                          'shortName': selectedBank.split(' ').first,
                          'accountNumber': accNumberCtrl.text,
                          'holderName': holderCtrl.text,
                          'isDefault': false,
                          'isVerified': true,
                          'color': const Color(0xFF00529C),
                          'icon': Icons.account_balance_rounded,
                        });
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Rekening $selectedBank berhasil ditambahkan!'),
                          backgroundColor: PanenaraTheme.primaryGreen,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Simpan & Verifikasi Rekening',
                    style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
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
          'Rekening Bank & E-Wallet',
          style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: PanenaraTheme.primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: PanenaraTheme.primaryGreen.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: PanenaraTheme.primaryGreen, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Seluruh penarikan hasil lelang komoditas akan dikirimkan ke rekening utama terverifikasi tanpa potongan biaya admin.',
                    style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: PanenaraTheme.darkGreenBg, height: 1.35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          Text(
            'Daftar Rekening Terdaftar',
            style: GoogleFonts.bricolageGrotesque(fontSize: 14.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
          ),
          const SizedBox(height: 10),

          ..._bankAccounts.map((item) {
            final bool isDefault = item['isDefault'] as bool;

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDefault ? PanenaraTheme.primaryGreen : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['bankName'] as String,
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item['holderName'] as String,
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        if (isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: PanenaraTheme.primaryGreen,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Utama',
                              style: GoogleFonts.schibstedGrotesk(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F8F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['accountNumber'] as String,
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              color: PanenaraTheme.textDark,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Colors.green, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'Terverifikasi',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (!isDefault) ...[
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              for (var b in _bankAccounts) {
                                b['isDefault'] = false;
                              }
                              item['isDefault'] = true;
                            });
                          },
                          child: Text(
                            'Jadikan Rekening Utama Penarikan',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: PanenaraTheme.primaryGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -3)),
          ],
        ),
        child: SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _showAddBankModal,
            icon: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            label: Text(
              'Tambah Rekening Bank Baru',
              style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: PanenaraTheme.primaryGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
