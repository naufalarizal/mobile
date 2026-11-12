import 'package:flutter/material.dart';

/// ============================================================================
/// MODUL 6.2.3: MODEL RIWAYAT TRANSAKSI (OOP DART - CHAPTER 3.5 & CHAPTER 6)
/// ============================================================================
/// Menyimpan data riwayat transaksi hasil lelang dan investasi.
/// ============================================================================
class TransaksiModel {
  final int? id;
  final String title;
  final String code;
  final String date;
  final String amount;
  final String status;
  final Color statusColor;
  final bool isIncome;

  const TransaksiModel({
    this.id,
    required this.title,
    required this.code,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'date': date,
      'amount': amount,
      'status': status,
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory TransaksiModel.fromMap(Map<String, dynamic> map) {
    return TransaksiModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      code: map['code'] as String,
      date: map['date'] as String,
      amount: map['amount'] as String,
      status: map['status'] as String,
      statusColor: map['isIncome'] == 1 ? const Color(0xFF258149) : Colors.orange,
      isIncome: map['isIncome'] == 1,
    );
  }
}
