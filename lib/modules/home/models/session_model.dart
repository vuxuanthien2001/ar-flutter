class SessionModel {
  final String id;
  final String title;
  final double scalingRatio;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  SessionModel({
    required this.id,
    required this.title,
    required this.scalingRatio,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
        id: json["id"],
        title: json["title"],
        scalingRatio: json["scaling_ratio"],
        imagePath: json["image_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "scaling_ratio": scalingRatio,
        "image_path": imagePath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
