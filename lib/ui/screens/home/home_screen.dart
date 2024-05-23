import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/ui/bottom_sheets/app_bottom_sheet.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/auth/login/login_screen.dart';
import 'package:todo/ui/screens/home/tabs/tasks_list/list_tab.dart';
import 'package:todo/ui/utilities/app_colors.dart';
import 'package:todo/ui/utilities/app_theme.dart';

class HomeScreen extends StatefulWidget {
  static const roueName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current_selected_tab = 0;
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: ListTab(),
      //bottomNavigationBar: buildBottomNavi(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildFab() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: AppBottomSheet(),
                  ));
        },
        child: Icon(
          Icons.add,
          size: MediaQuery.of(context).size.height * .05,
        ),
      );

  PreferredSizeWidget buildAppBar() => AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * .12,
        actions: [
          InkWell(
              onTap: () {
                AppUser.currentUser = null;
                provider.todos.clear();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))),
        ],
        title: const Text(
          "ToDo Master",
          style: AppTheme.appBarTextStyle,
        ),
      );
}
