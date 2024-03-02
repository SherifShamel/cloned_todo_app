import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';

class FirebaseUtils {
  Future<bool> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      // print(credential.user?.email);
      SnackBarService().showSuccessMsg("Register Success");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        SnackBarService().showSuccessMsg(e.code);
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        SnackBarService()
            .showSuccessMsg(e.code);
      }
      EasyLoading.dismiss();
      return Future.value(false);
    } catch (e) {
      // print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future<bool> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      SnackBarService().showSuccessMsg("Logged in Successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');

        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');

        return Future.value(false);
      }
      EasyLoading.dismiss();
      SnackBarService().showSuccessMsg(e.code);
      return Future.value(false);
    }
  }
}