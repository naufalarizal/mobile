import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/panenara_theme.dart';

class AlamatSayaScreen extends StatefulWidget {
  const AlamatSayaScreen({super.key});

  @override
  State<AlamatSayaScreen> createState() => _AlamatSayaScreenState();
}

class _AlamatSayaScreenState extends State<AlamatSayaScreen> {
  final List<Map<String, dynamic>> _addressList = [
    {
      'id': 1,
      'title': 'Rumah Tinggal (Utama)',
      'name': 'Budi Santoso',
      'phone': '0812-3456-7890',
      'address': 'Jl. Raya Cibeber No. 45, RT 02/RW 04, Desa Sukamaju, Kec. Cibeber',
      'city': 'Kabupaten Cianjur, Jawa Barat 43262',
      'isDefault': true,
      'type': 'Rumah',
      'icon': Icons.home_rounded,
    },
    {
      'id': 2,
      'title': 'Lahan Ciherang Blok B (Titik Jemput Panen)',
      'name': 'Budi Santoso (Poktan Sari Tani)',
      'phone': '0812-3456-7890',
      'address': 'Jalan Usaha Tani Blok B, Sebelah Saluran Irigasi Sekunder Cibeber (Akses Truk Double Engkel)',
      'city': 'Kec. Cibeber, Kab. Cianjur, Jawa Barat 43262',
      'isDefault': false,
      'type': 'Lahan Tani',
      'icon': Icons.agriculture_rounded,
    },
    {
      'id': 3,
      'title': 'Gudang Pengeringan & Pengemasan',
      'name': 'Kelompok Tani Makmur Cibeber',
      'phone': '0813-8899-7766',
      'address': 'Kawasan Sentra Padi Cibeber, Jl. Alternatif Pasirhayam No. 12',
      'city': 'Kabupaten Cianjur, Jawa Barat 43256',
      'isDefault': false,
      'type': 'Gudang',
      'icon': Icons.warehouse_rounded,
    },
  ];

  void _showAddAddressDialog() {
    final titleCtrl = TextEditingController();
    final nameCtrl = TextEditingController(text: 'Budi Santoso');
    final phoneCtrl = TextEditingController(text: '081234567890');
    final addressCtrl = TextEditingController();
    final cityCtrl = TextEditingController(text: 'Cianjur, Jawa Barat');
    String selectedType = 'Lahan Tani';

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
                  'Tambah Alamat / Lokasi Lahan',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PanenaraTheme.textDark,
                  ),
                ),
                const SizedBox(height: 14),
                // Type chips
                Row(
                  children: ['Lahan Tani', 'Rumah', 'Gudang'].map((t) {
                    final sel = selectedType == t;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(t),
                        selected: sel,
                        onSelected: (_) => setModalState(() => selectedType = t),
                        selectedColor: PanenaraTheme.primaryGreen.withValues(alpha: 0.15),
                        labelStyle: GoogleFonts.schibstedGrotesk(
                          fontSize: 12,
                          fontWeight: sel ? FontWeight.bold : FontWeight.w500,
                          color: sel ? PanenaraTheme.primaryGreen : PanenaraTheme.textDark,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                _inputField(titleCtrl, 'Label Lokasi (contoh: Lahan Petak 2)'),
                const SizedBox(height: 10),
                _inputField(nameCtrl, 'Nama Kontak / Penanggung Jawab'),
                const SizedBox(height: 10),
                _inputField(phoneCtrl, 'Nomor HP / WhatsApp', keyboardType: TextInputType.phone),
                const SizedBox(height: 10),
                _inputField(addressCtrl, 'Alamat Lengkap & Patokan Akses Truk', maxLines: 2),
                const SizedBox(height: 10),
                _inputField(cityCtrl, 'Kecamatan, Kota/Kabupaten, Kode Pos'),
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
                      if (titleCtrl.text.isNotEmpty && addressCtrl.text.isNotEmpty) {
                        setState(() {
                          _addressList.add({
                            'id': DateTime.now().millisecondsSinceEpoch,
                            'title': titleCtrl.text,
                            'name': nameCtrl.text,
                            'phone': phoneCtrl.text,
                            'address': addressCtrl.text,
                            'city': cityCtrl.text,
                            'isDefault': false,
                            'type': selectedType,
                            'icon': selectedType == 'Rumah'
                                ? Icons.home_rounded
                                : (selectedType == 'Gudang' ? Icons.warehouse_rounded : Icons.agriculture_rounded),
                          });
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Lokasi berhasil ditambahkan!'),
                            backgroundColor: PanenaraTheme.primaryGreen,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Simpan Alamat',
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

  Widget _inputField(TextEditingController ctrl, String hint, {TextInputType? keyboardType, int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.schibstedGrotesk(fontSize: 12.5, color: const Color(0xFF5E7364), fontWeight: FontWeight.w500),
        filled: true,
        fillColor: const Color(0xFFF6F8F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFBDC7BE), width: 1.2)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFBDC7BE), width: 1.2)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
          'Alamat & Lokasi Lahan',
          style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        itemCount: _addressList.length,
        itemBuilder: (ctx, i) {
          final item = _addressList[i];
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
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: PanenaraTheme.primaryGreen.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(item['icon'] as IconData, size: 18, color: PanenaraTheme.primaryGreen),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: PanenaraTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                  const SizedBox(height: 10),
                  Text(
                    '${item['name']} • ${item['phone']}',
                    style: GoogleFonts.schibstedGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['address'] as String,
                    style: GoogleFonts.schibstedGrotesk(fontSize: 12.5, color: PanenaraTheme.textDark, height: 1.35),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['city'] as String,
                    style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!isDefault)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              for (var a in _addressList) {
                                a['isDefault'] = false;
                              }
                              item['isDefault'] = true;
                            });
                          },
                          child: Text(
                            'Jadikan Utama',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: PanenaraTheme.primaryGreen,
                            ),
                          ),
                        ),
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Fitur ubah lokasi siap digunakan.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_outlined, size: 14, color: Colors.grey),
                        label: Text(
                          'Ubah',
                          style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
            onPressed: _showAddAddressDialog,
            icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white, size: 18),
            label: Text(
              'Tambah Lokasi / Lahan Baru',
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
