import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/model/tododm.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/notification/notifi_service.dart';
import 'package:todo/ui/screens/widget/my_text_field.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late ListProvider listProvider;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    NotificationService().initNotification();
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return Container(
      color: AppColors.grey,
      padding: const EdgeInsets.all(18),
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
              onPressed: () async {
                await NotificationService().showNotification(
                    title: titleController.text,
                    body: descriptionController.text);
                addTaskToFirestore(context);
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

  addTaskToFirestore(BuildContext context) async {
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

    listProvider.refreshTodosList();
    Navigator.pop(context);
  }

  void showMyDatePicker() async {
    /// ?? nulling if press cancel
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}
