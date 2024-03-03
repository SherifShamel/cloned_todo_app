import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/settings_provider.dart';
import 'package:todo_app/taskBottomSheet.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "layout";

  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: vm.screens[vm.currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => const TaskBottomSheet(),
          );
          // var data = TaskModel(
          //   title: "First Task",
          //   description: "Making my first Task",
          //   isDone: false,
          //   date: DateTime.now(),
          // );
          // FirebaseUtils().addNewTask(data);
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        elevation: 2,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: vm.currentIndex,
          onTap: vm.changeIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: vm.currentLanguage == "en" ? "Tasks" : "المهام",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: vm.currentLanguage == "en" ? "Settings" : "الإعدادات",
            )
          ],
        ),
      ),
    );
  }
}
