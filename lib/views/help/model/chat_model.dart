class ChatModel {
  final int id;
  final String content;
  final User user;
  final FileClass? file;
  final DateTime dateTime;

  ChatModel({
    required this.id,
    required this.content,
    required this.user,
    required this.file,
    required this.dateTime,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        content: json["content"],
        user: User.fromJson(json["user"]),
        dateTime: DateTime.parse(json["date"]),
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
      );
}

class FileClass {
  final int id;
  final String name;
  final String path;

  FileClass({
    required this.id,
    required this.name,
    required this.path,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        id: json["id"],
        name: json["name"],
        path: json["path"],
      );
}

class User {
  final int id;
  final String? name;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ?? "",
        image: json["image"] ?? "",
      );
}
