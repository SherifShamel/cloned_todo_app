import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/login/pages/login_view.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/generated/assets.dart';
import 'package:todo_app/settings_provider.dart';

import '../../../core/widgets/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  static const String routeName = 'registerView';
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var fullNameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var testController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: vm.isDark() ? const Color(0xff060E1E) : const Color(0xffDFECDB),
        image: const DecorationImage(
            image: AssetImage(Assets.imgPattern), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: mediaQuery.height * 0.2,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            vm.currentLanguage == "en" ? "Register" : "تسجيل ميل",
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: mediaQuery.height * 0.13,
                      ),
                      Text(
                        vm.currentLanguage == "en" ? "Full Name" : "الإسم كامل",
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      CustomTextField(
                        controller: fullNameController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || value == null) {
                            return vm.currentLanguage == "en"
                                ? "Enter your name please"
                                : "اكتب اسمك هنا يا نجم";
                          }
                        },
                        suffixWidget: Icon(
                          Icons.person,
                          color: theme.primaryColor,
                        ),
                        hint: vm.currentLanguage == "en"
                            ? "Enter your Full Name."
                            : "اكتب الاسم كامل",
                        keyboardType: TextInputType.text,
                        hintColor: Colors.grey,
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
                      Text(
                        vm.currentLanguage == "en" ? "Email" : "الميل",
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      CustomTextField(
                        controller: emailController,
                        onValidate: (value) {
                          var regex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (value!.trim().isEmpty || value == null) {
                            return vm.currentLanguage == "en"
                                ? "Enter an Email please"
                                : "ياعم اكتب الميل هنا";
                          }
                          if (!regex.hasMatch(value)) {
                            return vm.currentLanguage == "en"
                                ? "Invalid Email"
                                : "الميل غلط";
                          }
                          return null;
                        },
                        suffixWidget: Icon(
                          Icons.email_rounded,
                          color: theme.primaryColor,
                        ),
                        hint: vm.currentLanguage == "en"
                            ? "Enter your Email."
                            : "اكتب الميل",
                        keyboardType: TextInputType.emailAddress,
                        hintColor: Colors.grey,
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
                      Text(
                        vm.currentLanguage == "en" ? "Password" : "كلمة السر",
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      CustomTextField(
                        controller: passwordController,
                        onValidate: (value) {
                          var regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value!.trim().isEmpty || value == null) {
                            return vm.currentLanguage == "en"
                                ? "Enter a password please"
                                : "اكتب كلمة السر هنا";
                          }
                          if (!regex.hasMatch(value)) {
                            return vm.currentLanguage == "en"
                                ? "password should contain at least one upper case \n at least one lower case \n at least one digit \n at least one Special character \n Must be at least 8 characters in length"
                                : "كلمة السر لازم تكون انجليزي وفيها حرف كبير عالاقل\n وحرف صغير عالاقل\n ورقم ورمز\n و 8 حروف";
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        maxLines: 1,
                        hint: vm.currentLanguage == "en"
                            ? "Enter your Password."
                            : "اكتب كلمة السر هنا",
                      ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      Text(
                        vm.currentLanguage == "en"
                            ? "Confirm Password"
                            : "نفس كلمة السر",
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      CustomTextField(
                        controller: confirmPasswordController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || value == null) {
                            return vm.currentLanguage == "en"
                                ? "Enter a password please"
                                : "كلمة السير التانية هنا";
                          }

                          if (value != passwordController.text) {
                            return vm.currentLanguage == "en"
                                ? "Password doesn't match"
                                : "لا مش هي هي";
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        maxLines: 1,
                        hint: vm.currentLanguage == "en"
                            ? "Confirm your Password."
                            : "أكد كلمة السر",
                      ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(theme.primaryColor)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseUtils()
                                .createUserWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            )
                                .then((value) {
                              if (value == true) {
                                EasyLoading.dismiss();
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginView.routeName,
                                );
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Register", style: theme.textTheme.bodyMedium),
                            Icon(
                              Icons.chevron_right,
                              color: theme.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
