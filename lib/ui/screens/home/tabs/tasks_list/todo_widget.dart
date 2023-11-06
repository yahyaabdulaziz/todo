import 'package:flutter/material.dart';
import 'package:todo/model/tododm.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoWidget extends StatelessWidget {
  final TodosModel todosmodel;

  const TodoWidget({super.key, required this.todosmodel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Slidable(
        startActionPane:
            ActionPane(motion: StretchMotion(), extentRatio: .29, children: [
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
          height: MediaQuery.of(context).size.height * .14,
          child: Row(
            children: [
              const VerticalDivider(),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      todosmodel.title,
                      style: AppTheme.textTitleTextStyle,
                    ),
                    Text(
                      todosmodel.description,
                      style: AppTheme.taskDescriptionTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
