import 'dart:convert';

class TaskModel {
  int? id;
  String descricao;
  String userId;
  DateTime data;
  bool finalizado;
  TaskModel({
    this.id,
    required this.descricao,
    required this.userId,
    required this.data,
    this.finalizado = false,
  });

  TaskModel copyWith({
    int? id,
    String? descricao,
    String? userId,
    DateTime? data,
    bool? finalizado,
  }) {
    return TaskModel(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      userId: userId ?? this.userId,
      data: data ?? this.data,
      finalizado: finalizado ?? this.finalizado,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'descricao': descricao});
    result.addAll({'user_id': userId});
    result.addAll({'data': data.toIso8601String()});
    result.addAll({'finalizado': finalizado ? 1 : 0});

    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id']?.toInt(),
      descricao: map['descricao'] ?? '',
      userId: map['user_id'] ?? '',
      data: DateTime.parse(map['data']),
      finalizado: map['finalizado']?.toInt() == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, descricao: $descricao, userId: $userId, data: $data, finalizado: $finalizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.descricao == descricao &&
        other.userId == userId &&
        other.data == data &&
        other.finalizado == finalizado;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        userId.hashCode ^
        data.hashCode ^
        finalizado.hashCode;
  }
}
