import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/tabs/tasks_list/todo_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo/ui/utilities/app_colors.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
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
              itemCount: 12, itemBuilder: (context, index) => TodoWidget()),
        ),
      ],
    );
  }
}
