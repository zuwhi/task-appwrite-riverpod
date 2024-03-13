// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:appwrite_todo/data/model/Task.dart';

class Category {
  String? id;
  String? name;
  int? total;
  int? doneTotal;
  List? tasks;
  Category({
    this.id,
    this.name,
    this.total,
    this.doneTotal,
    this.tasks,
  });

  Category copyWith({
    String? id,
    String? name,
    int? total,
    int? doneTotal,
    List<Task>? tasks,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      total: total ?? this.total,
      doneTotal: doneTotal ?? this.doneTotal,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'total': total,
      'doneTotal': doneTotal,
      'tasks': tasks!.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      total: map['total'] != null ? map['total'] as int : null,
      doneTotal: map['doneTotal'] != null ? map['doneTotal'] as int : null,
      tasks: map['tasks'] != null
          ? List<Task>.from(
              (map['tasks'] as List<int>).map<Task?>(
                (x) => Task.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Category.fromJson(String source) =>
  //     Category.fromMap(json.decode(source) as Map<String, dynamic>);

  Category.fromJson(Map<String, dynamic> json) {
    id = json['\$id'];
    name = json['name'];
    total = json['total'];
    doneTotal = json['doneTotal'];
    tasks = json['tasks'];
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, total: $total, doneTotal: $doneTotal, tasks: $tasks)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.total == total &&
        other.doneTotal == doneTotal &&
        listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        total.hashCode ^
        doneTotal.hashCode ^
        tasks.hashCode;
  }
}
