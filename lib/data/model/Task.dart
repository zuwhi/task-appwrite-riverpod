import 'dart:convert';

class Task {
  String? id;
  String? title;
  String? desc;
  String? date;
  dynamic category;
  bool? isDone;
  Task({
    this.id,
    this.title,
    this.desc,
    this.date,
    required this.category,
    this.isDone,
  });


  Task copyWith({
    String? id,
    String? title,
    String? desc,
    String? date,
    dynamic? category,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      date: date ?? this.date,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
      'category': category,
      'isDone': isDone,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      category: map['category'] as dynamic,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);
    Task.fromJson(Map<String, dynamic> json) {
    id = json['\$id'];
    title = json['title'];
    desc = json['desc'];
    date = json['date'];
    category = json['category'];
    isDone = json['isDone'];
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, desc: $desc, date: $date, category: $category, isDone: $isDone)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.desc == desc &&
      other.date == date &&
      other.category == category &&
      other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      desc.hashCode ^
      date.hashCode ^
      category.hashCode ^
      isDone.hashCode;
  }
}


// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class UserFields {
//   static const String id = "\$id";
//   static const String title = "title";
//   static const String subtitle = "subtitle";
// }

// class Todo {
//   String? id;
//   String? title;
//   String? subtitle;

//   Todo({
//     this.id,
//     this.title,
//     this.subtitle,
//   });

//   Todo.fromJson(Map<String, dynamic> json) {
//     id = json[UserFields.id];
//     title = json[UserFields.title];
//     subtitle = json[UserFields.subtitle];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data[UserFields.id] = id;
//     data[UserFields.title] = title;
//     data[UserFields.subtitle] = subtitle;
//     return data;
//   }

//   Todo copyWith({
//     String? id,
//     String? title,
//     String? subtitle,
//   }) {
//     return Todo(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       subtitle: subtitle ?? this.subtitle,
//     );
//   }
// }
// class Todo {
//   String? id;
//   String? title;
//   String? subtitle;

//   Todo({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//   });

//   Todo copyWith({
//     String? id,
//     String? title,
//     String? subtitle,
//   }) {
//     return Todo(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       subtitle: subtitle ?? this.subtitle,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'title': title,
//       'subtitle': subtitle,
//     };
//   }

//   factory Todo.fromMap(Map<String, dynamic> map) {
//     return Todo(
//       id: map['id'] != null ? map['id'] as String : null,
//       title: map['title'] != null ? map['title'] as String : null,
//       subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Todo(id: $id, title: $title, subtitle: $subtitle)';

//   @override
//   bool operator ==(covariant Todo other) {
//     if (identical(this, other)) return true;

//     return
//       other.id == id &&
//       other.title == title &&
//       other.subtitle == subtitle;
//   }

//   @override
//   int get hashCode => id.hashCode ^ title.hashCode ^ subtitle.hashCode;
// }

// class UserFields {
//   static const String id = "\$id";
//   static const String title = "title";
//   static const String subtitle = "subtitle";
// }


