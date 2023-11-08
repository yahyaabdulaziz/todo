import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/model/tododm.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/edit/edit_screen.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoWidget extends StatelessWidget {
  final TodosModel todosmodel;
  late ListProvider provider;

  TodoWidget({super.key, required this.todosmodel});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditScreen.routeName,
            arguments: todosmodel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Slidable(
          startActionPane:
              ActionPane(motion: StretchMotion(), extentRatio: .29, children: [
            SlidableAction(
              onPressed: (_) {
                CollectionReference collectionReference =
                    AppUser.getCurrentUserTodosCollection();
                collectionReference.doc(todosmodel.id).delete().then((value) {
                  provider.refereshTodosList();
                });
              },
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
                VerticalDivider(
                  thickness: 4,
                  color: todosmodel.isDone
                      ? AppColors.selectedColor
                      : AppColors.primary,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(todosmodel.title,
                          style: todosmodel.isDone
                              ? AppTheme.doneTitleTextStyle
                              : AppTheme.textTitleTextStyle),
                      Text(todosmodel.description,
                          style: todosmodel.isDone
                              ? AppTheme.doneDescriptionTextStyle
                              : AppTheme.taskDescriptionTextStyle)
                    ],
                  ),
                ),
                todosmodel.isDone
                    ? Text(
                        "Done!",
                        style: TextStyle(
                            color: AppColors.selectedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    : InkWell(
                        onTap: () {
                          todosmodel.isDone = true;
                          provider.updateTask(todosmodel);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.primary,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            )),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
