class PlayerModel {
  String? name;
  String? socketId;
  double? points;
  String? playerType;

  PlayerModel({
    this.name,
    this.socketId,
    this.points,
    this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      name: map['name'],
      socketId: map['socketId'],
      points: map['points'],
      playerType: map['playerType'],
    );
  }

  PlayerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    socketId = json['socketId'];
    points = json['points'];
    playerType = json['playerType'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  PlayerModel copyWith({
    String? name,
    String? socketId,
    double? points,
    String? playerType,
  }) {
    return PlayerModel(
      name: name ?? this.name,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
