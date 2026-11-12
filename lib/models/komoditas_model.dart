import 'package:flutter/material.dart';

/// ============================================================================
/// MODUL 6.2.3: MODEL KATEGORI KOMODITAS (OOP DART - CHAPTER 3.5 & CHAPTER 6)
/// ============================================================================
/// Class [KomoditasModel] menyimpan informasi kategori hasil pertanian.
/// ============================================================================
class KomoditasModel {
  final int? id;
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const KomoditasModel({
    this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
