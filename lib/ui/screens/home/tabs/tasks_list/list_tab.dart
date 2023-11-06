import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/tabs/tasks_list/todo_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import '../../../../../model/tododm.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<TodosModel> todos = [];

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      refereshTodosList();
    }

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .14,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                        color: AppColors.primary,
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                        color: AppColors.accent,
                      )),
                ],
              ),
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                dayNameColor: Colors.black,
                monthColor: Colors.white,
                dayColor: Colors.white,
                activeDayColor: Colors.black,
                activeBackgroundDayColor: Colors.white,
                dotsColor: AppColors.transparent,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => TodoWidget(
                    todosmodel: todos[index],
                  )),
        ),
      ],
    );
  }

  refereshTodosList() async {
    CollectionReference<TodosModel> todosCollection = FirebaseFirestore.instance
        .collection(TodosModel.collectionName)
        .withConverter<TodosModel>(fromFirestore: (docsSnapshot, _) {
      Map json = docsSnapshot.data() as Map;
      TodosModel model = TodosModel.fromJson(json);
      return model;
    }, toFirestore: (todoModel, _) {
      return todoModel.toJson();
    });

    /// get > getting lists of tasks
    QuerySnapshot<TodosModel> todoSnapshot = await todosCollection.get();
    List<QueryDocumentSnapshot<TodosModel>> docs = todoSnapshot.docs;

    ///converting json map to TOdoModel
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();
    setState(() {});
  }
}
