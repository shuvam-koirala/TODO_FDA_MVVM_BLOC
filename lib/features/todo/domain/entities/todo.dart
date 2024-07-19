class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  Todo(
      {required this.id,
      required this.description,
      required this.title,
      required this.isCompleted});

  Todo copyWith(
      {String? id, String? title, String? description, bool? isCompleted}) {
    return Todo(
        id: id ?? this.id,
        description: description ?? this.description,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted);
  }
}
