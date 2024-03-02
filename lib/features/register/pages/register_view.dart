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
        color: vm.currentTheme == ThemeMode.dark
            ? const Color(0xff060E1E)
            : const Color(0xffDFECDB),
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
            "Register",
            style: theme.textTheme.titleLarge,
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
                        "Full Name",
                        style: theme.textTheme.bodySmall,
                      ),
                      CustomTextField(
                        controller: fullNameController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || value == null) {
                            return "Enter your name please";
                          }
                        },
                        suffixWidget: const Icon(Icons.person),
                        hint: "Enter your Full Name.",
                        keyboardType: TextInputType.text,
                        hintColor: Colors.grey.shade700,
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
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
                          var regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value!.trim().isEmpty || value == null) {
                            return "Enter a password please";
                          }
                          if (!regex.hasMatch(value)) {
                            return "password should contain at least one upper case \n at least one lower case \n at least one digit \n at least one Special character \n Must be at least 8 characters in length";
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        maxLines: 1,
                        hint: "Enter your Password.",
                      ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      Text(
                        "Confirm Password",
                        style: theme.textTheme.bodySmall,
                      ),
                      CustomTextField(
                        controller: confirmPasswordController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || value == null) {
                            return "Enter a password please";
                          }

                          if (value != passwordController.text) {
                            return "Password doesn't match";
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        maxLines: 1,
                        hint: "Confirm your Password.",
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
                                passwordController.text)
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
                            const Icon(Icons.chevron_right)
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