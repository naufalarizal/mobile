import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';

class DaftarPembeliScreen extends StatefulWidget {
  const DaftarPembeliScreen({super.key});

  @override
  State<DaftarPembeliScreen> createState() => _DaftarPembeliScreenState();
}

class _DaftarPembeliScreenState extends State<DaftarPembeliScreen> {
  // 1: Persiapkan Dokumen (Langkah 1 dari 5 - 20% Selesai)
  // 2: Foto e-KTP Asli (Langkah 2 dari 5 - 40% Selesai)
  // 3: Selfie Memegang e-KTP (Langkah 3 dari 5 - 60% Selesai)
  // 4: Legalitas Usaha (Langkah 4 dari 5 - 80% Selesai)
  // 5: Konfirmasi Pendaftaran Pembeli (Langkah 5 dari 5 - 100% Selesai)
  int _currentStep = 1;
  final int _totalSteps = 5;

  // Uploaded state flags
  bool _ktpUploaded = false;
  bool _selfieUploaded = false;
  final bool _docUploaded = true;

  final TextEditingController _companyController =
      TextEditingController(text: 'CV Berkah Pangan Nusantara');
  String _selectedJenisUsaha = 'Restoran/Katering';

  final List<String> _jenisUsahaList = [
    'Pedagang Pasar',
    'Restoran/Katering',
    'Pengolah Makanan',
    'Toko Ritel',
  ];

