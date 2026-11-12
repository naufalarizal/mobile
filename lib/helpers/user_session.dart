import 'package:flutter/material.dart';

/// ============================================================================
/// MODUL 5: MANAJEMEN STATE PERAN PENGGUNA (ROLE-BASED ACCESS CONTROL)
/// ============================================================================
/// Enum [UserRole] merepresentasikan tipe akun pengguna:
/// - [guest]   : Pengguna baru/tamu (belum mendaftar petani/pembeli).
/// - [petani]  : Mitra petani yang berhak MELELANG hasil panen,
///               tetapi TIDAK BISA membeli/menawar lelang.
/// - [pembeli] : Akun pembeli yang berhak MENGIKUTI lelang (menawar/membeli),
///               tetapi TIDAK BISA melelang barang.
/// ============================================================================
enum UserRole { guest, petani, pembeli }

class UserSession {
  /// [ValueNotifier] mengelola state peran secara reaktif (Bab 5 Modul),
  /// sehingga perubahan peran langsung terdeteksi oleh seluruh UI tanpa restart.
  static final ValueNotifier<UserRole> currentRole =
      ValueNotifier<UserRole>(UserRole.guest);

  /// Status pengecekan peran
  static bool get isPetani => currentRole.value == UserRole.petani;
  static bool get isPembeli => currentRole.value == UserRole.pembeli;
  static bool get isGuest => currentRole.value == UserRole.guest;

  /// Mengatur peran pengguna saat ini
  static void setRole(UserRole role) {
    currentRole.value = role;
  }

  /// Label nama peran yang mudah dibaca
  static String get roleName {
    switch (currentRole.value) {
      case UserRole.petani:
        return 'Petani Terverifikasi';
      case UserRole.pembeli:
        return 'Pembeli Terverifikasi';
      case UserRole.guest:
        return 'Pengguna Umum';
    }
  }
}
