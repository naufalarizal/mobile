/// ============================================================================
/// MODUL 6.2.3: MODEL NOTE (CRUD SQLITE - CHAPTER 6)
/// ============================================================================
/// Model data untuk objek Catatan (Note) sesuai materi perkuliahan Modul 6.2.3.
/// Merepresentasikan struktur tabel catatan pada database lokal SQLite:
/// - [id] : Primary key integer autoincrement opsional.
/// - [title] : Judul catatan (wajib diisi).
/// - [description] : Isi deskripsi catatan (wajib diisi).
/// - [toMap] : Mengonversi objek Note menjadi `Map<String, dynamic>` untuk disimpan ke SQLite.
/// - [fromMap] : Mengonversi Map data dari database SQLite kembali menjadi objek Note.
/// ============================================================================
class Note {
  int? id;
  String title;
  String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

  /// Mengonversi objek Note ke bentuk Map untuk operasi database (Insert/Update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  /// Mengonversi data Map dari SQLite menjadi instance objek Note
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
