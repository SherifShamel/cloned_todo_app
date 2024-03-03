import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/settings_provider.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.red),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.365,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils().deleteTask(taskModel).then((value) => {
                      EasyLoading.dismiss(),
                      SnackBarService.showSuccessMsg(
                          "Task Deleted Successfully")
                    });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: mediaQuery.width,
          height: mediaQuery.height * 0.19,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: vm.isDark() ? const Color(0xFF141922) : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 80,
                decoration: BoxDecoration(
                  color: taskModel.isDone
                      ? const Color(0xFF61E575)
                      : theme.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      taskModel.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: taskModel.isDone
                            ? const Color(0xFF61E575)
                            : theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      taskModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: taskModel.isDone
                            ? const Color(0xFF61E575)
                            : theme.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 20,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat.yMMMMd().format(taskModel.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              if (taskModel.isDone)
                Text(
                  vm.currentLanguage == "en" ? "Done !" : "تم",
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: const Color(0xFF61E575)),
                ),
              if (!taskModel.isDone)
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    var data = TaskModel(
                        title: taskModel.title,
                        id: taskModel.id,
                        description: taskModel.description,
                        isDone: true,
                        date: taskModel.date);
                    FirebaseUtils().updateTask(data).then((value) {
                      EasyLoading.dismiss();
                    });
                    print("do something");
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
