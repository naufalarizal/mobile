/// ============================================================================
/// MODUL 6.2.3: MODEL DATA PROYEK PANEN (OOP DART - CHAPTER 3.5 & CHAPTER 6)
/// ============================================================================
/// Class [ProyekModel] merepresentasikan data pendanaan investasi panen tani.
/// Menerapkan prinsip Object Oriented Programming (OOP) Dart:
/// - Attributes/fields dengan tipe data spesifik (double, String).
/// - Constructor untuk inisialisasi objek.
/// - Metode konversi [toMap] dan [fromMap].
/// ============================================================================
class ProyekModel {
  final int? id;
  final String title;
  final String location;
  final String targetDana;
  final double progress; // Nilai 0.0 sampai 1.0 untuk LinearProgressIndicator
  final String progressPercentage;
  final String roiRange;

  const ProyekModel({
    this.id,
    required this.title,
    required this.location,
    required this.targetDana,
    required this.progress,
    required this.progressPercentage,
    required this.roiRange,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'targetDana': targetDana,
      'progress': progress,
      'progressPercentage': progressPercentage,
      'roiRange': roiRange,
    };
  }

  factory ProyekModel.fromMap(Map<String, dynamic> map) {
    return ProyekModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      location: map['location'] as String,
      targetDana: map['targetDana'] as String,
      progress: (map['progress'] as num).toDouble(),
      progressPercentage: map['progressPercentage'] as String,
      roiRange: map['roiRange'] as String,
    );
  }
}
