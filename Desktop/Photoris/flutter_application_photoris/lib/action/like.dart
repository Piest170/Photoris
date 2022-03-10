class LikeModel {
  late String? id;
  late String? uid;
  late String? photographerId;
  late String? type;

  LikeModel({
    this.id,
    this.uid,
    this.photographerId,
    this.type,
  });

  factory LikeModel.fromJSON(dynamic json) {
    return LikeModel(
      id: json["id"],
      uid: json["uid"],
      photographerId: json["photographerId"],
      type: json["type"],
    );
  }
}
