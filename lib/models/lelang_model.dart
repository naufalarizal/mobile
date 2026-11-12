import 'package:flutter/material.dart';

/// ============================================================================
/// MODUL 6.2.3: MODEL DATA (OOP DART - CHAPTER 3.5 & CHAPTER 6)
/// ============================================================================
/// Class [LelangModel] merepresentasikan data komoditas lelang dalam aplikasi.
/// Menerapkan prinsip Object Oriented Programming (OOP) Dart:
/// - Enkapsulasi data melalui atribut/fields bertipe spesifik (Statically Typed).
/// - Constructor untuk inisialisasi objek.
/// - Metode [toMap] dan [fromMap] untuk konversi data (sesuai Bab 6.2.3 Modul).
/// ============================================================================
class LelangModel {
  final int? id;
  final String title;
  final String weight;
  final String currentBid;
  final String startPrice;
  final String timeLeft;
  final String location;
  final String seller;
  final String imagePath;
  final Color themeColor;

  /// Constructor dengan named parameters dan required fields
  const LelangModel({
    this.id,
    required this.title,
    required this.weight,
    required this.currentBid,
    required this.startPrice,
    required this.timeLeft,
    required this.location,
    required this.seller,
    required this.imagePath,
    this.themeColor = const Color(0xFF258149),
  });

  /// Mengonversi objek [LelangModel] ke dalam bentuk `Map<String, dynamic>`
  /// (Digunakan untuk keperluan penyimpanan database lokal / SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'weight': weight,
      'currentBid': currentBid,
      'startPrice': startPrice,
      'timeLeft': timeLeft,
      'location': location,
      'seller': seller,
      'imagePath': imagePath,
    };
  }

  /// Factory constructor untuk membuat objek [LelangModel] dari Map
  factory LelangModel.fromMap(Map<String, dynamic> map) {
    return LelangModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      weight: map['weight'] as String,
      currentBid: map['currentBid'] as String,
      startPrice: map['startPrice'] as String,
      timeLeft: map['timeLeft'] as String,
      location: map['location'] as String,
      seller: map['seller'] as String,
      imagePath: map['imagePath'] as String,
    );
  }
}
