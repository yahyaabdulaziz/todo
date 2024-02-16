import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/model/tododm.dart';

class ListProvider extends ChangeNotifier {
  List<TodosModel> todos = [];
  DateTime selectedDay = DateTime.now();

  refereshTodosList() async {
    CollectionReference<TodosModel> todosCollection = AppUser.collection()
        .doc(AppUser.currentUser!.id)
        .collection(TodosModel.collectionName)
        .withConverter<TodosModel>(fromFirestore: (docsSnapshot, _) {
      Map json = docsSnapshot.data() as Map;
      TodosModel model = TodosModel.fromJson(json);
      return model;
    }, toFirestore: (todoModel, _) {
      return todoModel.toJson();
    });

    /// get > getting lists of tasks
    QuerySnapshot<TodosModel> todoSnapshot = await todosCollection
        //.where("date", isEqualTo: selectedDay)
        .orderBy("date")
        .get();
    List<QueryDocumentSnapshot<TodosModel>> docs = todoSnapshot.docs;

    ///converting json map to TOdoModel
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

    ///Better Solution
    todos = todos.where((todo) {
      if (todo.date.day != selectedDay.day ||
          todo.date.month != selectedDay.month ||
          todo.date.year != selectedDay.year) {
        return false;
      } else {
        return true;
      }
    }).toList();
    notifyListeners();
  }

  updateTask(TodosModel upmodel) {
    CollectionReference collectionReference =
        AppUser.getCurrentUserTodosCollection();
    collectionReference.doc(upmodel.id).update(upmodel.toJson()).then((value) {
      refereshTodosList();
      notifyListeners();
    });
  }
}
