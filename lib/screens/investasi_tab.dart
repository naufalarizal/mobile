import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';

class InvestasiTab extends StatelessWidget {
  const InvestasiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                      'Investasi Pertanian',
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Danai proyek pertanian, panen keuntungan bersama.',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 12.5,
                        color: PanenaraTheme.textSubtle,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Portfolio Summary
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF258149), Color(0xFF1C6040)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Portofolio Saya',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Rp 12.500.000',
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              _portfolioStat('Aktif', '5'),
                              _vDivider(),
                              _portfolioStat('Selesai', '12'),
                              _vDivider(),
                              _portfolioStat('Total ROI', '+22.3%'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Filter chips
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _filterChip('Semua', true),
                    _filterChip('Padi', false),
                    _filterChip('Sayuran', false),
                    _filterChip('Buah', false),
                    _filterChip('Palawija', false),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proyek Tersedia',
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: PanenaraTheme.textDark,
                      ),
                    ),
                    Text(
                      '8 Proyek',
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Project Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _investCard(
                      'Padi Organik Ciherang',
                      'Subang, Jawa Barat',
                      'Rp 45.000.000',
                      0.72,
                      '72%',
                      '14 - 16%',
                      '45 hari',
                      Icons.grass_rounded,
                    ),
                    const SizedBox(height: 12),
                    _investCard(
                      'Jagung Hibrida Bisi-18',
                      'Grobogan, Jawa Tengah',
                      'Rp 60.000.000',
                      0.48,
                      '48%',
                      '16 - 19%',
                      '60 hari',
                      Icons.yard_rounded,
                    ),
                    const SizedBox(height: 12),
                    _investCard(
                      'Cabai Rawit Merah Prima',
                      'Kediri, Jawa Timur',
                      'Rp 30.000.000',
                      0.88,
                      '88%',
                      '18 - 22%',
                      '30 hari',
                      Icons.spa_rounded,
                    ),
                    const SizedBox(height: 12),
                    _investCard(
                      'Bawang Merah Brebes',
                      'Brebes, Jawa Tengah',
                      'Rp 80.000.000',
                      0.35,
                      '35%',
                      '20 - 25%',
                      '75 hari',
                      Icons.local_florist_rounded,
                    ),
                    const SizedBox(height: 12),
                    _investCard(
                      'Kedelai Non-GMO Organik',
                      'Ngawi, Jawa Timur',
                      'Rp 55.000.000',
                      0.61,
                      '61%',
                      '15 - 18%',
                      '90 hari',
                      Icons.eco_rounded,
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

  Widget _portfolioStat(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.schibstedGrotesk(
              fontSize: 10.5,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider() => Container(width: 1, height: 32, color: Colors.white.withValues(alpha: 0.2));

  Widget _filterChip(String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? PanenaraTheme.primaryGreen : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.schibstedGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _investCard(
    String title,
    String location,
    String target,
    double progress,
    String percent,
    String roi,
    String duration,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: PanenaraTheme.badgeGreenBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: PanenaraTheme.primaryGreen, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: PanenaraTheme.textDark,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 12, color: Colors.grey.shade500),
                        const SizedBox(width: 3),
                        Text(
                          location,
                          style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: PanenaraTheme.badgeGreenBg,
                  borderRadius: BorderRadius.circular(8),
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _miniStat('Target', target),
              _miniStat('Durasi', duration),
              _miniStat('Terkumpul', percent),
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
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: PanenaraTheme.primaryGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Text(
                'Danai Proyek',
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

  Widget _miniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.schibstedGrotesk(fontSize: 10, color: Colors.grey.shade500)),
        Text(
          value,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: PanenaraTheme.textDark,
          ),
        ),
      ],
    );
  }
}
