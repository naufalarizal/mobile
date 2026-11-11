import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/panenara_theme.dart';

class DataUsahaTaniScreen extends StatelessWidget {
  const DataUsahaTaniScreen({super.key});

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
          'Data Usaha Tani',
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
            // Status Verification Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PanenaraTheme.darkGreenBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PanenaraTheme.goldAccent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_rounded, color: PanenaraTheme.goldAccent, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Petani Terverifikasi Panenara',
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Dokumen lahan dan identitas valid. Berhak mengikuti lelang dan pendanaan panen.',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 11.5,
                            color: PanenaraTheme.textSubtle,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Summary Stats Row
            Row(
              children: [
                Expanded(child: _statBox('2,5 Ha', 'Total Luas Lahan', Icons.landscape_rounded)),
                const SizedBox(width: 12),
                Expanded(child: _statBox('3 Plot', 'Komoditas Aktif', Icons.grass_rounded)),
                const SizedBox(width: 12),
                Expanded(child: _statBox('Poktan', 'Sari Tani', Icons.groups_rounded)),
              ],
            ),

            const SizedBox(height: 22),

            // Section 1: Plot & Komoditas Aktif
            Text(
              'Plot & Komoditas Tani Aktif',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: PanenaraTheme.textDark,
              ),
            ),
            const SizedBox(height: 10),

            _plotCard(
              title: 'Plot 1: Padi Organik Ciherang',
              luas: '1,2 Hektar',
              lokasi: 'Blok Sawah Cibeber Tengah',
              status: 'Siap Panen (Est. 8,5 Ton)',
              statusColor: Colors.green,
              icon: Icons.grass_rounded,
              image: 'assets/images/commodity_beras.jpg',
            ),
            const SizedBox(height: 12),

            _plotCard(
              title: 'Plot 2: Cabai Merah Keriting',
              luas: '0,5 Hektar',
              lokasi: 'Tegal Pasir Kaler',
              status: 'Masa Panen Rutin (Est. 1,2 Ton)',
              statusColor: Colors.red,
              icon: Icons.spa_rounded,
              image: 'assets/images/commodity_cabai.jpg',
            ),
            const SizedBox(height: 12),

            _plotCard(
              title: 'Plot 3: Jagung Pipil Hibrida',
              luas: '0,8 Hektar',
              lokasi: 'Lahan Lereng Pasirhayam',
              status: 'Fase Pembuahan (Est. 5 Ton)',
              statusColor: Colors.orange,
              icon: Icons.yard_rounded,
              image: 'assets/images/commodity_jagung.jpg',
            ),

            const SizedBox(height: 22),

            // Section 2: Legalitas & Sertifikasi
            Text(
              'Legalitas & Sertifikat Usaha',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: PanenaraTheme.textDark,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  _docRow(
                    title: 'Sertifikat Hak Milik (SHM) No. 04821',
                    subtitle: 'Terverifikasi Kementerian ATR/BPN Cianjur',
                    status: 'Valid',
                  ),
                  const Divider(height: 1),
                  _docRow(
                    title: 'SPPT-PBB Tahun Berjalan',
                    subtitle: 'Nomor Objek Pajak: 32.03.040.012',
                    status: 'Lunas',
                  ),
                  const Divider(height: 1),
                  _docRow(
                    title: 'Surat Tanda Anggota Kelompok Tani',
                    subtitle: 'Poktan Sari Tani Makmur No. Reg 09/KT/CBB',
                    status: 'Aktif',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String val, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: PanenaraTheme.primaryGreen),
          const SizedBox(height: 6),
          Text(
            val,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: PanenaraTheme.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: GoogleFonts.schibstedGrotesk(fontSize: 10, color: Colors.grey.shade500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _plotCard({
    required String title,
    required String luas,
    required String lokasi,
    required String status,
    required Color statusColor,
    required IconData icon,
    String? image,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: image != null
                  ? Image.asset(image, width: 62, height: 62, fit: BoxFit.cover)
                  : Container(
                      width: 62,
                      height: 62,
                      color: PanenaraTheme.badgeGreenBg,
                      child: Icon(icon, color: PanenaraTheme.primaryGreen, size: 30),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: PanenaraTheme.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.crop_free_rounded, size: 13, color: Color(0xFF3B4D3F)),
                      const SizedBox(width: 4),
                      Text(luas, style: GoogleFonts.schibstedGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF3B4D3F))),
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF3B4D3F)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          lokasi,
                          style: GoogleFonts.schibstedGrotesk(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF3B4D3F)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _docRow({required String title, required String subtitle, required String status}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PanenaraTheme.badgeGreenBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.description_outlined, size: 18, color: PanenaraTheme.primaryGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 12.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 11, color: Colors.grey.shade500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: GoogleFonts.schibstedGrotesk(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
