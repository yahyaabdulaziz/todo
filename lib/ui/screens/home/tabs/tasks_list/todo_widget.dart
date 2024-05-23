import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/model/tododm.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/edit/edit_screen.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class TodoWidget extends StatelessWidget {
  final TodosModel todosModel;
  late ListProvider provider;

  TodoWidget({super.key, required this.todosModel});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return InkWell(
      onTap: () {
        if (!todosModel.isDone) {
          Navigator.pushNamed(context, EditScreen.routeName,
              arguments: todosModel);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
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
                collectionReference.doc(todosModel.id).delete().then((value) {
                  provider.refreshTodosList();
                });
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ]),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            height: MediaQuery.of(context).size.height * .20,
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 4,
                  color: todosModel.isDone
                      ? AppColors.selectedColor
                      : AppColors.primary,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * .02,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(todosModel.title,
                          style: todosModel.isDone
                              ? AppTheme.doneTitleTextStyle
                              : AppTheme.textTitleTextStyle),
                      Text(todosModel.description,
                          maxLines: 2,
                          style: todosModel.isDone
                              ? AppTheme.doneDescriptionTextStyle
                              : AppTheme.taskDescriptionTextStyle)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    todosModel.isDone
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              if (!todosModel.isDone) {
                                Navigator.pushNamed(
                                    context, EditScreen.routeName,
                                    arguments: todosModel);
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              size: MediaQuery.of(context).size.height * .03,
                              color: Colors.white,
                            )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    todosModel.isDone
                        ? Text(
                            "Done!",
                            style: TextStyle(
                                color: AppColors.selectedColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          )
                        : InkWell(
                            onTap: () {
                              todosModel.isDone = true;
                              provider.updateTask(todosModel);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
