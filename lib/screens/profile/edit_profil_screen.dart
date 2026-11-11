import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/panenara_theme.dart';

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _nikController;

  String _gender = 'Laki-laki';
  DateTime _birthDate = DateTime(1985, 5, 12);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Budi Santoso');
    _phoneController = TextEditingController(text: '081234567890');
    _emailController = TextEditingController(text: 'budi.santoso@panenara.id');
    _bioController = TextEditingController(
      text: 'Petani Padi Organik Ciherang & Palawija wilayah Cibeber, Cianjur.',
    );
    _nikController = TextEditingController(text: '3201234567890001');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _nikController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                'Perubahan profil berhasil disimpan!',
                style: GoogleFonts.schibstedGrotesk(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: PanenaraTheme.primaryGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
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
          'Edit Profil',
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              'Simpan',
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: PanenaraTheme.goldAccent,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Avatar Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: PanenaraTheme.darkGreenBg,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: PanenaraTheme.primaryGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(Icons.person_rounded, size: 52, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: PanenaraTheme.goldAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt_rounded, size: 16, color: PanenaraTheme.darkGreenBg),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ubah Foto Profil',
                    style: GoogleFonts.schibstedGrotesk(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: PanenaraTheme.textSubtle,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Informasi Akun Tani'),
                    const SizedBox(height: 8),
                    _buildCard([
                      _buildTextField(
                        controller: _nameController,
                        label: 'Nama Lengkap',
                        icon: Icons.person_outline_rounded,
                        validator: (v) => v == null || v.isEmpty ? 'Nama tidak boleh kosong' : null,
                      ),
                      const Divider(height: 1),
                      _buildReadOnlyField(
                        controller: _nikController,
                        label: 'NIK (Terverifikasi e-KTP)',
                        icon: Icons.badge_outlined,
                        badge: 'Verified',
                      ),
                      const Divider(height: 1),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Nomor WhatsApp',
                        icon: Icons.phone_android_rounded,
                        keyboardType: TextInputType.phone,
                      ),
                      const Divider(height: 1),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ]),

                    const SizedBox(height: 18),
                    _sectionLabel('Detail Pribadi'),
                    const SizedBox(height: 8),
                    _buildCard([
                      // Gender selection
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jenis Kelamin',
                              style: GoogleFonts.schibstedGrotesk(fontSize: 11, color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _genderChip('Laki-laki'),
                                const SizedBox(width: 12),
                                _genderChip('Perempuan'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      // Birth date
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _birthDate,
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => _birthDate = picked);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 20, color: PanenaraTheme.primaryGreen),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tanggal Lahir',
                                      style: GoogleFonts.schibstedGrotesk(fontSize: 11, color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${_birthDate.day} Mei ${_birthDate.year}',
                                      style: GoogleFonts.schibstedGrotesk(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.bold,
                                        color: PanenaraTheme.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ]),

                    const SizedBox(height: 18),
                    _sectionLabel('Bio & Catatan Kebun'),
                    const SizedBox(height: 8),
                    _buildCard([
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: _bioController,
                          maxLines: 3,
                          style: GoogleFonts.schibstedGrotesk(fontSize: 13, color: PanenaraTheme.textDark),
                          decoration: InputDecoration(
                            hintText: 'Tuliskan deskripsi pengalaman bertani atau varietas unggulan Anda...',
                            hintStyle: GoogleFonts.schibstedGrotesk(fontSize: 12, color: Colors.grey.shade400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ]),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PanenaraTheme.primaryGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: Text(
                          'Simpan Perubahan',
                          style: GoogleFonts.schibstedGrotesk(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.bricolageGrotesque(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: PanenaraTheme.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              style: GoogleFonts.schibstedGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.schibstedGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF3B4D3F)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String badge,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: PanenaraTheme.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.schibstedGrotesk(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF3B4D3F))),
                const SizedBox(height: 2),
                Text(
                  controller.text,
                  style: GoogleFonts.schibstedGrotesk(fontSize: 13.5, fontWeight: FontWeight.bold, color: PanenaraTheme.textDark),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: PanenaraTheme.primaryGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              badge,
              style: GoogleFonts.schibstedGrotesk(
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: PanenaraTheme.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderChip(String label) {
    final isSelected = _gender == label;
    return GestureDetector(
      onTap: () => setState(() => _gender = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? PanenaraTheme.primaryGreen.withValues(alpha: 0.12) : const Color(0xFFF0F3EF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? PanenaraTheme.primaryGreen : Colors.transparent),
        ),
        child: Text(
          label,
          style: GoogleFonts.schibstedGrotesk(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? PanenaraTheme.primaryGreen : PanenaraTheme.textDark,
          ),
        ),
      ),
    );
  }
}
