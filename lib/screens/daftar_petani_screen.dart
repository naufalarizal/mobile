import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';
import '../helpers/user_session.dart';

class DaftarPetaniScreen extends StatefulWidget {
  const DaftarPetaniScreen({super.key});

  @override
  State<DaftarPetaniScreen> createState() => _DaftarPetaniScreenState();
}

class _DaftarPetaniScreenState extends State<DaftarPetaniScreen> {
  // 0: Persiapan Dokumen
  // 1: Foto e-KTP
  // 2: Selfie memegang e-KTP
  // 3: Dokumen Kepemilikan Lahan
  // 4: Ringkasan & Konfirmasi
  // 5: Estimasi Verifikasi (Selesai)
  int _currentStep = 0;
  final int _totalSteps = 5;

  // State uploaded flags
  bool _ktpUploaded = false;
  bool _selfieUploaded = false;
  bool _lahanUploaded = false;

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _currentStep / _totalSteps;
    final int percent = (progress * 100).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFF1B3C2B), // Dark green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: _prevStep,
        ),
        centerTitle: true,
        title: Text(
          'Daftar sebagai Petani',
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded, color: Colors.white70),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Step Progress Indicator (displayed on steps 0 to 4)
            if (_currentStep < 5) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Langkah $_currentStep dari $_totalSteps',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 12.5,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$percent% Selesai',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 12.5,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(PanenaraTheme.primaryGreen),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Step Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: _buildStepContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep0Persiapan();
      case 1:
        return _buildStep1FotoKTP();
      case 2:
        return _buildStep2SelfieKTP();
      case 3:
        return _buildStep3DokumenLahan();
      case 4:
        return _buildStep4Konfirmasi();
      case 5:
        return _buildStep5EstimasiSelesai();
      default:
        return _buildStep0Persiapan();
    }
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 0: Persiapan Dokumen (Sesuai gambar awal user)
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep0Persiapan() {
    return Column(
      key: const ValueKey(0),
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2E6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Jalur Mitra Tani',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B3C2B),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Persiapkan Dokumen Pendaftaran',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Pastikan dokumen kondisi jelas dan asli untuk mempercepat proses verifikasi akun petani Anda.',
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.82),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),

                _docCard(
                  icon: Icons.camera_alt_outlined,
                  title: 'Foto e-KTP Asli',
                  desc: 'Foto jelas, terbaca, tidak terpotong dan tanpa blur',
                  badge: 'Wajib',
                ),
                const SizedBox(height: 12),

                _docCard(
                  icon: Icons.person_outline_rounded,
                  title: 'Selfie memegang e-KTP',
                  desc: 'Wajah dan identitas e-KTP terlihat bersamaan',
                  badge: 'Wajib',
                ),
                const SizedBox(height: 12),

                _docCard(
                  icon: Icons.description_outlined,
                  title: 'Dokumen Kepemilikan / Sewa Lahan',
                  desc: 'Sertifikat, SPPT-PBB, surat sewa, atau keterangan desa',
                  badge: 'Wajib',
                ),
                const SizedBox(height: 12),

                _docCard(
                  icon: Icons.hourglass_empty_rounded,
                  title: 'Estimasi verifikasi',
                  desc: 'Biasanya selesai dalam 1-2 hari kerja',
                  badge: null,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Bottom CTA
        _bottomButton(
          label: 'Mulai Pendaftaran',
          icon: Icons.arrow_forward_rounded,
          onPressed: _nextStep,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 1: Foto e-KTP Asli
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep1FotoKTP() {
    return Column(
      key: const ValueKey(1),
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepHeader(
                  title: 'Unggah Foto e-KTP Asli',
                  subtitle: 'Pastikan seluruh tulisan pada e-KTP terbaca jelas dan tidak terkena pantulan cahaya.',
                ),
                const SizedBox(height: 20),

                // Upload Frame Box
                GestureDetector(
                  onTap: () {
                    setState(() => _ktpUploaded = !_ktpUploaded);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _ktpUploaded ? PanenaraTheme.primaryGreen : Colors.grey.shade300,
                        width: _ktpUploaded ? 2 : 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _ktpUploaded
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE8F2E6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_circle_rounded, color: PanenaraTheme.primaryGreen, size: 38),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Foto e-KTP Siap Diunggah',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ktp_asli_terverifikasi.jpg (Ketuk untuk ganti)',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade600),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F2E6),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.add_a_photo_outlined, color: PanenaraTheme.primaryGreen, size: 36),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Ketuk untuk Ambil / Unggah Foto e-KTP',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Format JPG/PNG maksimal 5 MB',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Tips Card
                _tipsCard([
                  'Gunakan e-KTP fisik asli, bukan fotokopi',
                  'Posisikan e-KTP pas di dalam bingkai',
                  'Pastikan NIK dan Nama terlihat terang dan tajam',
                ]),
              ],
            ),
          ),
        ),
        _bottomButton(
          label: 'Lanjut ke Selfie e-KTP',
          icon: Icons.arrow_forward_rounded,
          onPressed: () {
            if (!_ktpUploaded) {
              setState(() => _ktpUploaded = true); // auto-fill demo
            }
            _nextStep();
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 2: Selfie Memegang e-KTP
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep2SelfieKTP() {
    return Column(
      key: const ValueKey(2),
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepHeader(
                  title: 'Foto Selfie Memegang e-KTP',
                  subtitle: 'Pegang e-KTP Anda di sebelah wajah dengan posisi tegak dan tidak menutupi muka.',
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    setState(() => _selfieUploaded = !_selfieUploaded);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _selfieUploaded ? PanenaraTheme.primaryGreen : Colors.grey.shade300,
                        width: _selfieUploaded ? 2 : 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _selfieUploaded
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE8F2E6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_circle_rounded, color: PanenaraTheme.primaryGreen, size: 38),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Foto Selfie e-KTP Siap',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'selfie_ktp_petani.jpg (Ketuk untuk ganti)',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade600),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F2E6),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.face_retouching_natural_rounded, color: PanenaraTheme.primaryGreen, size: 36),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Ketuk untuk Ambil Foto Selfie',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Wajah & e-KTP terlihat bersamaan',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                _tipsCard([
                  'Lepaskan kacamata hitam, masker, atau topi',
                  'Pastikan pencahayaan cukup terang',
                  'Jangan menutupi tulisan NIK dengan jari',
                ]),
              ],
            ),
          ),
        ),
        _bottomButton(
          label: 'Lanjut ke Dokumen Lahan',
          icon: Icons.arrow_forward_rounded,
          onPressed: () {
            if (!_selfieUploaded) {
              setState(() => _selfieUploaded = true);
            }
            _nextStep();
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 3: Dokumen Kepemilikan / Sewa Lahan
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep3DokumenLahan() {
    return Column(
      key: const ValueKey(3),
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepHeader(
                  title: 'Dokumen Kepemilikan / Sewa Lahan',
                  subtitle: 'Unggah bukti kepemilikan lahan atau surat perjanjian sewa/garap lahan pertanian.',
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    setState(() => _lahanUploaded = !_lahanUploaded);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _lahanUploaded ? PanenaraTheme.primaryGreen : Colors.grey.shade300,
                        width: _lahanUploaded ? 2 : 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _lahanUploaded
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE8F2E6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_circle_rounded, color: PanenaraTheme.primaryGreen, size: 36),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Dokumen Lahan Berhasil Diunggah',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'sppt_pbb_lahan_2ha.pdf (Ketuk untuk ganti)',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade600),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F2E6),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.upload_file_rounded, color: PanenaraTheme.primaryGreen, size: 36),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Unggah Dokumen Lahan / Sawah',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sertifikat, SPPT-PBB, atau Surat Keterangan Desa',
                                style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Informasi Lahan Tambahan
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rincian Lahan Garapan',
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _miniTextField('Luas Lahan (Contoh: 1.5 Hektar)', Icons.straighten_rounded),
                      const SizedBox(height: 10),
                      _miniTextField('Komoditas yang Ditanam (Contoh: Padi Ciherang)', Icons.grass_rounded),
                      const SizedBox(height: 10),
                      _miniTextField('Alamat Lahan / Desa & Kecamatan', Icons.location_on_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _bottomButton(
          label: 'Periksa & Kirim Berkas',
          icon: Icons.check_circle_outline_rounded,
          onPressed: () {
            if (!_lahanUploaded) {
              setState(() => _lahanUploaded = true);
            }
            _nextStep();
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 4: Konfirmasi Berkas Sebelum Verifikasi
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep4Konfirmasi() {
    return Column(
      key: const ValueKey(4),
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepHeader(
                  title: 'Konfirmasi Kelengkapan Dokumen',
                  subtitle: 'Pastikan 3 dokumen utama berikut telah siap dikirim ke tim verifikasi Panenara.',
                ),
                const SizedBox(height: 20),

                _statusItem('Foto e-KTP Asli', 'Tersedia & terbaca jelas', true),
                const SizedBox(height: 10),
                _statusItem('Selfie Memegang e-KTP', 'Wajah & NIK cocok', true),
                const SizedBox(height: 10),
                _statusItem('Bukti Legalitas Lahan', 'SPPT-PBB terunggah', true),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shield_outlined, color: PanenaraTheme.goldAccent, size: 28),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Data Anda dienkripsi dan dilindungi sesuai standar privasi Panenara untuk keamanan lelang tani.',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.4,
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
        _bottomButton(
          label: 'Kirim Dokumen Pendaftaran',
          icon: Icons.send_rounded,
          onPressed: _nextStep,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 5: Estimasi Verifikasi (Halaman Sukses / Selesai)
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep5EstimasiSelesai() {
    return SingleChildScrollView(
      key: const ValueKey(5),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Big Success Icon
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF2C6B46),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.25), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'Dokumen Berhasil Terkirim!',
            textAlign: TextAlign.center,
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'Terima kasih telah mendaftar sebagai Mitra Petani Panenara.',
            textAlign: TextAlign.center,
            style: GoogleFonts.schibstedGrotesk(
              fontSize: 13.5,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 24),

          // Estimasi Verifikasi Card (matching the 4th item in user's image)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F2E6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.hourglass_top_rounded, color: Color(0xFF2C6B46), size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimasi Verifikasi',
                            style: GoogleFonts.bricolageGrotesque(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: PanenaraTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Biasanya selesai dalam 1-2 hari kerja',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 12.5,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 14),
                _infoRow('Nomor Pengajuan', '#MITRA-PTN-202611'),
                const SizedBox(height: 8),
                _infoRow('Status Berkas', 'Sedang Ditinjau Tim Verifikator'),
                const SizedBox(height: 8),
                _infoRow('Notifikasi', 'Akan dikirimkan via WhatsApp'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Tombol Kembali ke Beranda
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Mengubah status akun menjadi Petani Terverifikasi (RBAC)
                UserSession.setRole(UserRole.petani);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Pendaftaran berhasil! Akun Anda aktif sebagai Petani (Dapat melelang hasil tani).',
                      style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                    ),
                    backgroundColor: PanenaraTheme.primaryGreen,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PanenaraTheme.primaryGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                'Kembali ke Beranda',
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Helper Widgets
  // ─────────────────────────────────────────────────────────────
  Widget _stepHeader({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.schibstedGrotesk(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.85),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _tipsCard(List<String> tips) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline_rounded, color: PanenaraTheme.goldAccent, size: 20),
              const SizedBox(width: 8),
              Text(
                'Tips Foto Berkualitas:',
                style: GoogleFonts.bricolageGrotesque(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...tips.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: PanenaraTheme.goldAccent, fontSize: 14)),
                  Expanded(
                    child: Text(
                      t,
                      style: GoogleFonts.schibstedGrotesk(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.88),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _docCard({
    required IconData icon,
    required String title,
    required String desc,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2E6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF2C6B46), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
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
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.textDark,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F2E6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2C6B46),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusItem(String label, String value, bool isSuccess) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_rounded : Icons.pending_rounded,
            color: isSuccess ? PanenaraTheme.primaryGreen : Colors.orange,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: PanenaraTheme.textDark,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniTextField(String hint, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: TextField(
        style: GoogleFonts.schibstedGrotesk(
          fontSize: 13.5,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1B3C2B),
        ),
        cursorColor: PanenaraTheme.primaryGreen,
        decoration: InputDecoration(
          icon: Icon(icon, size: 18, color: PanenaraTheme.primaryGreen),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.schibstedGrotesk(
            fontSize: 12.5,
            color: const Color(0xFF5E7364),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade600)),
        Text(val, style: GoogleFonts.schibstedGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark)),
      ],
    );
  }

  Widget _bottomButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3C2B),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: PanenaraTheme.primaryGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.schibstedGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E3C2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Bantuan Pendaftaran Petani',
          style: GoogleFonts.bricolageGrotesque(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Alur verifikasi petani:\n1. Foto e-KTP fisik asli\n2. Selfie bersama e-KTP\n3. Dokumen garap/sewa lahan\n4. Verifikasi berkas (1-2 hari kerja)',
          style: GoogleFonts.schibstedGrotesk(color: const Color(0xFFCFCFCF), fontSize: 13, height: 1.45),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Mengerti', style: TextStyle(color: PanenaraTheme.lightMint)),
          ),
        ],
      ),
    );
  }
}
