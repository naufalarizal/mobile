import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';
import 'login_screen.dart';
import 'profile/edit_profil_screen.dart';
import 'profile/alamat_saya_screen.dart';
import 'profile/data_usaha_tani_screen.dart';
import 'profile/riwayat_transaksi_screen.dart';
import 'profile/rekening_bank_screen.dart';
import 'profile/saldo_penarikan_screen.dart';

class ProfilTab extends StatelessWidget {
  final VoidCallback? onLogout;
  const ProfilTab({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: PanenaraTheme.primaryGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2.5),
                      ),
                      child: const Icon(Icons.person_rounded, size: 44, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Budi Santoso',
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: PanenaraTheme.goldAccent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: PanenaraTheme.goldAccent.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.verified_rounded, size: 12, color: PanenaraTheme.goldAccent),
                              const SizedBox(width: 4),
                              Text(
                                'Petani Terverifikasi',
                                style: GoogleFonts.schibstedGrotesk(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: PanenaraTheme.goldAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _profileStat('17', 'Transaksi'),
                        _vDivider(),
                        _profileStat('Rp 12,5 Jt', 'Total Invest'),
                        _vDivider(),
                        _profileStat('4.9 ⭐', 'Rating'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Menu List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _sectionTitle('Akun Saya'),
                    const SizedBox(height: 8),
                    _menuCard([
                      _menuItem(
                        context,
                        Icons.person_outline_rounded,
                        'Edit Profil',
                        'Ubah nama, foto, & info pribadi',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const EditProfilScreen()),
                          );
                        },
                      ),
                      _menuItem(
                        context,
                        Icons.location_on_outlined,
                        'Alamat Saya',
                        'Kelola alamat pengiriman & kebun',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AlamatSayaScreen()),
                          );
                        },
                      ),
                      _menuItem(
                        context,
                        Icons.agriculture_rounded,
                        'Data Usaha Tani',
                        'Komoditas & luas lahan Anda',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const DataUsahaTaniScreen()),
                          );
                        },
                      ),
                    ]),

                    const SizedBox(height: 16),
                    _sectionTitle('Transaksi & Keuangan'),
                    const SizedBox(height: 8),
                    _menuCard([
                      _menuItem(
                        context,
                        Icons.receipt_long_rounded,
                        'Riwayat Transaksi',
                        'Lihat semua lelang & investasi',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RiwayatTransaksiScreen()),
                          );
                        },
                      ),
                      _menuItem(
                        context,
                        Icons.account_balance_rounded,
                        'Rekening Bank',
                        'Tambah & kelola rekening',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RekeningBankScreen()),
                          );
                        },
                      ),
                      _menuItem(
                        context,
                        Icons.wallet_rounded,
                        'Saldo & Penarikan',
                        'Kelola dana hasil panen',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SaldoPenarikanScreen()),
                          );
                        },
                      ),
                    ]),

                    const SizedBox(height: 16),
                    _sectionTitle('Lainnya'),
                    const SizedBox(height: 8),
                    _menuCard([
                      _menuItem(
                        context,
                        Icons.notifications_none_rounded,
                        'Notifikasi',
                        'Atur preferensi pemberitahuan',
                        onTap: () => _showNotificationDialog(context),
                      ),
                      _menuItem(
                        context,
                        Icons.lock_outline_rounded,
                        'Keamanan',
                        'Password & autentikasi 2 faktor',
                        onTap: () => _showSecurityDialog(context),
                      ),
                      _menuItem(
                        context,
                        Icons.help_outline_rounded,
                        'Bantuan & FAQ',
                        'Pusat bantuan Panenara',
                        onTap: () => _showHelpFaqDialog(context),
                      ),
                      _menuItem(
                        context,
                        Icons.info_outline_rounded,
                        'Tentang Aplikasi',
                        'Versi 1.0.0',
                        onTap: () => _showAboutDialog(context),
                      ),
                    ]),

                    const SizedBox(height: 20),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: const Color(0xFF1E3C2A),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              title: Text(
                                'Keluar dari Aplikasi?',
                                style: GoogleFonts.bricolageGrotesque(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                'Apakah Anda yakin ingin keluar dari akun Panenara?',
                                style: GoogleFonts.schibstedGrotesk(color: const Color(0xFFCFCFCF), fontSize: 13),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: Text('Batal', style: TextStyle(color: Colors.grey.shade400)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade400,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text('Keluar', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 18),
                        label: Text(
                          'Keluar dari Akun',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.schibstedGrotesk(
            fontSize: 10.5,
            color: Colors.white.withValues(alpha: 0.65),
          ),
        ),
      ],
    );
  }

  Widget _vDivider() => Container(width: 1, height: 32, color: Colors.white.withValues(alpha: 0.2));

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.bricolageGrotesque(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _menuCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: PanenaraTheme.badgeGreenBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: PanenaraTheme.primaryGreen),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: PanenaraTheme.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 16),
            Text(
              'Preferensi Notifikasi',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: PanenaraTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: true,
              onChanged: (_) {},
              activeTrackColor: PanenaraTheme.primaryGreen,
              title: Text(
                'Penawaran Lelang Baru',
                style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              ),
              subtitle: Text(
                'Dapatkan info saat pembeli menawar komoditas Anda',
                style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: const Color(0xFF3B4D3F)),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: true,
              onChanged: (_) {},
              activeTrackColor: PanenaraTheme.primaryGreen,
              title: Text(
                'Status Pencairan Saldo',
                style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              ),
              subtitle: Text(
                'Pemberitahuan ketika dana penarikan berhasil ditransfer',
                style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: const Color(0xFF3B4D3F)),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              value: false,
              onChanged: (_) {},
              activeTrackColor: PanenaraTheme.primaryGreen,
              title: Text(
                'Tips & Berita Pertanian',
                style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              ),
              subtitle: Text(
                'Kabar harga gabah harian dan panduan budidaya',
                style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: const Color(0xFF3B4D3F)),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PanenaraTheme.primaryGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Simpan Pengaturan', style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSecurityDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 16),
            Text(
              'Keamanan Akun',
              style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
            ),
            const SizedBox(height: 14),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: PanenaraTheme.badgeGreenBg, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.password_rounded, color: PanenaraTheme.primaryGreen, size: 20),
              ),
              title: Text(
                'Ubah Kata Sandi',
                style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              ),
              subtitle: Text('Terakhir diubah 3 bulan lalu', style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: const Color(0xFF3B4D3F))),
              trailing: const Icon(Icons.chevron_right_rounded, color: PanenaraTheme.textDark),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu ubah sandi dikirim ke email terdaftar.')));
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: PanenaraTheme.badgeGreenBg, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.fingerprint_rounded, color: PanenaraTheme.primaryGreen, size: 20),
              ),
              title: Text(
                'Biometrik & PIN Transaksi',
                style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              ),
              subtitle: Text('Aktif untuk keamanan otorisasi penarikan saldo', style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: const Color(0xFF3B4D3F))),
              trailing: const Icon(Icons.chevron_right_rounded, color: PanenaraTheme.textDark),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN penarikan sudah aktif.')));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpFaqDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 16),
            Text(
              'Pusat Bantuan & FAQ',
              style: GoogleFonts.bricolageGrotesque(fontSize: 18, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
            ),
            const SizedBox(height: 12),
            Text(
              'Butuh bantuan terkait lelang atau pencairan saldo hasil panen Anda? Tim Panenara siap membantu.',
              style: GoogleFonts.schibstedGrotesk(fontSize: 12.5, color: const Color(0xFF3B4D3F), height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF6F8F5), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded, color: PanenaraTheme.primaryGreen, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer Service WhatsApp', style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark)),
                        Text('+62 811-9988-7766 (Senin - Minggu, 08:00 - 20:00)', style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: const Color(0xFF3B4D3F))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF6F8F5), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.mail_outline_rounded, color: PanenaraTheme.primaryGreen, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email Dukungan Mitra Tani', style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark)),
                        Text('mitra@panenara.id', style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: const Color(0xFF3B4D3F))),
                      ],
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
                style: ElevatedButton.styleFrom(backgroundColor: PanenaraTheme.primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Tutup', style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.eco_rounded, color: PanenaraTheme.primaryGreen, size: 26),
            const SizedBox(width: 8),
            Text('Tentang Panenara', style: GoogleFonts.bricolageGrotesque(fontWeight: FontWeight.bold, color: PanenaraTheme.textDark)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panenara v1.0.0 (Build 2026)',
              style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.primaryGreen),
            ),
            const SizedBox(height: 8),
            Text(
              'Panenara adalah platform ekosistem agritech digital yang menghubungkan petani lokal langsung dengan pembeli komoditas partai besar melalui lelang transparan, adil, dan terpercaya.',
              style: GoogleFonts.schibstedGrotesk(fontSize: 12.5, color: const Color(0xFF2C3E31), height: 1.45),
            ),
            const SizedBox(height: 12),
            Text(
              '© 2026 PT Panenara Digital Agrantara. All rights reserved.',
              style: GoogleFonts.schibstedGrotesk(fontSize: 11, color: const Color(0xFF5A6D5F)),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: PanenaraTheme.primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            onPressed: () => Navigator.pop(ctx),
            child: Text('Mengerti', style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
