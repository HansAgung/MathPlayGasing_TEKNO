class MateriModel {
  final String judulMateri;
  final String deskripsiMateri;
  final int progress;
  final bool isLocked;
  final bool isSubscribe;

  MateriModel({
    required this.judulMateri,
    required this.deskripsiMateri,
    required this.progress,
    required this.isLocked,
    required this.isSubscribe,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      judulMateri: json['data']['judul_materi'],
      deskripsiMateri: json['data']['deskripsi_materi'],
      progress: json['progress'],
      isLocked: json['is_locked'],
      isSubscribe: json['is_subscribe'],
    );
  }
}
