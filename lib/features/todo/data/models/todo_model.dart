class TodoModel {
  final String id;
  final String description;
  final String title;
  final bool isCompleted;

  TodoModel(
      {required this.description,
      required this.id,
      required this.title,
      required this.isCompleted});

  //methods to convert to and from json.
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        description: json["description"],
        id: json["id"],
        title: json["title"],
        isCompleted: json["isCompleted"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desciption": description,
      "isCompleted": isCompleted
    };
  }
}
