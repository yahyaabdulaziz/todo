import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/app_user.dart';
import 'package:todo/ui/bottom_sheets/app_bottom_sheet.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/auth/login/login_screen.dart';
import 'package:todo/ui/screens/home/tabs/settings/setting_tab.dart';
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
      body: current_selected_tab == 0 ? ListTab() : const SettingTab(),
      bottomNavigationBar: buildBottomNavi(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildFab() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: AppBotomSheet(),
                  ));
        },
        child: const Icon(
          Icons.add,
        ),
      );

  PreferredSizeWidget buildAppBar() => AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: MediaQuery.of(context).size.height * .12,
        actions: [
          InkWell(
              onTap: () {
                AppUser.currentUser = null;
                provider.todos.clear();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Icon(Icons.logout)),
        ],
        title: const Text(
          "To Do",
          style: AppTheme.appBarTextStyle,
        ),
      );

  Widget buildBottomNavi() => BottomAppBar(
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.hardEdge,
        height: 95,
        child: BottomNavigationBar(
          onTap: (index) {
            current_selected_tab = index;
            setState(() {});
          },
          currentIndex: current_selected_tab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      );
}
