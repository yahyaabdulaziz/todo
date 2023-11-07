import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/home/tabs/tasks_list/todo_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import '../../../../../model/tododm.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listProvider.refereshTodosList();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
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
                initialDate: listProvider.selectedDay,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) {
                  listProvider.selectedDay = date;
                  listProvider.refereshTodosList();
                },
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
              itemCount: listProvider.todos.length,
              itemBuilder: (context, index) => TodoWidget(
                    todosmodel: listProvider.todos[index],
                  )),
        ),
      ],
    );
  }
}
