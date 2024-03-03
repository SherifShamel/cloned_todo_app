import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  static showSuccessMsg(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) {
        return Material(
          child: Container(
            child: Text(msg),
            decoration: BoxDecoration(
                color: Colors.green.shade100
            ),
          ),
        );
      },
      duration: const Duration(
        seconds: 3,
      ),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
  showErrorMsg(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) {
        return Material(
          child: Container(
            child: Text(msg),
            decoration: BoxDecoration(
                color: Colors.green.shade100
            ),
          ),
        );
      },
      duration: const Duration(
        seconds: 3,
      ),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
}