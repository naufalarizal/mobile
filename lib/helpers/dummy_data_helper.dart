import 'package:flutter/material.dart';
import '../models/lelang_model.dart';
import '../models/proyek_model.dart';
import '../models/komoditas_model.dart';
import '../models/transaksi_model.dart';

/// ============================================================================
/// MODUL 6.2.2: HELPER PENGELOLAAN DATA (CHAPTER 3.3.10 COLLECTIONS & CHAPTER 6)
/// ============================================================================
/// Class [DummyDataHelper] menyediakan data koleksi (List) awal untuk aplikasi.
/// Memisahkan sumber data dari layer tampilan UI agar kode lebih terstruktur,
/// rapi, modular, dan mudah dipahami (sesuai kaidah Bab 6.2.2 pada Modul).
/// ============================================================================
class DummyDataHelper {
  /// Daftar kategori komoditas pertanian
  static List<KomoditasModel> getKomoditasList() {
    return const [
      KomoditasModel(
        name: 'Sayuran',
        icon: Icons.eco_rounded,
        iconColor: Color(0xFF2E7D32),
        bgColor: Color(0xFFE8F5E9),
      ),
      KomoditasModel(
        name: 'Buah',
        icon: Icons.local_florist_rounded,
        iconColor: Color(0xFFE65100),
        bgColor: Color(0xFFFFF3E0),
      ),
      KomoditasModel(
        name: 'Palawija',
        icon: Icons.grain_rounded,
        iconColor: Color(0xFF6D4C41),
        bgColor: Color(0xFFEFEBE9),
      ),
      KomoditasModel(
        name: 'Perkebunan',
        icon: Icons.water_drop_rounded,
        iconColor: Color(0xFF00695C),
        bgColor: Color(0xFFE0F2F1),
      ),
    ];
  }

  /// Daftar item lelang hasil panen yang sedang berlangsung
  static List<LelangModel> getLelangBerlangsungList() {
    return const [
      LelangModel(
        id: 1,
        title: 'Beras Premium Cianjur',
        weight: '250 Kg',
        currentBid: 'Rp 3.200.000',
        startPrice: 'Rp 2.950.000',
        timeLeft: '01:24:38',
        location: 'Cianjur, Jawa Barat',
        seller: 'Poktan Sari Tani',
        imagePath: 'assets/images/commodity_beras.jpg',
        themeColor: Colors.green,
      ),
      LelangModel(
        id: 2,
        title: 'Cabai Merah Keriting',
        weight: '100 Kg',
        currentBid: 'Rp 850.000',
        startPrice: 'Rp 720.000',
        timeLeft: '00:48:12',
        location: 'Temanggung, Jawa Tengah',
        seller: 'Pak Slamet Riyadi',
        imagePath: 'assets/images/commodity_cabai.jpg',
        themeColor: Colors.red,
      ),
      LelangModel(
        id: 3,
        title: 'Jagung Pipil Kering',
        weight: '500 Kg',
        currentBid: 'Rp 1.750.000',
        startPrice: 'Rp 1.600.000',
        timeLeft: '03:10:00',
        location: 'Grobogan, Jawa Tengah',
        seller: 'Kelompok Tani Makmur',
        imagePath: 'assets/images/commodity_jagung.jpg',
        themeColor: Colors.orange,
      ),
    ];
  }

  /// Daftar proyek pendanaan / investasi panen tayang
  static List<ProyekModel> getProyekPanenList() {
    return const [
      ProyekModel(
        id: 1,
        title: 'Padi Organik Ciherang',
        location: 'Subang, Jawa Barat',
        targetDana: 'Rp 45.000.000',
        progress: 0.72,
        progressPercentage: '72%',
        roiRange: '14 - 16%',
      ),
      ProyekModel(
        id: 2,
        title: 'Jagung Hibrida Bisi-18',
        location: 'Grobogan, Jawa Tengah',
        targetDana: 'Rp 60.000.000',
        progress: 0.48,
        progressPercentage: '48%',
        roiRange: '16 - 19%',
      ),
      ProyekModel(
        id: 3,
        title: 'Cabai Rawit Merah Prima',
        location: 'Kediri, Jawa Timur',
        targetDana: 'Rp 30.000.000',
        progress: 0.88,
        progressPercentage: '88%',
        roiRange: '18 - 22%',
      ),
    ];
  }

  /// Daftar riwayat transaksi pengguna
  static List<TransaksiModel> getTransaksiList() {
    return const [
      TransaksiModel(
        id: 1,
        title: 'Penjualan Beras Pandan Wangi 300 Kg',
        code: 'TRX-LEL-20261108-01',
        date: '08 Nov 2026 • 14:30 WIB',
        amount: '+ Rp 4.200.000',
        status: 'Selesai',
        statusColor: Color(0xFF258149),
        isIncome: true,
      ),
      TransaksiModel(
        id: 2,
        title: 'Hasil Dividen Proyek Padi Ciherang',
        code: 'TRX-INV-20261105-14',
        date: '05 Nov 2026 • 10:15 WIB',
        amount: '+ Rp 850.000',
        status: 'Selesai',
        statusColor: Color(0xFF258149),
        isIncome: true,
      ),
      TransaksiModel(
        id: 3,
        title: 'Penarikan Saldo ke BRI (9812)',
        code: 'WD-20261102-09',
        date: '02 Nov 2026 • 09:00 WIB',
        amount: '- Rp 3.000.000',
        status: 'Diproses',
        statusColor: Colors.orange,
        isIncome: false,
      ),
      TransaksiModel(
        id: 4,
        title: 'Penjualan Jagung Pipil Kering 500 Kg',
        code: 'TRX-LEL-20261028-22',
        date: '28 Okt 2026 • 16:45 WIB',
        amount: '+ Rp 1.750.000',
        status: 'Selesai',
        statusColor: Color(0xFF258149),
        isIncome: true,
      ),
    ];
  }
}
