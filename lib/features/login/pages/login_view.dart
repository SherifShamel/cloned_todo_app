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
                      Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: mediaQuery.height * 0.2),
                      Text(
                        "Welcome Back",
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Email",
                        style: theme.textTheme.bodySmall,
                      ),
                      CustomTextField(
                        controller: emailController,
                        onValidate: (value) {
                          var regex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (value!.trim().isEmpty || value == null) {
                            return "Enter an Email please";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                        suffixWidget: const Icon(Icons.email_rounded),
                        hint: "Enter your Email.",
                        keyboardType: TextInputType.emailAddress,
                        hintColor: Colors.grey.shade700,
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
                      Text(
                        "Password",
                        style: theme.textTheme.bodySmall,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || value == null) {
                            return "Enter your Password please";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        maxLines: 1,
                        hint: "Enter your Password.",
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
                            Text("Login", style: theme.textTheme.bodyMedium),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                      Text(
                        "OR",
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.routeName);
                        },
                        child: Text("Create New Account !",
                            style: theme.textTheme.bodyMedium),
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