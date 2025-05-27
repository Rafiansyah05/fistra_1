// lib/mitra_model.dart
class Mitra {
  final String id;
  final String name;
  final String logoAssetPath;
  final String? description;
  // Tambahkan field untuk header image jika ingin spesifik per mitra
  // final String? headerImageAssetPath;

  Mitra({
    required this.id,
    required this.name,
    required this.logoAssetPath,
    this.description,
    // this.headerImageAssetPath,
  });
}