  @override
  void dispose() {
    _companyController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      setState(() => _currentStep++);
    } else {
      _showSuccessDialog();
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E3C2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: PanenaraTheme.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              'Pendaftaran Pembeli Terkirim!',
              textAlign: TextAlign.center,
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Akun pembeli Anda sedang diverifikasi. Anda dapat langsung meninjau katalog lelang komoditas.',
              textAlign: TextAlign.center,
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                color: Colors.white70,
                height: 1.4,
              ),
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
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pop();
                },
                child: const Text('Kembali ke Beranda', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
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
          _currentStep == 4 ? 'Legalitas Usaha' : 'Daftar sebagai Pembeli',
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
            // Top Progress Bar
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
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5CC07B)),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Main Body Switcher
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildStepView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepView() {
    switch (_currentStep) {
      case 1:
        return _buildStep1Persiapan();
      case 2:
        return _buildStep2FotoKTP();
      case 3:
        return _buildStep3SelfieKTP();
      case 4:
        return _buildStep4LegalitasUsaha();
      case 5:
        return _buildStep5Konfirmasi();
      default:
        return _buildStep1Persiapan();
    }
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 1: Persiapan Dokumen Pembeli
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep1Persiapan() {
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
                // Badge: Perorangan maupun usaha
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E8D6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Perorangan maupun usaha',
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
                  'Satu alur untuk semua pembeli. Dokumen usaha hanya perlu diunggah jika Anda membeli atas nama usaha.',
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.82),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),

                // Card 1: Foto e-KTP Asli
                _pembeliDocCard(
                  icon: Icons.camera_alt_outlined,
                  title: 'Foto e-KTP Asli',
                  subtitle: 'Untuk verifikasi identitas penawar',
                  badgeText: 'Wajib',
                  badgeBg: const Color(0xFFD6E8D6),
                  badgeColor: const Color(0xFF2C6B46),
                ),
                const SizedBox(height: 12),

                // Card 2: Selfie memegang e-KTP
                _pembeliDocCard(
                  icon: Icons.person_outline_rounded,
                  title: 'Selfie memegang e-KTP',
                  subtitle: 'Wajah dan KTP terlihat bersamaan',
                  badgeText: 'Wajib',
                  badgeBg: const Color(0xFFD6E8D6),
                  badgeColor: const Color(0xFF2C6B46),
                ),
                const SizedBox(height: 12),

                // Card 3: Legalitas Usaha (NIB / SIUP) - Opsional
                _pembeliDocCard(
                  icon: Icons.description_outlined,
                  title: 'Legalitas Usaha (NIB / SIUP)',
                  subtitle: 'Untuk usaha, CV, atau koperasi',
                  badgeText: 'Opsional',
                  badgeBg: const Color(0xFFFFECC8),
                  badgeColor: const Color(0xFFC77A19),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Bottom Button: Mulai Pendaftaran ➔
        _bottomActionButton(
          label: 'Mulai Pendaftaran',
          onPressed: _nextStep,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 2: Unggah Foto e-KTP Asli (Sama persis dengan Petani)
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep2FotoKTP() {
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
        _bottomActionButton(
          label: 'Lanjut ke Selfie e-KTP',
          onPressed: () {
            if (!_ktpUploaded) {
              setState(() => _ktpUploaded = true);
            }
            _nextStep();
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 3: Foto Selfie Memegang e-KTP (Sama persis dengan Petani)
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep3SelfieKTP() {
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
        _bottomActionButton(
          label: 'Lanjut ke Legalitas Usaha',
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
  // STEP 4: Data Legalitas Usaha (Gambar 2 Sesuai Permintaan User)
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep4LegalitasUsaha() {
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
                // Badge: Opsional
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECC8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Opsional',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFC77A19),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Title: Data Legalitas Usaha
                Text(
                  'Data Legalitas Usaha',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),

                // Subtitle
                Text(
                  'Lewati langkah ini jika Anda membeli sebagai perorangan.',
                  style: GoogleFonts.schibstedGrotesk(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.82),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),

                // 1. Upload Document Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F7F0), // Mint-white background from Figma
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF2C6B46),
                        size: 28,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Unggah dokumen legalitas (NIB, SIUP, atau Akta\nPendirian)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: PanenaraTheme.textDark,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Format PDF atau foto, maks. 10MB',
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 11.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 2. Uploaded Document Item (NIB_CV_Berkah_Pangan.pdf)
                if (_docUploaded)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F2E6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: Color(0xFF2C6B46),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NIB_CV_Berkah_Pangan.pdf',
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '1,4 MB · Tersambung',
                                style: GoogleFonts.schibstedGrotesk(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F2E6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Valid',
                            style: GoogleFonts.schibstedGrotesk(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2C6B46),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 18),

                // 3. Nama Usaha / Perusahaan
                Text(
                  'Nama Usaha / Perusahaan',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _companyController,
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: PanenaraTheme.textDark,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F2E6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Valid',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2C6B46),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 4. Jenis Usaha (Chips)
                Text(
                  'Jenis Usaha',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _jenisUsahaList.map((item) {
                    final bool isSelected = _selectedJenisUsaha == item;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedJenisUsaha = item);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFD6E8D6) : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF2C6B46) : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          item,
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? const Color(0xFF1B3C2B) : PanenaraTheme.textDark,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),

        // Bottom CTA
        _bottomActionButton(
          label: 'Lanjut ke Verifikasi Berkas',
          onPressed: _nextStep,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // STEP 5: Konfirmasi Akhir Pembeli (Bebas Overflow)
  // ─────────────────────────────────────────────────────────────
  Widget _buildStep5Konfirmasi() {
    return Column(
      key: const ValueKey(5),
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Konfirmasi Pendaftaran Pembeli',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pastikan seluruh data penawar dan badan usaha sudah benar.',
                  style: GoogleFonts.schibstedGrotesk(fontSize: 13, color: Colors.white70),
                ),
                const SizedBox(height: 20),

                _reviewRow('Status Identitas', 'e-KTP & Selfie Valid'),
                const SizedBox(height: 10),
                _reviewRow('Badan Usaha', _companyController.text),
                const SizedBox(height: 10),
                _reviewRow('Jenis Usaha', _selectedJenisUsaha),
                const SizedBox(height: 10),
                _reviewRow('Dokumen Legalitas', 'NIB_CV_Berkah_Pangan.pdf (1.4 MB)'),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_user_outlined, color: PanenaraTheme.goldAccent, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Dengan mendaftar, akun pembeli Anda akan mendapatkan plafon penawaran komoditas terverifikasi.',
                          style: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.white, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        _bottomActionButton(label: 'Kirim Pendaftaran Pembeli', onPressed: _nextStep),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Reusable Component Helpers
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

  Widget _pembeliDocCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeBg,
    required Color badgeColor,
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badgeText,
                        style: GoogleFonts.schibstedGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: badgeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
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

  // Row anti overflow dengan Expanded & text ellipsis
  Widget _reviewRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.schibstedGrotesk(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: PanenaraTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomActionButton({
    required String label,
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
            backgroundColor: const Color(0xFF258149),
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
              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
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
          'Bantuan Pendaftaran Pembeli',
          style: GoogleFonts.bricolageGrotesque(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Pendaftaran pembeli dapat dilakukan perorangan maupun atas nama badan usaha (CV, PT, Koperasi).\n\nUntuk badan usaha, sertakan berkas NIB/SIUP agar mendapatkan fasilitas penawaran partai besar langsung dari petani.',
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
