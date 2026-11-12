import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/panenara_theme.dart';
import '../helpers/db_helper.dart';
import '../models/note_model.dart';

/// ============================================================================
/// MODUL 6.2.5: MEMBUAT CRUD UI DENGAN SQLITE (CHAPTER 6)
/// ============================================================================
/// [NotesPage] (Catatan Kegiatan Tani) mengimplementasikan fitur lengkap CRUD:
/// - Create: Menambah catatan kegiatan tani ke database SQLite via [DBHelper.insert].
/// - Read: Menampilkan daftar catatan dari database via [DBHelper.getNotes].
/// - Update: Mengedit catatan menggunakan [AlertDialog] dan [DBHelper.update].
/// - Delete: Menghapus catatan berdasarkan ID via [DBHelper.delete].
/// - UI Interaktif: [TextField] (Bab 5.2.3), [SnackBar] (Bab 5.2.2), [AlertDialog] (Bab 5.2.1).
/// ============================================================================
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // List data catatan yang dimuat dari SQLite (Bab 6.2.5.b)
  List<Note> notes = [];

  // Controller untuk input judul dan deskripsi catatan
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Memuat data pertama kali saat halaman dibuka (Bab 6.2.5.c)
    _loadNotes();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  /// READ: Mengambil seluruh data catatan dari database SQLite (Bab 6.2.5.d)
  void _loadNotes() async {
    setState(() => _isLoading = true);
    List<Note> list = await DBHelper().getNotes();
    if (!mounted) return;
    setState(() {
      notes = list;
      _isLoading = false;
    });
  }

  /// CREATE: Menyimpan catatan baru ke database SQLite (Bab 6.2.5.e)
  void _saveNote() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    // Validasi input
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Judul dan deskripsi catatan tidak boleh kosong',
            style: GoogleFonts.schibstedGrotesk(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Note note = Note(
      title: title,
      description: description,
    );

    // Simpan ke SQLite
    await DBHelper().insert(note);

    // Refresh daftar catatan
    _loadNotes();

    // Kosongkan form input
    titleController.clear();
    descriptionController.clear();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Catatan berhasil disimpan ke SQLite!',
          style: GoogleFonts.schibstedGrotesk(color: Colors.white),
        ),
        backgroundColor: PanenaraTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// UPDATE: Menampilkan dialog edit catatan lalu memperbarui di database (Bab 6.2.5.f)
  void _editNote(Note note) {
    final editTitleController = TextEditingController(text: note.title);
    final editDescController = TextEditingController(text: note.description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Edit Catatan Tani',
          style: GoogleFonts.bricolageGrotesque(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editTitleController,
              decoration: const InputDecoration(
                labelText: 'Judul Catatan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: editDescController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Catatan',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PanenaraTheme.primaryGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              note.title = editTitleController.text.trim();
              note.description = editDescController.text.trim();

              await DBHelper().update(note);
              _loadNotes();

              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Catatan berhasil diperbarui!',
                    style: GoogleFonts.schibstedGrotesk(color: Colors.white),
                  ),
                  backgroundColor: PanenaraTheme.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// DELETE: Menghapus catatan berdasarkan ID (Bab 6.2.5.g)
  void _deleteNote(int id) async {
    await DBHelper().delete(id);
    _loadNotes();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Catatan dihapus dari database',
          style: GoogleFonts.schibstedGrotesk(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),
      appBar: AppBar(
        backgroundColor: PanenaraTheme.darkGreenBg,
        title: Text(
          'Catatan Tani (SQLite)',
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // ── Form Input Tambah Catatan Baru (Bab 6.2.5.h) ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tambah Catatan Kegiatan Tani',
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: PanenaraTheme.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul (misal: Pemupukan Padi Tahap 1)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi (misal: Pupuk NPK 50 kg untuk lahan blok A)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _saveNote,
                  icon: const Icon(Icons.save_rounded, color: Colors.white, size: 18),
                  label: Text(
                    'Simpan Catatan',
                    style: GoogleFonts.schibstedGrotesk(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PanenaraTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ── Daftar Catatan yang Tersimpan (ListView.builder) ──
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: PanenaraTheme.primaryGreen))
                : notes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notes_rounded, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 10),
                            Text(
                              'Belum ada catatan tani tersimpan.\nSilakan isi formulir di atas untuk mencoba CRUD SQLite.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.schibstedGrotesk(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          Note note = notes[index];
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              title: Text(
                                note.title,
                                style: GoogleFonts.bricolageGrotesque(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: PanenaraTheme.textDark,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  note.description,
                                  style: GoogleFonts.schibstedGrotesk(
                                    fontSize: 12.5,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Tombol Edit
                                  IconButton(
                                    icon: const Icon(Icons.edit_rounded, color: Colors.blue, size: 20),
                                    onPressed: () => _editNote(note),
                                  ),
                                  // Tombol Delete
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
                                    onPressed: () => _deleteNote(note.id!),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
