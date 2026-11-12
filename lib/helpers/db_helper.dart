import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note_model.dart';

/// ============================================================================
/// MODUL 6.2.4: MEMBUAT DBHELPER (CRUD SQLITE - CHAPTER 6)
/// ============================================================================
/// Class [DBHelper] mengelola koneksi dan operasi CRUD pada database lokal SQLite:
/// - Menerapkan Design Pattern Singleton: memastikan hanya ada satu instance database
///   yang aktif di seluruh aplikasi (Bab 6.2.4.a Modul).
/// - [database] : Getter asinkron untuk mengambil atau menginisialisasi database.
/// - [_initDB] : Membuka file database 'notes.db' dan membuat tabel 'notes'.
/// - [insert] : Create data catatan baru (Bab 6.2.4.d.1).
/// - [getNotes] : Read semua data catatan (Bab 6.2.4.d.2).
/// - [update] : Update data catatan yang ada berdasarkan id (Bab 6.2.4.d.3).
/// - [delete] : Delete data catatan berdasarkan id (Bab 6.2.4.d.4).
/// ============================================================================
class DBHelper {
  // Singleton pattern: instance tunggal statis
  static final DBHelper _instance = DBHelper._internal();

  // Factory constructor mengembalikan instance yang sama setiap kali dipanggil
  factory DBHelper() => _instance;

  static Database? _database;

  // Private constructor internal
  DBHelper._internal();

  /// Mengambil instance database; jika belum dibuat, panggil _initDB()
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Inisialisasi database lokal dan pembuatan tabel 'notes'
  Future<Database> _initDB() async {
    // Menemukan path direktori penyimpanan database lokal di perangkat
    String path = join(await getDatabasesPath(), 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Eksekusi DDL membuat tabel 'notes'
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  /// 1. CREATE: Menambahkan catatan baru ke tabel 'notes'
  Future<int> insert(Note note) async {
    Database db = await database;
    return await db.insert('notes', note.toMap());
  }

  /// 2. READ: Mengambil seluruh daftar catatan dari tabel 'notes'
  Future<List<Note>> getNotes() async {
    Database db = await database;
    var result = await db.query('notes', orderBy: 'id DESC');
    return result.map((map) => Note.fromMap(map)).toList();
  }

  /// 3. UPDATE: Memperbarui catatan berdasarkan id
  Future<int> update(Note note) async {
    Database db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// 4. DELETE: Menghapus catatan dari database berdasarkan id
  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
