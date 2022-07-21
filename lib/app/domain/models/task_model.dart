import 'dart:convert';

class TaskModel {
  int? id;
  String descricao;
  DateTime data;
  bool finalizado;
  TaskModel({
    this.id,
    required this.descricao,
    required this.data,
    this.finalizado = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'descricao': descricao});
    result.addAll({'data_hora': data.toIso8601String()});
    result.addAll({'finalizado': finalizado ? 1 : 0});

    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id']?.toInt(),
      descricao: map['descricao'] ?? '',
      data: DateTime.parse(map['data_hora']),
      finalizado: map['finalizado']?.toInt() == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, descricao: $descricao, data: $data, finalizado: $finalizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.descricao == descricao &&
        other.data == data &&
        other.finalizado == finalizado;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        data.hashCode ^
        finalizado.hashCode;
  }
}
