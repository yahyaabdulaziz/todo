import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/tododm.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "editTaskScreen";

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TodosModel model = ModalRoute.of(context)?.settings.arguments as TodosModel;
    var listprovider = Provider.of<ListProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              AppBar(
                flexibleSpace: const SizedBox(height: 180),
                backgroundColor: AppColors.primary,
                toolbarHeight: MediaQuery.of(context).size.height * .12,
                title: Text(
                  "Edit ( ${model.title} ) Task",
                  style: AppTheme.appBarTextStyle,
                ),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 120, left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Edit Task",
                      textAlign: TextAlign.center,
                      style: AppTheme.bottomSheetTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      initialValue: model.title,
                      decoration:
                          const InputDecoration(hintText: "Enter title "),
                      onChanged: (value) {
                        model.title = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: model.description,
                      onChanged: (value) {
                        model.description = value;
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter description "),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Text(
                        "Select date",
                        textAlign: TextAlign.start,
                        style: AppTheme.bottomSheetTitleTextStyle
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        showMyDatePicker(model);
                      },
                      child: Text(
                        "${model.date.day}/${model.date.month}/${model.date.year}",
                        textAlign: TextAlign.center,
                        style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      child: ElevatedButton(
                          onPressed: () {
                            listprovider.updateTask(model);
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.roueName);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primary),
                          ),
                          child: const Text(
                            "Save Changes",
                            style: AppTheme.appBarTextStyle,
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void showMyDatePicker(TodosModel todosModel) async {
    /// ?? nulling if press cancel
    todosModel.date = await showDatePicker(
            context: context,
            initialDate: todosModel.date,
            firstDate: todosModel.date,
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        todosModel.date;
    setState(() {});
  }
}
