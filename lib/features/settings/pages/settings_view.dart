import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/application_theme_manager.dart';
import 'package:todo_app/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final List<String> languageList = ["عربي", "English"];
  final List<String> themeList = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            lang.language,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: vm.currentTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black),
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            items: languageList,
            initialItem: vm.currentLanguage == "en" ? "English" : "عربي",
            decoration: CustomDropdownDecoration(
              closedSuffixIcon: Icon(
                Icons.arrow_drop_down_outlined,
                color: vm.isDark()
                    ? ApplicationThemeManager.primaryColor
                    : Colors.black,
              ),
              expandedSuffixIcon: Icon(
                Icons.arrow_drop_up,
                color: vm.isDark()
                    ? ApplicationThemeManager.primaryColor
                    : Colors.black,
              ),
              closedFillColor: vm.isDark() ? theme.primaryColor : Colors.white,
              expandedFillColor:
              vm.isDark() ? theme.primaryColor : Colors.white,
            ),
            onChanged: (value) async {
              if (value == "English") {
                await vm.changeLanguage("en");
              } else if (value == "عربي") {
                await vm.changeLanguage("ar");
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            lang.theme,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: vm.isDark() ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDropdown(
            items: themeList,
            initialItem: vm.isDark() ? "Dark" : "Light",
            decoration: CustomDropdownDecoration(
                closedSuffixIcon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: vm.isDark()
                      ? ApplicationThemeManager.primaryColor
                      : Colors.black,
                ),
                expandedSuffixIcon: Icon(
                  Icons.arrow_drop_up,
                  color: vm.isDark()
                      ? ApplicationThemeManager.primaryColor
                      : Colors.black,
                ),
                closedFillColor:
                vm.isDark() ? theme.primaryColor : Colors.white,
                expandedFillColor:
                vm.isDark() ? theme.primaryColor : Colors.white),
            onChanged: (value) async {
              if (value == "Light") {
                await vm.changeTheme(ThemeMode.light);
              } else if (value == "Dark") {
                await vm.changeTheme(ThemeMode.dark);
              }
            },
          ),
        ],
      ),
    );
  }
}