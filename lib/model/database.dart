import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Database {
  //sign in User
  //return 0 if registered
  //return -1 if error
  static Future<int> signUser(email, pass, nome, cognome, rui) async {
    int r = 0;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseFirestore.instance
          .collection('utenti')
          .doc(userCredential.user!.uid)
          .set({
        "Nome": nome,
        "Cognome": cognome,
        "Ruolo": "client",
        "CodiceRUI": [rui]
      });
      await userCredential.user!.sendEmailVerification();
      r = 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        r = -1;
      }
    }
    return r;
  }

  //login
  //return -1 if not logged
  //return 0 if logged
  static Future<int> login(email, pass, context) async {
    int r = 0;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    }

    if (user != null && !user.emailVerified) {
      ArtDialogResponse response = await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Devi prima confermare l'email",
            confirmButtonText: "OK",
            denyButtonText: "Reinvia email",
            denyButtonColor: Color(0xffDF752C),
            confirmButtonColor: Color(0xffDF752C),
          ));

      if (response.isTapDenyButton) {
        await user.sendEmailVerification();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Email inviata",
              confirmButtonColor: Color(0xffDF752C),
            ));
      }
      r = -1;
    } else if (user != null && user.emailVerified) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('utenti');
      DocumentSnapshot snap = await users.doc(user.uid).get();
      CurrentUser(
          snap["Nome"], snap["Cognome"], snap["Ruolo"], snap["CodiceRUI"]);
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Benvenuto",
            confirmButtonColor: Color(0xffDF752C),
          ));
      r = 0;
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        r = await login(email, pass, context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Email o Password errato",
                confirmButtonColor: Color(0xffDF752C),
              ));
        } else if (e.code == 'wrong-password') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Email o Password errato",
                confirmButtonColor: Color(0xffDF752C),
              ));
        }
      }
    }
    return r;
  }

  //logout
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    CurrentUser('', '', 'client', []);
  }

  //reset password
  //return -1 wrong email
  //return 0 email sent
  static Future<int> resetPassword(email, context) async {
    int r = 0;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: 'aaaaaa');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Non esiste un account con questa email",
              confirmButtonColor: Color(0xffDF752C),
            ));
        r = -1;
      } else if (e.code == 'wrong-password') {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Email inviata",
              confirmButtonColor: Color(0xffDF752C),
            ));
        r = 0;
      }
    }
    return r;
  }

  //check if agency with rui and pass exist
  static Future<bool> existAgency(rui, pass) async {
    bool r = false;
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .get()
        .then((value) {
      if (pass == value.get('PasswordRUI')) {
        r = true;
      } else {
        r = false;
      }
    }).catchError((e) {
      r = false;
    });
    return r;
  }

  static Future<void> addAgency(rui) async {
    List<String> list = CurrentUser.codRui;
    list.add(rui);
    await FirebaseFirestore.instance
        .collection('utenti')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'CodiceRUI': list})
        .then((value) {})
        .catchError((error) {});
  }
}
