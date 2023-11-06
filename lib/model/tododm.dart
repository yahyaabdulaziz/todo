import 'package:cloud_firestore/cloud_firestore.dart';

class TodosModel {
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;
  static const String collectionName = "Tasks";

  TodosModel(this.id, this.title, this.description, this.date, this.isDone);

  TodosModel.fromJson(Map json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp time = json["date"];
    date = time.toDate();
    isDone = json["isDone"];
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone
    };
  }
}
