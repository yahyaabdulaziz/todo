import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/model/tododm.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/widget/my_text_field.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class AppBotomSheet extends StatefulWidget {
  @override
  State<AppBotomSheet> createState() => _AppBotomSheetState();
}

class _AppBotomSheetState extends State<AppBotomSheet> {
  late ListProvider listProvider;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return Container(
      padding: EdgeInsets.all(18),
      height: MediaQuery.of(context).size.height * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          const SizedBox(
            height: 18,
          ),
          MyTextField(
              hintText: "Enter task title", controller: titleController),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
              hintText: "Enter task description",
              controller: descriptionController),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Select date",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: () {
              showMyDatePicker();
            },
            child: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTitleTextStyle
                  .copyWith(fontWeight: FontWeight.normal, color: Colors.grey),
            ),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addTaskToFirestore();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.primary),
              ),
              child: const Text(
                "add",
                style: AppTheme.appBarTextStyle,
              ))
        ],
      ),
    );
  }

  addTaskToFirestore() async {
    CollectionReference tasksCollectionRef = AppUser.collection()
        .doc(AppUser.currentUser!.id)
        .collection(TodosModel.collectionName);
    DocumentReference documentReference = tasksCollectionRef.doc();
    await documentReference.set({
      "id": documentReference.id,
      "title": titleController.text,
      "description": descriptionController.text,
      "date": selectedDate,
      "isDone": false,
    });
    listProvider.refereshTodosList();
    Navigator.pop(context);
  }

  void showMyDatePicker() async {
    /// ?? nulling if press cancel
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}
