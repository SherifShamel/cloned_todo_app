class TaskModel {
  String? id;
  String title;
  String description;
  bool isDone;
  DateTime date;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.date,
  });

  factory TaskModel.fromFireStore(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
      );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "date": date.millisecondsSinceEpoch,
    };
  }
}
