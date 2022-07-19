import 'dart:convert';

class TodoModel {
  int? id;
  String descricao;
  DateTime data;
  int finalizado;
  TodoModel({
    this.id,
    required this.descricao,
    required this.data,
    this.finalizado = 0,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'descricao': descricao});
    result.addAll({'data_hora': data.toIso8601String()});
    result.addAll({'finalizado': finalizado});

    return result;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt(),
      descricao: map['descricao'] ?? '',
      data: DateTime.parse(map['data_hora']),
      finalizado: map['finalizado']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoModel(id: $id, descricao: $descricao, data: $data, finalizado: $finalizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
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
