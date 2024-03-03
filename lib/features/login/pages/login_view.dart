import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/custom_text_field.dart';
import 'package:todo_app/features/register/pages/register_view.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/generated/assets.dart';
import 'package:todo_app/layout_view.dart';
import 'package:todo_app/settings_provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  var _formKey = GlobalKey<FormState>();
  static const String routeName = "loginView";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: vm.currentTheme == ThemeMode.dark
            ? const Color(0xff060E1E)
            : const Color(0xffDFECDB),
        image: const DecorationImage(
            image: AssetImage(Assets.imgPattern), fit: BoxFit.cover),
      ),
      child: Scaffold(
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
                      SizedBox(height: mediaQuery.height * 0.1),
                      Text(vm.currentLanguage == "en" ? "Login" : "خش هتجيبك",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge),
                      SizedBox(height: mediaQuery.height * 0.2),
                      Text(
                        vm.currentLanguage == "en"
                            ? "Welcome Back"
                            : "خش برجلك اليمين",
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 40),
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
                                : "شكلك نسيت الميل";
                          }
                          if (!regex.hasMatch(value)) {
                            return vm.currentLanguage == "en"
                                ? "Invalid Email"
                                : "غلط يا غالي";
                          }
                          return null;
                        },
                        suffixWidget: Icon(
                          Icons.email_rounded,
                          color: theme.primaryColor,
                        ),
                        hint: vm.currentLanguage == "en"
                            ? "Enter your Email."
                            : "دخل الميل هنا",
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
                          if (value!.trim().isEmpty || value == null) {
                            return vm.currentLanguage == "en"
                                ? "Enter your Password please"
                                : "دخل كلمة السر يا عم";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        maxLines: 1,
                        hint: vm.currentLanguage == "en"
                            ? "Enter your Password."
                            : "دخل كلمة السر",
                      ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(theme.primaryColor)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseUtils()
                                .signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            )
                                .then((value) {
                              if (value == true) {
                                EasyLoading.dismiss();
                                Navigator.pushReplacementNamed(
                                    context, LayoutView.routeName);
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vm.currentLanguage == "en" ? "Login" : "خش",
                                style: theme.textTheme.bodyMedium),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      Text(
                        vm.currentLanguage == "en" ? "OR" : "أو",
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.routeName);
                        },
                        child: Text(
                            vm.currentLanguage == "en"
                                ? "Create New Account !"
                                : "اعمل ميل جديد",
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    vm.isDark() ? Colors.white : Colors.black)),
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
