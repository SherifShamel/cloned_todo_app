import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/extract_date_time.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/settings_provider.dart';

import '../widgets/task_item_widget.dart';

class TasksView extends StatefulWidget {
  TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Stack(
            alignment: const Alignment(0.0, 2.0),
            children: [
              Container(
                width: mediaQuery.width,
                height: mediaQuery.height * 0.22,
                color: theme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Text(
                  vm.currentLanguage == "en" ? "To Do List" : "المهمات",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              EasyInfiniteDateTimeLine(
                firstDate: DateTime(2024),
                focusDate: _focusDate,
                lastDate: DateTime(2024, 12, 31),
                onDateChange: (selectedDate) {
                  setState(() {
                    _focusDate = selectedDate;
                    vm.selectedDate = _focusDate;
                  });
                },
                timeLineProps: const EasyTimeLineProps(separatorPadding: 15.0),
                showTimelineHeader: false,
                locale: vm.currentLanguage == "en" ? "en" : "ar",
                dayProps: EasyDayProps(
                  height: 100,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: vm.isDark()
                            ? const Color(0xFF141922)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey.shade500)),
                    dayStrStyle: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.primaryColor),
                    monthStrStyle: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.primaryColor),
                    dayNumStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.primaryColor),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color:
                          vm.isDark() ? const Color(0xFF141922) : Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black),
                    monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black),
                    dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseUtils().getStreamDataFromFireStore(
            vm.selectedDate,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(snapshot.error.toString()),
                  const Icon(Icons.refresh),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var tasksList = snapshot.data?.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList() ??
                [];

            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    TaskItemWidget(taskModel: tasksList[index]),
                itemCount: tasksList.length,
              ),
            );
          },
        ),
        /*FutureBuilder<List<TaskModel>>(
          future: FirebaseUtils().getDataFromFireStore(
            vm.selectedDate,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(snapshot.error.toString()),
                  const Icon(Icons.refresh),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var tasksList = snapshot.data ?? [];

            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    TaskItemWidget(taskModel: tasksList[index]),
                itemCount: tasksList.length,
              ),
            );
          },
        ),*/
      ],
    );
  }
}
