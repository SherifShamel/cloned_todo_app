import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/core/utils/extract_date_time.dart';
import 'package:todo_app/core/widgets/custom_text_field.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/settings_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      width: mediaQuery.width,
      decoration: BoxDecoration(
        color: vm.isDark() ? const Color(0xff060E1E) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              vm.currentLanguage == "en" ? "Add A New Task" : "احفظ مهمة جديدة",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: titleController,
              onValidate: (value) {
                if (value!.isEmpty || value == null) {
                  return vm.currentLanguage == "en"
                      ? "You Must Enter Task Title !"
                      : "يجب ادخل عنوان للمهمة";
                }
              },
              hint: vm.currentLanguage == "en"
                  ? "Enter your Task Title"
                  : "ادخل عنوان المهمة",
              hintColor: Colors.grey.shade700,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: descriptionController,
              onValidate: (value) {
                if (value!.isEmpty || value == null) {
                  return vm.currentLanguage == "en"
                      ? "You Must Enter Task Description !"
                      : "يجب ادخل محتوى للمهمة";
                }
              },
              hint: vm.currentLanguage == "en"
                  ? "Enter your Task Description"
                  : "ادخل محتوى المهمة",
              hintColor: Colors.grey.shade700,
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            Text(
              vm.currentLanguage == "en" ? "Select Time" : "ادخل وقت للمهمة",
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                vm.selectTaskDate(context);
              },
              child: Text(
                DateFormat.yMMMd().format(vm.selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.black),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var data = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    isDone: false,
                    date: extractDateTime(vm.selectedDate),
                  );
                  EasyLoading.show();
                  FirebaseUtils().addNewTask(data).then((value) {
                    EasyLoading.dismiss();
                    Navigator.pop(context);
                    SnackBarService.showSuccessMsg(vm.currentLanguage == "en"
                        ? "Task successfully created"
                        : "تم إضافةالمهمة");
                  });
                }
              },
              child: Text(
                vm.currentLanguage == "en" ? "Add Task" : "مهمة جديدة",
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              )),
            )
          ],
        ),
      ),
    );
  }
}
